Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUANBVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUANBVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:21:01 -0500
Received: from [12.177.129.25] ([12.177.129.25]:25539 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S265118AbUANBU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:20:59 -0500
Date: Tue, 13 Jan 2004 20:42:09 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] /dev/anon
Message-ID: <20040114014209.GA4301@ccure.user-mode-linux.org>
References: <200401132021.i0DKLBhg002890@ccure.user-mode-linux.org> <Pine.LNX.4.44.0401131236140.12810-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401131236140.12810-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 12:38:05PM -0800, Davide Libenzi wrote:
> Now I'm going to say something really stupid, but why sys_madvise(MADV_DONTNEED)
> won't work for this?
> 

MADV_DONTNEED is fine for anonymous memory, but it can't make a filesystem
throw out data, which is what I need.  If it did, then people wouldn't be
agitating for sys_punch.

				Jeff
