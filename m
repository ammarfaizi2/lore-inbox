Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTKBXTR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 18:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTKBXTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 18:19:17 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:32967 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S261869AbTKBXTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 18:19:15 -0500
Date: Mon, 3 Nov 2003 00:19:13 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] Linux-2.6.0-test9
Message-Id: <20031103001913.612795b3.us15@os.inf.tu-dresden.de>
In-Reply-To: <20031103000924.494d960f.us15@os.inf.tu-dresden.de>
References: <20031103000924.494d960f.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__3_Nov_2003_00_19_13_+0100_UGr3mvV0mh/GpP+d"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Nov_2003_00_19_13_+0100_UGr3mvV0mh/GpP+d
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2003 00:09:24 +0100 Udo A. Steinberg (UAS) wrote:

UAS> Unable to handle kernel paging request at virtual address 50d35f7c
UAS>  printing eip:
UAS> c016c912
UAS> *pde = 00000000
UAS> Oops: 0000 [#2]

I just noticed that my last report was actually the second OOPS in a whole
series. Here is the first one.

-Udo.

Unable to handle kernel paging request at virtual address 50d35f7c
printing eip:
c016c912
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c016c912>]    Not tainted
EFLAGS: 00010246
EIP is at __d_lookup+0xf2/0x150   
eax: 50d35f7c   ebx: d1d35f00   ecx: 00000004   edx: d1d35f64
esi: 50d35f7c   edi: d650e000   ebp: d1d35f70   esp: d3c85e68
ds: 007b   es: 007b   ss: 0068                               
Process sylpheed (pid: 265, threadinfo=d3c84000 task=d3dfa6c0)
Stack: d7ff4660 d3c85ee4 c0109598 00000000 d7f46aa0 d3c84000 d3c85f38 00000000
       d650e000 00d03008 00000004 d650e000 d3c85f38 d7ff4660 d3c85ee4 c0161f30
       d21db820 d3c85eec d21db820 d650e000 d3c85ee4 d3c85f38 d3c85eec c016245f
Call Trace:
 [<c0109598>] common_interrupt+0x18/0x20
 [<c0161f30>] do_lookup+0x30/0xb0
 [<c016245f>] link_path_walk+0x4af/0x940
 [<c0162df9>] __user_walk+0x49/0x60
 [<c015dd2f>] vfs_stat+0x1f/0x60
 [<c015e4cb>] sys_stat64+0x1b/0x40      
 [<c010942b>] syscall_call+0x7/0xb

Code: f3 a6 75 9d 8b 44 24 14 ff 40 14 8b 54 24 0c 3b 53 58 75 0c
 <6>note: sylpheed[265] exited with preempt_count 1      


--Signature=_Mon__3_Nov_2003_00_19_13_+0100_UGr3mvV0mh/GpP+d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pZDxnhRzXSM7nSkRApA+AJ4soU3pmW+8hP/cRV42eJj+mDO43gCfdQn4
mPJQ4XX3kKJZ/xVYYCp9yBA=
=Wssp
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Nov_2003_00_19_13_+0100_UGr3mvV0mh/GpP+d--
