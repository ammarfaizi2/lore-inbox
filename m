Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270788AbVBEUBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270788AbVBEUBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270181AbVBETzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:55:12 -0500
Received: from aun.it.uu.se ([130.238.12.36]:15012 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S270187AbVBETtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:49:45 -0500
Date: Sat, 5 Feb 2005 20:49:05 +0100 (MET)
Message-Id: <200502051949.j15Jn5bH003923@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: agruen@suse.de
Subject: Re: ext3 extended attributes refcounting wrong?
Cc: adilger@clusterfs.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sct@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 15:20:00 +0100, Andreas Gruenbacher wrote:
>On Sat, 2005-02-05 at 13:39, Mikael Pettersson wrote:
>> [...] It does not explain why 2.6 allocated
>> the xattr blocks in the first place; as I wrote initially, I
>> have disabled the xattrs stuff:
>> 
>> CONFIG_EXT3_FS=y
>> # CONFIG_EXT3_FS_XATTR is not set
>
>The filesystem in question must have been used with a kernel that was
>xattr aware once. You could also have been using ext2. Maybe you ran
>selinux at some point, or similar. Can you boot into a kernel with
>CONFIG_EXT3_FS_XATTR enabled, and ``getfattr -m- -d -R .'' on the
>filesystem in question? This gives you a full xattr dump.

Done. According to that command, there are no xattrs anywhere
on any of the affected file systems. So it seems my self-compiled
xattr-disabled 2.6 kernels aren't to blame.

That leaves either the FC2 or FC3 installer kernels: one of
them must have created the xattrs. I don't know why/when they
were leaked, but this is consistent with the fact that I've
only seen fsck complain about the xattr blocks once on any
given file system.

Sorry about the false alarm.

/Mikael
