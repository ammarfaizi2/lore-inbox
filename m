Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVJBUBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVJBUBM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVJBUBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:01:12 -0400
Received: from pop.gmx.de ([213.165.64.20]:50095 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932065AbVJBUBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:01:11 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc2-mm2 (NULL pointer)
Date: Sun, 2 Oct 2005 22:06:22 +0200
User-Agent: KMail/1.8.91
Cc: linux-kernel@vger.kernel.org
References: <20050929143732.59d22569.akpm@osdl.org>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1779598.faSIDQ2il3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510022206.36291.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1779598.faSIDQ2il3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 September 2005 23:37, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/=
2.
>6.14-rc2-mm2/

hi,
I'm not sure if this error depends on the loaded quickcam module, which isn=
't=20
in standard kernels.
Here is the dmesg output, hth.

usb 1-2.3: USB disconnect, address 7
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
<ffffffff801ba567>{sysfs_remove_group+23}
PGD 320e0067 PUD 320d9067 PMD 0
Oops: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in: video quickcam nls_cp437 vfat fat ppp_deflate zlib_defla=
te=20
bsd_comp ppp_async radeonfb r8169 snd_bt87x
Pid: 11, comm: khubd Not tainted 2.6.14-rc2-mm2 #17
RIP: 0010:[<ffffffff801ba567>] <ffffffff801ba567>{sysfs_remove_group+23}
RSP: 0018:ffff81003fd85d18  EFLAGS: 00010286
RAX: 0000000000000001 RBX: ffff8100297e1e50 RCX: 0000000000000000
RDX: ffff810019339118 RSI: 0000000000000000 RDI: ffff81002a28e7e0
RBP: ffff81003fd85d38 R08: 0000000000000000 R09: ffff81003f881640
R10: 0000000000000000 R11: 0000000000010207 R12: 0000000000000000
R13: ffff81002a28e7e0 R14: ffff81002a28e690 R15: ffff81003f8c4918
=46S:  00002aaaad71d520(0000) GS:ffffffff8067e800(0000) knlGS:0000000056114=
840
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000320a3000 CR4: 00000000000006e0
Process khubd (pid: 11, threadinfo ffff81003fd84000, task ffff81003fe380a0)
Stack: ffff810027911968 ffff8100297e1e50 0000000000000000 ffff81002a28e7e0
       ffff81003fd85d58 ffffffff80240996 ffff81002f14b438 0000000000000001
       ffff81003fd85d88 ffffffff8024137d
Call Trace:<ffffffff80240996>{usb_remove_ep_files+22}=20
<ffffffff8024137d>{usb_remove_sysfs_intf_files+61}
       <ffffffff8023e274>{usb_disable_device+132}=20
<ffffffff80238bfe>{usb_disconnect+190}
       <ffffffff8023a1d3>{hub_thread+963}=20
<ffffffff80421c6f>{thread_return+203}
       <ffffffff8014c1e0>{autoremove_wake_function+0}=20
<ffffffff80130120>{__wake_up_common+64}
       <ffffffff8014c1e0>{autoremove_wake_function+0}=20
<ffffffff80239e10>{hub_thread+0}
       <ffffffff8014ba9b>{kthread+219} <ffffffff8010ef62>{child_rip+8}
       <ffffffff8014b9c0>{kthread+0} <ffffffff8010ef5a>{child_rip+0}


Code: 48 8b 1e 49 89 fd 48 85 db 74 1e 48 89 df e8 16 7b 06 00 49
RIP <ffffffff801ba567>{sysfs_remove_group+23} RSP <ffff81003fd85d18>
CR2: 0000000000000000


dominik

--nextPart1779598.faSIDQ2il3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQ0A9zAvcoSHvsHMnAQLfzgP/VG+AkMslwSjhrrVUmEcyOo9bBLelvN7e
Az+kOveCN/oh7RgLLTwEeT/LZaauyXJ9vtIyWxJH0C7IDN1Iau6joizW/qanQwpt
T2Yd9A0a3zfT/8O7G8A7zC8iFT2kK/Q0DI/F0XqfRAxrC6rtNfh9dBYPz27kDgVp
oL9n+CI0znU=
=TItN
-----END PGP SIGNATURE-----

--nextPart1779598.faSIDQ2il3--
