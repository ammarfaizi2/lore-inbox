Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSKKRT4>; Mon, 11 Nov 2002 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265859AbSKKRT4>; Mon, 11 Nov 2002 12:19:56 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:48328 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S265854AbSKKRTz>; Mon, 11 Nov 2002 12:19:55 -0500
Date: Mon, 11 Nov 2002 18:26:41 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kraxel@bytesex.org
Subject: 2.5.47: Uninitialized timer in bttv code
Message-Id: <20021111182641.104131b6.us15@os.inf.tu-dresden.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws117 (GTK+ 1.2.10; Linux 2.5.47)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.w/EgXN5uadc_Js"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.w/EgXN5uadc_Js
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

The bttv code in 2.5.47 triggers the following warning about use of
uninitialized timer here. If a patch exists for this issue, I'll happily
test it.

Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc0269630, data=0xc04f3380
Call Trace:
 [<c0123221>] check_timer_failed+0x61/0x70
 [<c0269630>] bttv_irq_timeout+0x0/0x240
 [<c012339f>] mod_timer+0x2f/0x180
 [<c026cce1>] bttv_set_dma+0x131/0x1d0
 [<c026611f>] bttv_switch_overlay+0x4f/0xb0
 [<c0267ab4>] bttv_do_ioctl+0x3a4/0x14a0
 [<c0274734>] set_tv_freq+0x114/0x270
 [<c03335ab>] unix_write_space+0x8b/0x90
 [<c0274d76>] tuner_command+0x116/0x230
 [<c026bb36>] bttv_call_i2c_clients+0x46/0x50
 [<c02657d5>] i2c_vidiocschan+0x55/0x80
 [<c0130b61>] unlock_page+0x11/0x50
 [<c01fcec7>] copy_from_user+0x57/0x5c
 [<c02644dc>] video_usercopy+0x8c/0x120
 [<c01475bd>] chrdev_open+0x6d/0x80
 [<c01454a2>] dentry_open+0x182/0x1b0
 [<c0145318>] filp_open+0x68/0x70
 [<c0268bdf>] bttv_ioctl+0x2f/0x40
 [<c0267710>] bttv_do_ioctl+0x0/0x14a0
 [<c0157aaa>] sys_ioctl+0xea/0x2c0
 [<c0116360>] do_page_fault+0x0/0x487
 [<c01092a3>] syscall_call+0x7/0xb

Regards,
-Udo.

--=.w/EgXN5uadc_Js
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9z+hRnhRzXSM7nSkRAvrKAJ9pTSNgXrDB/4e0z5DX4t6yQsVjdQCcCU2t
mQO0WCjUW+Zie27xXzt9Bd8=
=qScg
-----END PGP SIGNATURE-----

--=.w/EgXN5uadc_Js--
