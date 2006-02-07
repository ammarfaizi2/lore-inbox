Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWBGUji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWBGUji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWBGUji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:39:38 -0500
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:43444 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id S1750792AbWBGUji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:39:38 -0500
Message-ID: <43E90573.8040305@l4x.org>
Date: Tue, 07 Feb 2006 21:39:15 +0100
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051017 Thunderbird/1.0.7 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.2.134
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have
 a nice day...
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on ds666.starfleet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debian 2.6.15-1-686-smp

$ umount /mnt/data
Segmentation Fault

dmesg:

VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Unable to handle kernel NULL pointer dereference at virtual address 00000034
 printing eip:
f88c7e07
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: xfs rfcomm l2cap bluetooth nfsd exportfs lockd nfs_acl sunrpc  ipv6 deflate zlib_deflate twofish serpent aes blowfish des sha256
sha1 crypto_n ull af_key raid5 xor dm_mod tun vfat fat loop lp usbmouse eeprom i2c_dev i2c_isa  i2c_core usbkbd usb_storage ehci_hcd button processor
ac ide_cd cdrom e100 mii 3w_xxxx e1000 joydev piix serio_raw uhci_hcd generic parport_pc ide_core usbcore  parport pcspkr psmouse rtc ext3 jbd mbcache
raid1 md_mod sd_mod aic79xx scsi_tr ansport_spi scsi_mod shpchp pci_hotplug evdev mousedev
CPU:    2
EIP:    0060:[<f88c7e07>]    Not tainted VLI
EFLAGS: 00210282   (2.6.15-1-686-smp)
EIP is at ext3_show_options+0x13/0xd5 [ext3]
eax: 00000000   ebx: f7f1fe00   ecx: da82c540   edx: 00000000
esi: da82c540   edi: da82c540   ebp: 00000400   esp: f7bcbf18
ds: 007b   es: 007b   ss: 0068
Process mv (pid: 4409, threadinfo=f7bca000 task=e9978a70)
Stack: 00000000 dfd74c00 c01646cf da82c540 dfd74c00 da82c540 dfd74c00 00000143
       c0167ffd da82c540 dfd74c00 00000000 da82c560 0000000a 00000000 00000009
       00000000 00000400 e64cea80 40019000 00000000 c014ca9d e64cea80 40019000
Call Trace:
 [<c01646cf>] show_vfsmnt+0xcf/0xe6
 [<c0167ffd>] seq_read+0x199/0x26a
 [<c014ca9d>] vfs_read+0xa1/0x138
 [<c014cd92>] sys_read+0x3b/0x64
 [<c010275b>] sysenter_past_esp+0x54/0x75
Code: e8 9c 64 ff ff c7 43 b8 00 00 00 00 59 89 74 24 0c 5b 5e e9 9f 34 87 c7 56  53 8b 44 24 10 8b 74 24 0c 8b 58 14 8b 83 70 01 00 00 <8b> 40 34 25
00 0c 00 00  3d 00 04 00 00 75 07 68 ec 04 8d f8 eb
 ------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:294!
invalid operand: 0000 [#2]
SMP
Modules linked in: xfs rfcomm l2cap bluetooth nfsd exportfs lockd nfs_acl sunrpc  ipv6 deflate zlib_deflate twofish serpent aes blowfish des sha256
sha1 crypto_n ull af_key raid5 xor dm_mod tun vfat fat loop lp usbmouse eeprom i2c_dev i2c_isa  i2c_core usbkbd usb_storage ehci_hcd button processor
ac ide_cd cdrom e100 mii 3w_xxxx e1000 joydev piix serio_raw uhci_hcd generic parport_pc ide_core usbcore  parport pcspkr psmouse rtc ext3 jbd mbcache
raid1 md_mod sd_mod aic79xx scsi_tr ansport_spi scsi_mod shpchp pci_hotplug evdev mousedev
CPU:    2
EIP:    0060:[<c0158262>]    Not tainted VLI
EFLAGS: 00210246   (2.6.15-1-686-smp)
EIP is at __follow_mount+0x4b/0x6d
eax: 00000000   ebx: dfd74c00   ecx: 00000001   edx: f75bed20
esi: 00000000   edi: f79f1ecc   ebp: dfea6180   esp: f79f1e6c
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 4481, threadinfo=f79f0000 task=f7079030)
Stack: f7801690 f79f1f68 f79f1ecc c015837e f79f1ecc b6b2be6c f66e129c db8b0005
       f79f1f68 c0158b78 f79f1f68 f79f1ec0 f79f1ecc db8b000b 00000000 c1880c20
       00000003 00000000 dfde8f48 dfde8e9c 000000c2 b6b2be6c 00000006 db8b0005
Call Trace:
 [<c015837e>] do_lookup+0x3a/0x7c
 [<c0158b78>] __link_path_walk+0x7b8/0xbe8
 [<c0158ff3>] link_path_walk+0x4b/0xbf
 [<c011c2fb>] __do_softirq+0x57/0xc0
 [<c0159357>] path_lookup+0x13a/0x142
 [<c015955e>] __user_walk+0x23/0x3a
 [<c0154c5f>] sys_readlink+0x20/0x91
 [<c011c2fb>] __do_softirq+0x57/0xc0
 [<c010275b>] sysenter_past_esp+0x54/0x75
Code: 80 00 00 85 f6 58 74 14 8b 07 85 c0 74 0e c7 40 30 00 00 00 00 50 e8 3f c2  00 00 58 89 1f 8b 53 10 85 d2 74 11 8b 02 85 c0 75 08 <0f> 0b 26 01
69 4a 28 c0  f0 ff 02 89 57 04 be 01 00 00 00 8b 47

Filesystem is (was?) ext3 on lvm2 on raid5 on 5 IDE drives on 3ware
controller. Accessing the mount point crashed the machine. Last Words:
http://l4x.org/misc/imgp1483.jpg
After reboot everything back to normal, fsck didn't find any errors.
Right before unmouting I moved around 450gb off from the raid to
another raid on the same controller, so controller seems to be fine and
I don't think that the harddisks fail in such a subtle way, that the
raid consistency isn't affected.

Not reproducable but perhaps helpful or important nevertheless.
Funny message in any case ;-)

Jan
