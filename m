Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUGGGag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUGGGag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUGGGaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:30:35 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:40639 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264922AbUGGGa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:30:29 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Wed, 7 Jul 2004 02:08:08 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 oops in usb hotplugging (hiddev/cpia_usb)
Message-ID: <20040707060808.GA6435@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i boot up without my cpia_usb camera plugged in.  when i plug
it in, the modprobe hangs, and i see this error in dmesg:
---
hub 1-1:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
usb 1-1.1: USB disconnect, address 4
usb 1-1.1: usb_disable_device nuking all URBs
ohci_hcd 0000:00:07.4: shutdown urb de607ad8 pipe 40408480 ep1in-intr
usb 1-1.1: unregistering interface 1-1.1:1.0
usb 1-1.1:1.0: hotplug
usb 1-1.1: unregistering device
usb 1-1.1: hotplug
hub 1-1:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
usb 1-1.1: new low speed USB device using address 7
usb 1-1.1: skipped 1 descriptor after interface
usb 1-1.1: new device strings: Mfr=3D3, Product=3D1, SerialNumber=3D2
usb 1-1.1: default language 0x0409
usb 1-1.1: Product: Back-UPS RS 1000 FW:7.g5 .D USB FW:g5=20
usb 1-1.1: Manufacturer: American Power Conversion
usb 1-1.1: SerialNumber: BB0100009999 =20
usb 1-1.1: hotplug
usb 1-1.1: adding 1-1.1:1.0 (config #1, interface 0)
usb 1-1.1:1.0: hotplug
usbhid 1-1.1:1.0: usb_probe_interface
usbhid 1-1.1:1.0: usb_probe_interface - got id
Unable to handle kernel paging request at virtual address 2023f8fc
 printing eip:
e0e46c34
*pde =3D 00000000
Oops: 0002 [#1]
SMP=20
Modules linked in: nfsd exportfs lockd sunrpc parport_pc lp parport autofs4=
 capability commoncap ipt_REJECT iptable_filter iptable_nat ip_conntrack ip=
_tables md5 ipv6 af_packet sr_mod cdrom usb_storage usbhid snd_ens1371 snd_=
rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd=
_timer snd_ac97_codec snd soundcore ohci1394 ieee1394 ne2k_pci 8390 crc32 o=
hci_hcd usbcore amd74xx ide_core amd_k7_agp agpgart sg 3c59x psmouse
CPU:    1
EIP:    0060:[<e0e46c34>]    Not tainted
EFLAGS: 00010246   (2.6.7)=20
EIP is at hiddev_cleanup+0x14/0x40 [usbhid]
eax: cfcfcfcf   ebx: df43e9c8   ecx: de356e0c   edx: e0e4b61c
esi: df43e9e0   edi: de356800   ebp: de6dcf78   esp: de6dcf74
ds: 007b   es: 007b   ss: 0068
Process apcupsd (pid: 2216, threadinfo=3Dde6dc000 task=3Ddf1258f0)
Stack: df43e9c8 de6dcf8c e0e46ce8 dec287e0 dffb00a0 de231e20 de6dcfa4 c0156=
5fe=20
       df7e8a64 dec287e0 00000000 dfb186c0 de6dcfbc c0154e6f 00000000 00000=
004=20
       0000000a 0808a7d0 de6dc000 c0104e33 00000004 00000000 08084018 00000=
00a=20
Call Trace:
 [<c0105c0a>] show_stack+0x7a/0x90
 [<c0105d97>] show_registers+0x157/0x1b0
 [<c0105f1c>] die+0x8c/0x100
 [<c0115f23>] do_page_fault+0x253/0x50f
 [<c010589d>] error_code+0x2d/0x38
 [<e0e46ce8>] hiddev_release+0x88/0x90 [usbhid]
 [<c01565fe>] __fput+0xfe/0x110
 [<c0154e6f>] filp_close+0x4f/0x80
 [<c0104e33>] syscall_call+0x7/0xb

Code: c7 04 85 c0 b9 e4 e0 00 00 00 00 8b 43 14 8b 80 48 0c 00 00=20
 <7>drivers/usb/core/file.c: looking for a minor, starting at 0
hiddev1: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1000 F=
W:7.g5 .D USB FW:g5] on usb-0000:00:07.4-1.1
hub 1-1:1.0: 312mA power budget left
hub 1-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
hub 1-1:1.0: debounce: port 4: delay 100ms stable 4 status 0x101
hub 1-1:1.0: port 4 not reset yet, waiting 10ms
usb 1-1.4: new full speed USB device using address 8
usb 1-1.4: new device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0
usb 1-1.4: default language 0x0409
usb 1-1.4: Product: USB Camera
usb 1-1.4: hotplug
usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
usb 1-1.4:1.0: hotplug
hub 1-1:1.0: 212mA power budget left
Linux video capture interface: v1.00
V4L-Driver for Vision CPiA based cameras v1.2.3
---

hanging modprobe:
---
root      4933  4906  0 01:56 ?        00:00:00 /sbin/modprobe -s -q cpia_u=
sb
root      4935  4934  0 01:56 ?        00:00:00 /sbin/modprobe -q -- cpia_u=
sb
glynis    5167  4208  0 01:59 tty1     00:00:00 grep modprobe
---

ver_linux:
---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux butterfly 2.6.7 #1 SMP Tue Jul 6 23:30:14 EDT 2004 i686 GNU/Linux
=20
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre4
e2fsprogs              1.35
quota-tools            3.12.
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         cpia videodev nfsd exportfs lockd sunrpc parport_pc =
lp parport autofs4 capability commoncap ipt_REJECT iptable_filter iptable_n=
at ip_conntrack ip_tables md5 ipv6 af_packet sr_mod cdrom usb_storage usbhi=
d snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm =
snd_page_alloc snd_timer snd_ac97_codec snd soundcore ohci1394 ieee1394 ne2=
k_pci 8390 crc32 ohci_hcd usbcore amd74xx ide_core amd_k7_agp agpgart sg 3c=
59x psmouse
---

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA65NICGPRljI8080RAjfeAJ0fBhP6McL/HslNlKFWCKaLs/AjqQCgi+XW
lenoSyWLvldvVw06yiXtMnM=
=4ged
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
