Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWDJRNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWDJRNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWDJRNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:13:13 -0400
Received: from nsm.pl ([195.34.211.229]:22537 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1751024AbWDJRNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:13:13 -0400
Date: Mon, 10 Apr 2006 19:12:55 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Two OOPSes in ALSA with kernel-2.6.17-rc1
Message-ID: <20060410171255.GA7435@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200604101823.54600.shlomif@iglu.org.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <200604101823.54600.shlomif@iglu.org.il>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2006 at 06:23:54PM +0300, Shlomi Fish wrote:
> I recently received these two OOPSes with kernel-2.6.17-rc1. They happene=
d=20
> while mpg123 was playing a WAV file and I invoked KDE (along with artsd).

  I got Oopses with 2.6.17-rc1 too. mplayer playing movie via dmix.

> My soundcard is snd_intel8x0.

  Mine too.

 Oopses:

divide error: 0000 [#1]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c0294548>]    Not tainted VLI
EFLAGS: 00210246   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_oss_get_space+0x107/0x133
eax: 00000000   ebx: c4c68c00   ecx: 00000000   edx: 00000000
esi: 00000000   edi: df8ef0c0   ebp: 08692d9c   esp: d7afbf50
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 23609, threadinfo=3Dd7afb000 task=3Dc28fda90)
Stack: <0>00004000 d7afbe54 00000010 00000000 00000000 c0442820 dadfede0 c0=
294ade=20
       00000006 c015b978 08692d9c dadfede0 00000000 c015bbb9 00000000 bf899=
610=20
       c04da670 dadfede0 fffffff7 00000000 d7afb000 c015bbf1 08692d9c 00000=
000=20
Call Trace:
 <c0294ade> snd_pcm_oss_ioctl+0x0/0x4c9   <c015b978> do_ioctl+0x1c/0x42
 <c015bbb9> vfs_ioctl+0x178/0x186   <c015bbf1> sys_ioctl+0x2a/0x41
 <c010290b> syscall_call+0x7/0xb =20
Code: eb 11 89 e2 89 f8 e8 35 ed ff ff 8b b3 5c 02 00 00 89 c1 85 c9 89 c8 =
78 36 8b 14 24 89 f8 e8 46 e1 ff ff 01 f0 31 d2 89 44 24 10 <f7> b3 3c 02 0=
0 00 89 44 24 04 8d 54 24 04 b9 10 00 00 00 89 e8=20
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s 00000218
 printing eip:
c028baf5
*pde =3D 00000000
Oops: 0000 [#2]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c028baf5>]    Not tainted VLI
EFLAGS: 00210246   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_mmap_data_nopage+0x1d/0x8f
eax: ca919b1c   ebx: 00002000   ecx: 00000000   edx: 00000000
esi: df8ef0c0   edi: 00000000   ebp: d7ae5f30   esp: d7ae5f0c
ds: 007b   es: 007b   ss: 0068
Process gaim (pid: 23633, threadinfo=3Dd7ae5000 task=3Dd928f050)
Stack: <0>c0441fd4 b7c297c0 ca919b1c c8259e40 c0141c4d 00000000 00000000 de=
e014d0=20
       b7c297c0 00000002 c7d76b7c b7c297c0 c8259e40 b7c297c0 c0141ebd d82b2=
0a4=20
       c7d76b7c 00000001 ca919b1c c8259e40 c8259e74 ca919b1c b7c297c0 c0114=
6f1=20
Call Trace:
 <c0141c4d> do_no_page+0x6a/0x1c0   <c0141ebd> __handle_mm_fault+0xbb/0x16d
 <c01146f1> do_page_fault+0x239/0x55d   <c015bbf1> sys_ioctl+0x2a/0x41
 <c01144b8> do_page_fault+0x0/0x55d   <c010339f> error_code+0x4f/0x54
Code: c0 89 71 50 89 51 14 31 db 89 d8 5b 5e c3 55 89 cd 83 c9 ff 57 56 53 =
8b 70 50 89 d3 85 f6 74 76 8b 7e 5c 2b 58 04 31 c9 8b 50 48 <8b> 87 18 02 0=
0 00 c1 e2 0c 01 da 05 ff 0f 00 00 25 00 f0 ff ff=20
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s 000000a0
 printing eip:
c028bb8a
*pde =3D 00000000
Oops: 0002 [#3]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c028bb8a>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_mmap_data_close+0x6/0xd
eax: 00000000   ebx: ca919b1c   ecx: 00000000   edx: c028bb84
esi: ca919b74   edi: 00000001   ebp: 0000000b   esp: d7ae5e18
ds: 007b   es: 007b   ss: 0068
Process gaim (pid: 23633, threadinfo=3Dd7ae5000 task=3Dd928f050)
Stack: <0>c01429d1 ca919b1c c8259e40 c0144215 c04cb14c 00000699 c8259e40 d9=
28f050=20
       c011978e d7ae5000 c011d3da d7ae5000 d7ae5ed8 00000000 c032ddcd c0103=
a2c=20
       d7ae5ed8 c032ddcd 00000000 0000000e 0000000b c8f9bee4 00000218 c011b=
bfc=20
Call Trace:
 <c01429d1> remove_vma+0x1e/0x3b   <c0144215> exit_mmap+0x9f/0xb6
 <c011978e> mmput+0x1b/0x5e   <c011d3da> do_exit+0x176/0x2f8
 <c0103a2c> die+0x15b/0x163   <c011bbfc> printk+0xe/0x11
 <c0114926> do_page_fault+0x46e/0x55d   <c013794e> add_to_page_cache_lru+0x=
d/0x20
 <c013795c> add_to_page_cache_lru+0x1b/0x20   <c01144b8> do_page_fault+0x0/=
0x55d
 <c010339f> error_code+0x4f/0x54   <c028baf5> snd_pcm_mmap_data_nopage+0x1d=
/0x8f
 <c0141c4d> do_no_page+0x6a/0x1c0   <c0141ebd> __handle_mm_fault+0xbb/0x16d
 <c01146f1> do_page_fault+0x239/0x55d   <c015bbf1> sys_ioctl+0x2a/0x41
 <c01144b8> do_page_fault+0x0/0x55d   <c010339f> error_code+0x4f/0x54
Code: d1 5b 5e 5f 5d 89 c8 c3 81 4a 14 00 00 08 00 c7 42 44 d4 1f 44 c0 89 =
42 50 8b 40 5c ff 80 a0 00 00 00 31 c0 c3 8b 40 50 8b 40 5c <ff> 88 a0 00 0=
0 00 c3 8b 40 50 8b 40 5c ff 80 a0 00 00 00 c3 55=20
 <1>Fixing recursive fault but reboot is needed!
BUG: unable to handle kernel paging request at virtual address 00100100
 printing eip:
c028848b
*pde =3D 00000000
Oops: 0000 [#4]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c028848b>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_info+0xb/0xe1
eax: 00100100   ebx: 00100100   ecx: 00000000   edx: d3704400
esi: 00100100   edi: d3704400   ebp: d3704400   esp: d7a4ef18
ds: 007b   es: 007b   ss: 0068
Process gaim (pid: 23689, threadinfo=3Dd7a4e000 task=3Dd7523030)
Stack: <0>00000000 00100100 d3704400 bfa6c7b0 0000000e c028858b c0442000 bf=
a6c7b0=20
       c028b62e c028b436 00100100 c0141ebd ca460610 d22ac484 00000000 d9bf0=
494=20
       cff8f8e0 cff8f914 d9bf0494 c0442000 c8542680 c028b62e 0000000e c015b=
978=20
Call Trace:
 <c028858b> snd_pcm_info_user+0x2a/0x55   <c028b62e> snd_pcm_playback_ioctl=
+0x0/0x1b
 <c028b436> snd_pcm_playback_ioctl1+0x1e0/0x1ec   <c0141ebd> __handle_mm_fa=
ult+0xbb/0x16d
 <c028b62e> snd_pcm_playback_ioctl+0x0/0x1b   <c015b978> do_ioctl+0x1c/0x42
 <c015bbb9> vfs_ioctl+0x178/0x186   <c015bbf1> sys_ioctl+0x2a/0x41
 <c010290b> syscall_call+0x7/0xb =20
Code: e8 74 c0 08 00 5a 59 e9 bd f9 ff ff 66 4a 0f 85 f5 f9 ff ff 51 e8 8e =
14 f5 ff 59 e9 e9 f9 ff ff 55 89 d5 57 89 d7 56 89 c6 53 51 <8b> 18 b9 48 0=
0 00 00 8b 40 04 89 04 24 31 c0 f3 ab 8b 03 b9 40=20
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s 00000000
 printing eip:
c028849c
*pde =3D 00000000
Oops: 0000 [#5]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c028849c>]    Not tainted VLI
EFLAGS: 00210246   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_info+0x1c/0xe1
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: d37dbe00
esi: c05b77c0   edi: d37dbf20   ebp: d37dbe00   esp: cccd9f18
ds: 007b   es: 007b   ss: 0068
Process gaim (pid: 23707, threadinfo=3Dcccd9000 task=3Dd7523030)
Stack: <0>00000000 c05b77c0 d37dbe00 bfa6c7b0 0000000e c028858b c0442000 bf=
a6c7b0=20
       c028b62e c028b436 c05b77c0 c0141ebd cd3ba610 d22ac484 00000000 c07dd=
e8c=20
       cff8f8e0 cff8f914 c07dde8c c0442000 c8542680 c028b62e 0000000e c015b=
978=20
Call Trace:
 <c028858b> snd_pcm_info_user+0x2a/0x55   <c028b62e> snd_pcm_playback_ioctl=
+0x0/0x1b
 <c028b436> snd_pcm_playback_ioctl1+0x1e0/0x1ec   <c0141ebd> __handle_mm_fa=
ult+0xbb/0x16d
 <c028b62e> snd_pcm_playback_ioctl+0x0/0x1b   <c015b978> do_ioctl+0x1c/0x42
 <c015bbb9> vfs_ioctl+0x178/0x186   <c015bbf1> sys_ioctl+0x2a/0x41
 <c010290b> syscall_call+0x7/0xb =20
Code: f9 ff ff 51 e8 8e 14 f5 ff 59 e9 e9 f9 ff ff 55 89 d5 57 89 d7 56 89 =
c6 53 51 8b 18 b9 48 00 00 00 8b 40 04 89 04 24 31 c0 f3 ab <8b> 03 b9 40 0=
0 00 00 8b 00 89 42 0c 8b 43 0c 89 02 8b 46 30 89=20
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s 00000087
 printing eip:
c028851a
*pde =3D 00000000
Oops: 0000 [#6]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c028851a>]    Not tainted VLI
EFLAGS: 00210286   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_info+0x9a/0xe1
eax: 00000001   ebx: daa66da0   ecx: 00000000   edx: ffffffff
esi: c5741360   edi: d37db120   ebp: d37db000   esp: d7a40f18
ds: 007b   es: 007b   ss: 0068
Process gaim (pid: 23728, threadinfo=3Dd7a40000 task=3Dd6dbc0b0)
Stack: <0>d9f66a40 c5741360 d37db000 bfa6c7b0 0000000e c028858b c0442000 bf=
a6c7b0=20
       c028b62e c028b436 c5741360 c0141ebd c75c2610 c694e484 00000000 de791=
ddc=20
       cff8f8e0 cff8f914 de791ddc c0442000 c8542680 c028b62e 0000000e c015b=
978=20
Call Trace:
 <c028858b> snd_pcm_info_user+0x2a/0x55   <c028b62e> snd_pcm_playback_ioctl=
+0x0/0x1b
 <c028b436> snd_pcm_playback_ioctl1+0x1e0/0x1ec   <c0141ebd> __handle_mm_fa=
ult+0xbb/0x16d
 <c028b62e> snd_pcm_playback_ioctl+0x0/0x1b   <c015b978> do_ioctl+0x1c/0x42
 <c015bbb9> vfs_ioctl+0x178/0x186   <c015bbf1> sys_ioctl+0x2a/0x41
 <c010290b> syscall_call+0x7/0xb =20
Code: 24 8b 42 08 89 85 c8 00 00 00 8b 42 08 2b 42 0c 8d 56 10 89 85 cc 00 =
00 00 8d 85 a0 00 00 00 e8 b4 17 f5 ff 8b 56 5c 85 d2 74 3f <8b> 82 88 00 0=
0 00 89 e9 89 85 d0 00 00 00 8b 82 8c 00 00 00 89=20
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s 00000087
 printing eip:
c028851a
*pde =3D 00000000
Oops: 0000 [#7]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c028851a>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_info+0x9a/0xe1
eax: 00000001   ebx: daa66da0   ecx: 00000000   edx: ffffffff
esi: c5741360   edi: d3704d20   ebp: d3704c00   esp: c58d7f18
ds: 007b   es: 007b   ss: 0068
Process gaim (pid: 23746, threadinfo=3Dc58d7000 task=3Dc24a0530)
Stack: <0>d9f66a40 c5741360 d3704c00 bfa6c7b0 0000000e c028858b c0442000 bf=
a6c7b0=20
       c028b62e c028b436 c5741360 c0141ebd c75f4610 d3848484 00000000 c7d6c=
f3c=20
       cff8fc20 cff8fc54 c7d6cf3c c0442000 c8542680 c028b62e 0000000e c015b=
978=20
Call Trace:
 <c028858b> snd_pcm_info_user+0x2a/0x55   <c028b62e> snd_pcm_playback_ioctl=
+0x0/0x1b
 <c028b436> snd_pcm_playback_ioctl1+0x1e0/0x1ec   <c0141ebd> __handle_mm_fa=
ult+0xbb/0x16d
 <c028b62e> snd_pcm_playback_ioctl+0x0/0x1b   <c015b978> do_ioctl+0x1c/0x42
 <c015bbb9> vfs_ioctl+0x178/0x186   <c015bbf1> sys_ioctl+0x2a/0x41
 <c010290b> syscall_call+0x7/0xb =20
Code: 24 8b 42 08 89 85 c8 00 00 00 8b 42 08 2b 42 0c 8d 56 10 89 85 cc 00 =
00 00 8d 85 a0 00 00 00 e8 b4 17 f5 ff 8b 56 5c 85 d2 74 3f <8b> 82 88 00 0=
0 00 89 e9 89 85 d0 00 00 00 8b 82 8c 00 00 00 89=20
 <1>BUG: unable to handle kernel paging request at virtual address 0b04428b
 printing eip:
c028849c
*pde =3D 00000000
Oops: 0000 [#8]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nf=
orce2 ohci_hcd eth1394 ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_a=
c97_bus sata_nv ohci1394 ieee1394 e1000 udf usb_storage usbcore cpufreq_nfo=
rce2 lp parport w83627hf hwmon_vid i2c_isa
CPU:    0
EIP:    0060:[<c028849c>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1 #58)=20
EIP is at snd_pcm_info+0x1c/0xe1
eax: 00000000   ebx: 0b04428b   ecx: 00000000   edx: cd136200
esi: c016672a   edi: cd136320   ebp: cd136200   esp: cb6d3f18
ds: 007b   es: 007b   ss: 0068
Process esd (pid: 14242, threadinfo=3Dcb6d3000 task=3Dd5ff1030)
Stack: <0>c0940f02 c016672a cd136200 bff5f760 00000020 c028858b c0442000 bf=
f5f760=20
       c028b62e c028b436 c016672a 00000000 00000246 d7633380 00000000 c014f=
86d=20
       d2e892c4 00000003 00000286 c0442000 c8542680 c028b62e 00000020 c015b=
978=20
Call Trace:
 <c016672a> single_start+0x0/0xc   <c028858b> snd_pcm_info_user+0x2a/0x55
 <c028b62e> snd_pcm_playback_ioctl+0x0/0x1b   <c028b436> snd_pcm_playback_i=
octl1+0x1e0/0x1ec
 <c016672a> single_start+0x0/0xc   <c014f86d> invalidate_inode_buffers+0x9/=
0x33
 <c028b62e> snd_pcm_playback_ioctl+0x0/0x1b   <c015b978> do_ioctl+0x1c/0x42
 <c015bbb9> vfs_ioctl+0x178/0x186   <c015bbf1> sys_ioctl+0x2a/0x41
 <c010290b> syscall_call+0x7/0xb =20
Code: f9 ff ff 51 e8 8e 14 f5 ff 59 e9 e9 f9 ff ff 55 89 d5 57 89 d7 56 89 =
c6 53 51 8b 18 b9 48 00 00 00 8b 40 04 89 04 24 31 c0 f3 ab <8b> 03 b9 40 0=
0 00 00 8b 00 89 42 0c 8b 43 0c 89 02 8b 46 30 89=20

--=20
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEOpIXThhlKowQALQRAidgAKCsbknQpYzMGF5YbsANt4WapHHq7gCfdy3S
Qp2YZJBItchL+wFRjf93rBg=
=PksR
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
