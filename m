Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTLSKFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 05:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTLSKFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 05:05:32 -0500
Received: from csbd.org ([66.220.23.20]:2977 "EHLO csbd.org")
	by vger.kernel.org with ESMTP id S262181AbTLSKFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 05:05:31 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
Date: Fri Dec 19 01:58:49 2003
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: 7bit
Message-Id: <20031219095849.A646A1E030CA3@csbd.org>
From: atp@csbd.org (Alexander Poquet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

  WLI3> Could you post your lilo.conf and/or grub.conf and /etc/fstab?

Certainly.  Thanks a lot for the reply.

Alexander

lilo.conf follows (I removed verbose Debian comments to save you time):
-------------------------------------------------------------------------------
lba32
boot=/dev/hda
root=/dev/hda1
install=menu
map=/boot/map
delay=20
prompt
timeout=150
vga=normal
default=Linux
image=/boot/bzImage-2.6.0
        label=Linux
        read-only
image=/boot/bzImage-2.4.18
        label=LinuxOLD
        read-only
        optional

-------------------------------------------------------------------------------
fstab follows:
-------------------------------------------------------------------------------
# <file system> <mount point>   <type>  <options>               <dump>  <pass>
/dev/hda1       /               ext2    errors=remount-ro       0       1
/dev/hda2       none            swap    sw                      0       0
proc            /proc           proc    defaults                0       0
/dev/fd0        /floppy         auto    user,noauto             0       0
/dev/fd0        /floppy-vfat    vfat    user,noauto             0       0
/dev/cdrom      /cdrom          iso9660 ro,user,noauto          0       0
/dev/hda5       /tmp    ext2    defaults                        0       2
/dev/hda6       /var    ext2    defaults                        0       2
/dev/hda7       /usr    ext2    defaults                        0       2
/dev/hda4       /home   ext2    defaults                        0       2
