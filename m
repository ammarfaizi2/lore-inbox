Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUHVNba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUHVNba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHVNba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:31:30 -0400
Received: from mx-00.sil.at ([62.116.68.196]:3090 "EHLO mx-00.sil.at")
	by vger.kernel.org with ESMTP id S266894AbUHVNb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:31:27 -0400
Subject: Re: Nonotify 0.3.2 (A simple dnotify replacement)
From: nf <nf2@scheinwelt.at>
Reply-To: nf2@scheinwelt.at
To: Pascal Schmidt <der.eremit@email.de>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1ByrTz-00003r-8U@localhost>
References: <2vRn8-1D3-9@gated-at.bofh.it>  <E1ByrTz-00003r-8U@localhost>
Content-Type: text/plain
Message-Id: <1093181664.4542.47.camel@lilota.lamp.priv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-2mdk 
Date: Sun, 22 Aug 2004 15:34:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 14:29, Pascal Schmidt wrote:
> On Sun, 22 Aug 2004 05:40:06 +0200, you wrote in linux.kernel:
> 
> > 2) The /dev/nonotify device:
> >
> > /dev/nonotify has the only purpose to offer a special stat() call via
> > ioctl to read the contents_mtime field of directories (together with
> > atime, mtime, ctime). The client has to set the 'filename' field of the
> > 'nonotify_stat' structure and receives the four timespec fields updated
> > via ioctl.
> 
> A lot of people here (Linus, for instance) frown on ioctl() interfaces.
> They're hard to do right in 32/64bit compat layers, for example. How
> about using a syscall interface instead?

Nonotify uses ioctl mainly for 'pragmatical' reasons. A syscall would be
technically better - that's for sure, actually it was my initial idea to
use one (or to change the stat-call).

But i didn't want to bother people with asking to assign me a
syscall-number before even knowing if they like my idea. And changing it
to use a syscall lateron would be no problem at all from the concept of
nonotify.

Also - as a kernel newbie - i didn't find any good documentation how to
add my own syscall into the kernel. I just wanted to get nonotify
working as an 'optional patch', without changing tons of files.

But you could help me if you have a look at my ioctl function. I'm using
a structure which contains a char* pointer and four timespec fields. Do
you know if this causes problems with 32/64bit compatibility.

Thanks,

Norbert














