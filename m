Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269741AbUJMOhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269741AbUJMOhC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269742AbUJMOeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:34:06 -0400
Received: from zamok.crans.org ([138.231.136.6]:53682 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S269727AbUJMOdO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:33:14 -0400
To: "Harald Dunkel" <harald.dunkel@t-online.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ?
References: <1097446129l.5815l.0l@werewolf.able.es>
	<20041012001901.GA23831@kroah.com> <416B91C4.7050905@t-online.de>
	<20041012165809.GA11635@kroah.com> <416C26B4.6040408@t-online.de>
	<20041012185733.GA31222@kroah.com> <416C3BB6.4040200@t-online.de>
	<20041012203022.GB32139@kroah.com> <416C4E15.9000503@t-online.de>
	<87vfde3gvs.fsf@barad-dur.crans.org> <416D380E.4080202@t-online.de>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 13 Oct 2004 16:33:12 +0200
In-Reply-To: <416D380E.4080202@t-online.de> (Harald Dunkel's message of "Wed,
	13 Oct 2004 16:13:34 +0200")
Message-ID: <87fz4i3cyf.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Harald Dunkel" <harald.dunkel@t-online.de> disait dernièrement que :

>
> And then?
>
> The sources of kinit show that its job is parse the kernel
> command line arguments, configure the NIC, mount the root
> filesystem via NFS, etc. Other configurations might require
> a different init to start hotplug and udev, or to handle the
> LVM and crypto magic, for example. My point is that if there
> is no one-for-all init process to handle _every_ possible
> startup procedure, then it might be necessary to rebuild the
> initramfs. This would be easier (and easier to test) if
> initramfs is not compiled into the kernel, but a separate
> image to be loaded at boot time "somehow".
>

yep to test it would be helpful. To setup mine, it took not long, but sure
such a facility could help. But you know, if you do not run make clean, and you
have edited usr/Makefile to not rebuild initramfs, puting your custom cpio
archive into usr and typing 'make' won't take long to rebuild the new kernel :)
I did that to get it working.

As to know if having an external archive file loaded by grub or so, I don't
know much that part of the kernel code... Hum, I really did not try to under-
stand the code involving initrd's and initramfs in init/do_mounts_initrd.c.
I wonder whether putting an executable /init in an initrd is sufficient to
have it recognized as an initramfs and not an initrd....

The important thing is /init executable script in initramfs, this is what
tells the kernel to override the "standard" way it boots.

Mathieu

-- 
The policy is not to have policy. It works as well in kernel design as politics.

	- Alan Cox on linux-kernel

