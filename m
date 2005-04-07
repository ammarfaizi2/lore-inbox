Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVDGCho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVDGCho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVDGCho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:37:44 -0400
Received: from 60-240-77-24-nsw-pppoe.tpgi.com.au ([60.240.77.24]:63944 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S262393AbVDGChP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:37:15 -0400
Date: Thu, 7 Apr 2005 12:37:13 +1000
To: linux-kernel@vger.kernel.org
Subject: Kernel oops and debugging (help wanted)
Message-ID: <20050407023713.GA9188@samad.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

I recently installed a new kernel 2.6.11 with some netfilter patches, I
also upgraded iproute2.

No I have been getting oops like this one

Apr  6 15:46:24 sydlxfw01 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000221
Apr  6 15:46:24 sydlxfw01 kernel:  printing eip:
Apr  6 15:46:24 sydlxfw01 kernel: c01ebec0
Apr  6 15:46:24 sydlxfw01 kernel: *pde =3D 00000000
Apr  6 15:46:24 sydlxfw01 kernel: Oops: 0002 [#1]
Apr  6 15:46:24 sydlxfw01 kernel: PREEMPT=20
Apr  6 15:46:24 sydlxfw01 kernel: Modules linked in: rtc nvidia tun
l2cap bluetooth nfsd exportfs lockd sunrpc ipt_ULOG defl
ate twofish serpent aes_i586 blowfish des sha256 sha1 crypto_null
xfrm_user ipcomp esp4 ah4 af_key lp autofs4 ppp_deflate zl
ib_deflate bsd_comp capability commoncap ip_nat_ftp ip_conntrack_ftp
binfmt_misc binfmt_aout raw ppp_async crc_ccitt ppp_gen
eric slhc eepro100 eth1394 bridge atm sch_tbf sch_sfq sch_prio af_packet
ip6t_limit ip6t_LOG ip6t_mac ip6t_MARK ip6table_man
gle ip6table_filter ip6_tables md5 ipv6 ipt_TARPIT ipt_limit ipt_REJECT
ipt_LOG ipt_mac ipt_mark ipt_MASQUERADE iptable_nat=20
ipt_owner ipt_MARK ipt_state ip_conntrack iptable_mangle iptable_filter
ip_tables tsdev psmouse parport_pc parport evdev flo
ppy pcspkr sundance mii crc32 ohci1394 ieee1394 snd_intel8x0
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd=20
soundcore snd_page_alloc i2c_i801 i2c_core ehci_hcd usbhid usblp
uhci_hcd intel_agp intel_mch_agp agpgart i8xx_tco ide_cd cd
rom usb_storage usbcore sg aic7xxx id
Apr  6 15:46:24 sydlxfw01 kernel: _disk ide_generic via82cxxx trm290
triflex slc90e66 sis5513 siimage serverworks sc1200 rz1
000 pdc202xx_old opti621 ns87415 hpt366 hpt34x generic cy82c693 cs5530
cs5520 cmd64x amd74xx alim15x3 aec62xx pdc202xx_new u
nix ext2 ext3 jbd mbcache dm_mod raid5 xor raid1 md sd_mod ata_piix
libata scsi_mod piix ide_core
Apr  6 15:46:24 sydlxfw01 kernel: CPU:    0
Apr  6 15:46:24 sydlxfw01 kernel: EIP:
0060:[tty_ldisc_ref_wait+144/192]    Tainted: P      VLI
Apr  6 15:46:24 sydlxfw01 kernel: EFLAGS: 00210286   (2.6.11-1-ntf)=20
Apr  6 15:46:24 sydlxfw01 kernel: EIP is at tty_ldisc_ref_wait+0x90/0xc0
Apr  6 15:46:24 sydlxfw01 kernel: eax: 00000221   ebx: e895b00c   ecx:
c01f3ce0   edx: c8751000
Apr  6 15:46:24 sydlxfw01 kernel: esi: 00000000   edi: 00200246   ebp:
00000000   esp: ded97e94
Apr  6 15:46:24 sydlxfw01 kernel: ds: 007b   es: 007b   ss: 0068
Apr  6 15:46:24 sydlxfw01 kernel: Process screen (pid: 17625,
threadinfo=3Dded96000 task=3Dd8b5da20)
Apr  6 15:46:24 sydlxfw01 kernel: Stack: c01ebf06 e895b000 e895b000
c01ec558 e895b000 c8751000 00000000 c01f3cfd=20
Apr  6 15:46:24 sydlxfw01 kernel:        e895b000 c8751000 c01f050b
c8751000 c01f28d8 c8751000 e5f64f43 00000049=20
Apr  6 15:46:24 sydlxfw01 kernel:        00000000 c02d4c40 ded96000
c875193c 7fffffff 00000000 00000000 00000001=20
Apr  6 15:46:24 sydlxfw01 kernel: Call Trace:
Apr  6 15:46:24 sydlxfw01 kernel:  [tty_ldisc_ref+22/48]
tty_ldisc_ref+0x16/0x30
Apr  6 15:46:24 sydlxfw01 kernel:  [tty_wakeup+72/112]
tty_wakeup+0x48/0x70
Apr  6 15:46:24 sydlxfw01 kernel:  [pty_unthrottle+29/48]
pty_unthrottle+0x1d/0x30
Apr  6 15:46:24 sydlxfw01 kernel:  [check_unthrottle+59/64]
check_unthrottle+0x3b/0x40
Apr  6 15:46:24 sydlxfw01 kernel:  [read_chan+1080/2016]
read_chan+0x438/0x7e0
Apr  6 15:46:24 sydlxfw01 kernel:  [default_wake_function+0/32]
default_wake_function+0x0/0x20
Apr  6 15:46:24 sydlxfw01 last message repeated 2 times
Apr  6 15:46:24 sydlxfw01 kernel:  [tty_read+246/288]
tty_read+0xf6/0x120
Apr  6 15:46:24 sydlxfw01 kernel:  [vfs_read+229/352]
vfs_read+0xe5/0x160
Apr  6 15:46:24 sydlxfw01 kernel:  [sys_read+81/128] sys_read+0x51/0x80
Apr  6 15:46:24 sydlxfw01 kernel:  [sysenter_past_esp+82/117]
sysenter_past_esp+0x52/0x75
Apr  6 15:46:24 sydlxfw01 kernel: Code: 54 24 34 90 8d b4 26 00 00 00 00
b9 02 00 00 00 89 fa b8 2c b2 30 c0 e8 cf 3a f4 ff=20
89 1c 24 e8 07 ff ff ff 85 c0 75 07 e8 fe ed <09> 00 eb dc 89 fa b8 2c
b2 30 c0 e8 f0 3b f4 ff 8b 7b 54 85 ff=20


this is followed by these

Apr  6 15:46:24 sydlxfw01 kernel:  ve!
Apr  6 15:46:24 sydlxfw01 kernel: release_dev: ptm5: read/write wait
queue active!
Apr  6 15:46:29 sydlxfw01 last message repeated 119552 times
Apr  6 15:46:29 sydlxfw01 kernel: ve!
Apr  6 15:46:29 sydlxfw01 kernel: release_dev: ptm5: read/write wait
queue active!


I was wondering how I decode this to the location that cause the problem
do I do a search through the source tree (still have it - built from
debian kernel-source-2.6.11-1) and look for  tty_ldisc_ref_wait - I
presume the error occured 0x90 bytes into the code ?

Or how do I work out who to contact to say there might be a problem.

Thanks
Alex


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCVJzZkZz88chpJ2MRApfPAKDz3OSqvg/4prwVen/42v4siGTiBACg8W8I
BVPLtLmFM2wSyR00HhwGvVI=
=xKzL
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
