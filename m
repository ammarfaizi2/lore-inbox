Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTHQL52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 07:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTHQL52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 07:57:28 -0400
Received: from binky.tuxfriends.net ([212.105.197.44]:5382 "EHLO
	binky.tuxfriends.net") by vger.kernel.org with ESMTP
	id S265624AbTHQL51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 07:57:27 -0400
Message-ID: <3F3F6E38.9070002@zaplinski.de>
Date: Sun, 17 Aug 2003 13:59:52 +0200
From: Olaf Zaplinski <olaf@zaplinski.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test3 does not mount root fs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-KAVCheck: binky.tuxfriends.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.0-test3 cannot mount my root fs, it says 'mounting root fs (ntfs) read 
only' and then complains that there is no init. 2.4.20 runs fine.

my lilo.conf:

lba32
compact
menu-scheme=Wg:kw:Wg:Wg
boot=/dev/hda
install=/boot/boot-menu.b
map=/boot/map
prompt
timeout=30

image=/boot/vmlinuz-2.6.0-test3
         root=/dev/hda3
         label=2.6.0-test3
         append="reboot=warm"
         read-only

image=/boot/vmlinuz-2.4.20
         root=/dev/hda3
         label=Linux-2.4.20
         # append="reboot=warm video=riva:1024x768-8@60"
         append="reboot=warm"
         read-only


my fstab:

/dev/hda3    /            reiserfs        notail          0       0
/dev/hda7    none         swap            sw              0       0
proc         /proc        proc            defaults        0       0
/dev/fd0     /floppy      auto            user,noauto     0       0
/dev/cdrom   /cdrom       iso9660         ro,user,noauto  0       0
/dev/hda5    /ntfs        ntfs            ro,gid=users,umask=002  0       0

Olaf

