Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUGEWxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUGEWxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 18:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUGEWxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 18:53:22 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:50127 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261914AbUGEWxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 18:53:18 -0400
Date: Mon, 5 Jul 2004 15:53:11 -0700
From: Chris Wedgwood <cw@f00f.org>
To: surfing t <surf17@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Points to fs architecture
Message-ID: <20040705225311.GA697@taniwha.stupidest.org>
References: <20040705213858.2002086AE1@ws7-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705213858.2002086AE1@ws7-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 04:38:58PM -0500, surfing t wrote:

> I want to create a utility that "hooks" into the the filesystem.

OK

> What I want to do is to be able to review all file system
> read/write/seek requests, most of the time without affecting file
> system operation (ie after review the request is passed on to the
> entity that would have received it had my utility not been
> installed, however some of the requests my driver should handle
> itself.

Strictly speaking what you want then is not going to be at the
filesystem layer, since the filesystem layer doesn't generally see
seeks, writes, etc.

It sounds like you want to instrument the system calls, look at the
man pages for 'strace' and similar.

> Basically I just want to "hijack" the system calls that applications
> use to access files and then pass them on to the original system
> call.  Is this possible and how do I do it?

The ptrace system call and a little effort will let you do this.  You
can also use LD_PRELOAD and over-ride some glibc hooks for the file IO
operations --- there are plenty of things that do this I'm sure
already.


  --cw
