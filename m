Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUFQNxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUFQNxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUFQNxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:53:30 -0400
Received: from mail1.kontent.de ([81.88.34.36]:9152 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266495AbUFQNxL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:53:11 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: oops unmounting offlined dvd
Date: Thu, 17 Jun 2004 15:52:41 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406171553.07269.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

this oops occured unmounting a SCSI DVD (dc395 driver) under 2.6.7-rc3
UP, athlon, nopreempt. It had an iso filesystem on it.

	Regards
		Oliver

Jun 17 15:28:37 oenone kernel: Buffer I/O error on device sr0, logical block 1555516
Jun 17 15:28:37 oenone kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 17 15:28:37 oenone kernel: Buffer I/O error on device sr0, logical block 1555515
Jun 17 15:28:37 oenone kernel: Buffer I/O error on device sr0, logical block 1555516
Jun 17 15:28:37 oenone kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 17 15:28:37 oenone kernel: Buffer I/O error on device sr0, logical block 1555515
Jun 17 15:28:37 oenone kernel: Buffer I/O error on device sr0, logical block 1555516
Jun 17 15:28:37 oenone kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 17 15:28:37 oenone kernel: Buffer I/O error on device sr0, logical block 1555515
Jun 17 15:28:37 oenone kernel: Buffer I/O error on device sr0, logical block 1555516
Jun 17 15:28:41 oenone kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Jun 17 15:28:41 oenone kernel:  printing eip:
Jun 17 15:28:41 oenone kernel: c02d051e
Jun 17 15:28:41 oenone kernel: *pde = 00000000
Jun 17 15:28:41 oenone kernel: Oops: 0000 [#1]
Jun 17 15:28:41 oenone kernel: Modules linked in: nls_iso8859_1 udf radeon st ide_cd nvram usbserial usblp usbhid nfsd exportfs ipt_MASQUERADE iptable_nat ip_conntrack ip_tables vfat fat
Jun 17 15:28:41 oenone kernel: CPU:    0
Jun 17 15:28:41 oenone kernel: EIP:    0060:[<c02d051e>]    Not tainted
Jun 17 15:28:41 oenone kernel: EFLAGS: 00210297   (2.6.7-rc3) 
Jun 17 15:28:41 oenone kernel: EIP is at cdrom_release+0x1e/0x120
Jun 17 15:28:41 oenone kernel: eax: 00000018   ebx: 00000018   ecx: c02b8f40   edx: 00000000
Jun 17 15:28:41 oenone kernel: esi: 00000000   edi: ccc7c20c   ebp: 00000000   esp: cc7bdf30
Jun 17 15:28:41 oenone kernel: ds: 007b   es: 007b   ss: 0068
Jun 17 15:28:41 oenone kernel: Process umount (pid: 21423, threadinfo=cc7bc000 task=cdd66e30)
Jun 17 15:28:41 oenone kernel: Stack: 00000000 cc7bdf34 ccc7c200 00000000 ccc7c20c cffe8398 c02b8f5e ccc7c200 
Jun 17 15:28:41 oenone kernel:        ccc7c264 c0153d75 00000000 cfd9c800 c045e5a0 00000000 cc7bc000 c0152203 
Jun 17 15:28:41 oenone kernel:        00000000 cc7bdf7c c0164dbb c5ec42a0 cffc9960 c01428ee 401ab000 4018b000 
Jun 17 15:28:41 oenone kernel: Call Trace:
Jun 17 15:28:41 oenone kernel:  [<c02b8f5e>] sr_block_release+0x1e/0x70
Jun 17 15:28:41 oenone kernel:  [<c0153d75>] blkdev_put+0xb5/0x130
Jun 17 15:28:41 oenone kernel:  [<c0152203>] deactivate_super+0x43/0x60
Jun 17 15:28:41 oenone kernel:  [<c0164dbb>] sys_umount+0x3b/0x90
Jun 17 15:28:41 oenone kernel:  [<c01428ee>] unmap_vma_list+0xe/0x20
Jun 17 15:28:41 oenone kernel:  [<c0164e27>] sys_oldumount+0x17/0x20
Jun 17 15:28:41 oenone kernel:  [<c0105e2f>] syscall_call+0x7/0xb
Jun 17 15:28:41 oenone kernel: 
Jun 17 15:28:41 oenone kernel: Code: 8b 38 0f 84 ac 00 00 00 8b 43 20 85 c0 7e 04 48 89 43 20 85 
Jun 17 15:30:08 oenone kernel:  <6>agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Jun 17 15:30:08 oenone kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Jun 17 15:30:08 oenone kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode

oliver@oenone:~> umount -V
umount: mount-2.12
oliver@oenone:~>

/dev/sr0 on /media/dvd type iso9660 (ro)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0aIvbuJ1a+1Sn8oRAm+tAKDg5TN1ovs9E552Ovz7yQuwvcYF0wCcDJRP
8QGA+WxADBGBmu25ZYVeS1k=
=wYsq
-----END PGP SIGNATURE-----
