Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTHTUHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTHTUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:07:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:61645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262188AbTHTUHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:07:51 -0400
Date: Wed, 20 Aug 2003 12:53:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: posix_fallocate question again
Message-Id: <20030820125301.3a1ed0fb.akpm@osdl.org>
In-Reply-To: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com>
References: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> This has been brought up by Ulrich more than 3 years ago:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=95569775802945&w=2

A decent fallocate() implementation requires that the underlying fs has a
permanent representation of blocks which are in an "allocated,
uninitialised" state.  afaik XFS is the only such filesystem.

It's a fair bit of work for what doesn't really sound a very useful
feature.  Doing it in libc is reasonable.  Probably the libc implementation
could be improved by using ioctl(FIBMAP) and O_DIRECT to mimimise IO and
CPU utilisation.

> Is there anytime soon that kernel 2.6 will have such functionality?

Nope.

