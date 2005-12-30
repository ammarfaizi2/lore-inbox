Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVL3TrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVL3TrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVL3TrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:47:13 -0500
Received: from mail.gmx.net ([213.165.64.21]:45242 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932131AbVL3TrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:47:13 -0500
X-Authenticated: #5339386
Date: Fri, 30 Dec 2005 20:44:35 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops in kernel 2.6.15-rc7
Message-ID: <20051230194435.GA7088@sidney>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Mathias Klein <ma_klein@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

i recently got another oops. As suggested by Pekka Enberg I've enabled
CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.

If you need more informations please let me know.

regards
Mathias

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kern.log"
Content-Transfer-Encoding: quoted-printable

Dec 30 20:12:11 sidney kernel: [31895.552562] Unable to handle kernel NULL =
pointer dereference at virtual address 00000020
Dec 30 20:12:11 sidney kernel: [31895.552699]  printing eip:
Dec 30 20:12:11 sidney kernel: [31895.552914] c0136b90
Dec 30 20:12:11 sidney kernel: [31895.552933] *pde =3D 00000000
Dec 30 20:12:11 sidney kernel: [31895.553014] Oops: 0000 [#1]
Dec 30 20:12:11 sidney kernel: [31895.553065] PREEMPT=20
Dec 30 20:12:11 sidney kernel: [31895.553147] Modules linked in: sd_mod usb=
_storage scsi_mod md5 ipv6 lp capi kernelcapi capifs nls_iso8859_15 nls_cp4=
37 vfat fat parport_pc parport joydev evdev nvidiafb 8139too mii rivafb crc=
32 tuner tvaudio msp3400 bttv video_buf firmware_class snd_ens1370 gameport=
 i2c_algo_bit snd_rawmidi snd_seq_device snd_bt87x v4l2_common btcx_risc tv=
eeprom videodev snd_pcm snd_ak4531_codec snd_timer snd_page_alloc snd sound=
core i2c_viapro i2c_core uhci_hcd usbcore ide_cd cdrom
Dec 30 20:12:11 sidney kernel: [31895.554927] CPU:    0
Dec 30 20:12:11 sidney kernel: [31895.554933] EIP:    0060:[mempool_free+4/=
104]    Not tainted VLI
Dec 30 20:12:11 sidney kernel: [31895.554942] EFLAGS: 00010282   (2.6.15-rc=
7.sidney.11)=20
Dec 30 20:12:11 sidney kernel: [31895.555106] EIP is at mempool_free+0x4/0x=
68
Dec 30 20:12:11 sidney kernel: [31895.555168] eax: 00011200   ebx: 00000010=
   ecx: c11490c0   edx: c11490c0
Dec 30 20:12:11 sidney kernel: [31895.555236] esi: c132b7dc   edi: c132b7dc=
   ebp: c3e71c28   esp: c3e71bfc
Dec 30 20:12:11 sidney kernel: [31895.555301] ds: 007b   es: 007b   ss: 0068
Dec 30 20:12:11 sidney kernel: [31895.555361] Process pdflush (pid: 31177, =
threadinfo=3Dc3e70000 task=3Dc3469000)
Dec 30 20:12:11 sidney kernel: [31895.555413] Stack: c639ab64 c132b7dc 0001=
1210 00000160 00000008 c3e71c24 c01b78c1 c1338c14=20
Dec 30 20:12:11 sidney kernel: [31895.555773]        00000008 c1338c14 c335=
3460 c3e71c4c c01b996c c132b7dc 00000010 c1338c24=20
Dec 30 20:12:11 sidney kernel: [31895.556130]        00000001 00000008 c133=
8c14 c1338c14 c3e71c88 c01b9aad c1338c14 00000001=20
Dec 30 20:12:11 sidney kernel: [31895.556488] Call Trace:
Dec 30 20:12:11 sidney kernel: [31895.556582]  [show_stack+120/131] show_st=
ack+0x78/0x83
Dec 30 20:12:11 sidney kernel: [31895.556712]  [show_registers+306/415] sho=
w_registers+0x132/0x19f
Dec 30 20:12:11 sidney kernel: [31895.556840]  [die+201/318] die+0xc9/0x13e
Dec 30 20:12:11 sidney kernel: [31895.556964]  [do_page_fault+924/1239] do_=
page_fault+0x39c/0x4d7
Dec 30 20:12:11 sidney kernel: [31895.557095]  [error_code+79/96] error_cod=
e+0x4f/0x60
Dec 30 20:12:11 sidney kernel: [31895.557219]  [get_request+330/625] get_re=
quest+0x14a/0x271
Dec 30 20:12:11 sidney kernel: [31895.557353]  [get_request_wait+26/205] ge=
t_request_wait+0x1a/0xcd
Dec 30 20:12:11 sidney kernel: [31895.557480]  [__make_request+643/998] __m=
ake_request+0x283/0x3e6
Dec 30 20:12:11 sidney kernel: [31895.557608]  [generic_make_request+244/26=
2] generic_make_request+0xf4/0x106
Dec 30 20:12:11 sidney kernel: [31895.557736]  [submit_bio+169/178] submit_=
bio+0xa9/0xb2
Dec 30 20:12:11 sidney kernel: [31895.557863]  [submit_bh+192/226] submit_b=
h+0xc0/0xe2
Dec 30 20:12:11 sidney kernel: [31895.557998]  [__block_write_full_page+425=
/671] __block_write_full_page+0x1a9/0x29f
Dec 30 20:12:11 sidney kernel: [31895.558130]  [block_write_full_page+198/2=
09] block_write_full_page+0xc6/0xd1
Dec 30 20:12:11 sidney kernel: [31895.558259]  [blkdev_writepage+19/21] blk=
dev_writepage+0x13/0x15
Dec 30 20:12:11 sidney kernel: [31895.558387]  [mpage_writepages+390/737] m=
page_writepages+0x186/0x2e1
Dec 30 20:12:11 sidney kernel: [31895.558521]  [generic_writepages+16/18] g=
eneric_writepages+0x10/0x12
Dec 30 20:12:11 sidney kernel: [31895.558649]  [do_writepages+33/51] do_wri=
tepages+0x21/0x33
Dec 30 20:12:11 sidney kernel: [31895.558779]  [__sync_single_inode+97/441]=
 __sync_single_inode+0x61/0x1b9
Dec 30 20:12:11 sidney kernel: [31895.558906]  [__writeback_single_inode+29=
2/302] __writeback_single_inode+0x124/0x12e
Dec 30 20:12:11 sidney kernel: [31895.559037]  [sync_sb_inodes+423/626] syn=
c_sb_inodes+0x1a7/0x272
Dec 30 20:12:11 sidney kernel: [31895.559163]  [writeback_inodes+134/224] w=
riteback_inodes+0x86/0xe0
Dec 30 20:12:11 sidney kernel: [31895.559291]  [wb_kupdate+121/218] wb_kupd=
ate+0x79/0xda
Dec 30 20:12:11 sidney kernel: [31895.559415]  [__pdflush+218/396] __pdflus=
h+0xda/0x18c
Dec 30 20:12:11 sidney kernel: [31895.559540]  [pdflush+31/33] pdflush+0x1f=
/0x21
Dec 30 20:12:11 sidney kernel: [31895.559665]  [kthread+110/156] kthread+0x=
6e/0x9c
Dec 30 20:12:11 sidney kernel: [31895.559797]  [kernel_thread_helper+5/11] =
kernel_thread_helper+0x5/0xb
Dec 30 20:12:11 sidney kernel: [31895.559922] Code: 7e 14 00 75 05 e8 46 d2=
 16 00 89 d8 89 fa e8 8b 32 ff ff 8b 45 dc e9 6f ff ff ff 31 db 8d 65 f4 89=
 d8 5b 5e 5f c9 c3 55 89 e5 57 <56> 8b 7d 08 53 8b 5d 0c 8b 43 10 39 43 14 =
7d 43 89 d8 e8 89 da=20

--a8Wt8u1KmwUX3Y2C--

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDtY4iPtJqRGqEpd8RAhmUAKDOJYV67EBM8bF1HYW2YPqJ7PFK0wCgk2m5
9K+8ZL123zFjr/qwjB3irYw=
=yNvr
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
