Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVGZX2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVGZX2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVGZXXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:23:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:62140 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262335AbVGZXVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:21:47 -0400
X-Authenticated: #1725425
Date: Wed, 27 Jul 2005 01:21:14 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Mike Mohr <akihana@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reclaim space from unused ramdisk?
Message-Id: <20050727012114.59a33298.Ballarin.Marc@gmx.de>
In-Reply-To: <4746469c05072615167ca234ce@mail.gmail.com>
References: <4746469c05072615167ca234ce@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005 15:16:58 -0700
Mike Mohr <akihana@gmail.com> wrote:

> I wonder if it would be possible to somehow reclaim space that has
> been previously reserved for a ramdisk without rebooting.  I read the
> ramdisk docs in the latest kernel source and it seems that it is not
> currently possible.  However, the kernel keeps track of the memory
> allocated for said ramdisks; would it not be possible with root (or
> even kernel) permissions to remove the flag that prevents the VM
> subsystem from reclaiming that space?  I realize that rot permissions
> may not be high enough.  In that case, could a module be written that
> takes a device name as a parameter then uses it to look up the
> reserved memory that device uses, then resets the necessary flag and
> finally unloads itself?  It would have to check that the filesystem
> was unmounted, of course.
> 
> How difficult would this be to write?

Hi,

ramfs (always there) and tmpfs (optional) already do this.
tmpfs can be swapped out, ramfs always uses physical memory.

mount -t ramfs none /mnt/blah
mount -t tmpfs none /mnt/blah

Regards
