Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVHYSPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVHYSPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVHYSPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:15:16 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:53980 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1751391AbVHYSPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:15:15 -0400
Date: Thu, 25 Aug 2005 14:15:13 -0400 (EDT)
Message-Id: <200508251815.j7PIFDGe026463@ms-smtp-02.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13c
From: robotti@godmail.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   >Could you please please pretty please get an RFC compliant mailer that
   >generates  "In-Reply-To" and preferable even "References" headers?
   >Right
   >now every mail you write starts a new thread instead of referencing to
   >the previous one. See http://lkml.org/lkml/2005/8/25/180/ to see what
   >I mean.

I'm not subscribed to the list and I use lynx and a small mda
called msmtp, so I know it's awkward (perhaps mostly for me).

But, that's my setup.

Perhaps if the list had a followup/reply option, I could use that in lynx.

But, the list just seems to be useful for reading purposes.

Perhaps I could access the list through a newsreader and the
replys would be threaded/referenced.

   >Cpio is perhaps as available as tar, but it's not as used as tar.
   >>So? Firefox is as available as IE, but it's not as used as IE. Does
   >>that make IE better?
   
I have no opinion on which one is better.
   
I prefer tar because I have more experience with it, and it works.
   
It seems to be the most used archiver in the UNIX world.
   
   >Unless tar would be inordinately larger than a cpio implementation
   >(I can't imagine, but I'm not a coder!) I would prefer it.
   >>You have been told a couple of times that a tar implementation in
   >>kernel is indeed larger than a cpio implementation. If you're not a
   >>coder, just believe the coders.
   
No one has explicitly told me that. 
   
   >If initramfs replaces the old initrd method it should have something
   >as a filesystem that's robust and inspires confidence like ext2.
   >>The simplicity of ramfs inspires more than enough confidence.
   
   >I know generally an initrd is used to load modules and prepare
   >the installation of a Linux system, so it doesn't require much
   >in a filesystem.
   >>An initramfs can be used to do the same, but doesn't have the overhead
   >>of a block device. IOW: it requires even *less* than an initrd.
   
Right, an initramfs can/should replace the old initrd method, but
it should be comparable and have a filesystem like tmpfs as an option.
   
The old initrd method could use any filesystem for the initrd
that the kernel could support, but now with initramfs all you
have is ramfs.
    
If you add tmpfs to initramfs you make initramfs comparable enough
(on the filesystem level) to replace the old initrd method.
   
Initramfs is already ahead of the old initrd method on other levels.
     
   >But, it can also be used to hold and run a complete Linux system,
   >so a more robust filesystem (tmpfs) is useful.
   >>What makes you think tmpfs is more robust than ramfs? What do you mean
   >>with a "robust filesystem"?

I've used tmpfs and ramfs, so it's based on experience.

I'm sure someone could give you a more technical answer, but if
you're a coder you would probably already know.

For one, if you do "dd if=/dev/zero of=foo" on a ramfs the system
will lock up.
