Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTKBXJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 18:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTKBXJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 18:09:33 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:30919 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S261780AbTKBXJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 18:09:31 -0500
Date: Mon, 3 Nov 2003 00:09:24 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] Linux-2.6.0-test9
Message-Id: <20031103000924.494d960f.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__3_Nov_2003_00_09_24_+0100_utjamqzz6sQmAjzv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Nov_2003_00_09_24_+0100_utjamqzz6sQmAjzv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Hi,

Following oops just happened with Linux-2.6.0-test9. All filesystems are ext3,
except for /dev/hda6 which is ext3 over aes-cryptoloop.

-Udo.


Unable to handle kernel paging request at virtual address 50d35f7c
 printing eip:
c016c912
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c016c912>]    Not tainted
EFLAGS: 00010246
EIP is at __d_lookup+0xf2/0x150
eax: 50d35f7c   ebx: d1d35f00   ecx: 00000004   edx: d1d35f64
esi: 50d35f7c   edi: d7329000   ebp: d1d35f70   esp: d4ed7e68
ds: 007b   es: 007b   ss: 0068
Process sylpheed (pid: 19589, threadinfo=d4ed6000 task=d3dfa0a0)
Stack: d7fdd6c0 000796b7 00001000 00000000 d7f46aa0 d4ed6000 c0190473 00000000 
       d7329000 00d03008 00000004 d7329000 d4ed7f38 d7ff4660 d4ed7ee4 c0161f30 
       d21db820 d4ed7eec d21db820 d7329000 d4ed7ee4 d4ed7f38 d4ed7eec c016245f 
Call Trace:
 [<c0190473>] ext3_getblk+0x93/0x280
 [<c0161f30>] do_lookup+0x30/0xb0
 [<c016245f>] link_path_walk+0x4af/0x940
 [<c0162df9>] __user_walk+0x49/0x60
 [<c015dd2f>] vfs_stat+0x1f/0x60
 [<c015e4cb>] sys_stat64+0x1b/0x40
 [<c010942b>] syscall_call+0x7/0xb

Code: f3 a6 75 9d 8b 44 24 14 ff 40 14 8b 54 24 0c 3b 53 58 75 0c 
 <6>note: sylpheed[19589] exited with preempt_count 1

--Signature=_Mon__3_Nov_2003_00_09_24_+0100_utjamqzz6sQmAjzv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pY6qnhRzXSM7nSkRAisDAJ9ktegm4TO4Vb9IO1nPEGLOCAdjpwCeKzIe
45wM9ooLknm97FT+zbQQi/8=
=fWQ3
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Nov_2003_00_09_24_+0100_utjamqzz6sQmAjzv--
