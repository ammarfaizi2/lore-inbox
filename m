Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUFAVyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUFAVyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUFAVyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:54:45 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:27147 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S265040AbUFAVyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:54:40 -0400
Date: Tue, 1 Jun 2004 18:54:27 -0300
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.6] oops in khubd on usb bluetooth disconnect
Message-ID: <20040601215427.GA9591@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
after shortly using a usb bluetooth adapter (builtin Sony C1MHP)
with rfcomm to a Nokia 6310i disconnecting the adapter caused this oops

Arch: i386
Machine: Sony C1MHP
Kernel: 2.6.6
Patches: None

Module                  Size  Used by
rfcomm                 33308  5=20
l2cap                  19332  3 rfcomm
hci_usb                11008  0=20
bluetooth              40004  5 rfcomm,l2cap,hci_usb
sonypi                 20384  0=20
orinoco_cs              6824  1=20
orinoco                39020  1 orinoco_cs
hermes                  7520  2 orinoco_cs,orinoco
usb_storage            31392  1=20
ohci_hcd               28708  0=20
usbcore               110396  5 hci_usb,usb_storage,ohci_hcd
ds                     13796  3 orinoco_cs
yenta_socket           18368  1=20
pcmcia_core            54628  3 orinoco_cs,ds,yenta_socket
sd_mod                 16000  0=20
scsi_mod              100940  2 usb_storage,sd_mod
8139too                20064  0=20
mii                     3968  1 8139too
crc32                   3808  1 8139too
ohci1394               30820  0=20
ieee1394              303864  1 ohci1394
8250_pci               16448  0=20
8250                   17760  1 8250_pci
serial_core            18528  1 8250
snd_ali5451            20004  0=20
snd_ac97_codec         61604  1 snd_ali5451
snd_pcm                82820  1 snd_ali5451
snd_page_alloc          8996  1 snd_pcm
snd_timer              20004  1 snd_pcm
snd                    43908  4 snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
soundcore               6848  1 snd

[...]
ohci_hcd 0000:00:0f.0: urb cd4eb224 path 2 ep2in 5e160000 cc 5 --> status -=
110
ohci_hcd 0000:00:0f.0: urb cd4eb224 path 2 ep2in 5e160000 cc 5 --> status -=
110
ohci_hcd 0000:00:0f.0: urb cd4eb224 path 2 ep2in 5e160000 cc 5 --> status -=
110
ohci_hcd 0000:00:0f.0: urb cd4eb224 path 2 ep2in 5e160000 cc 5 --> status -=
110
ohci_hcd 0000:00:0f.0: urb cd4eb1a4 path 2 ep1in 5f160000 cc 5 --> status -=
110
ohci_hcd 0000:00:0f.0: urb cd4eb224 path 2 ep2in 5e160000 cc 5 --> status -=
110
ohci_hcd 0000:00:0f.0: GetStatus roothub.portstatus [2] =3D 0x00030100 PESC=
 CSC PPS
hub 1-0:1.0: port 2, status 100, change 3, 12 Mb/s
usb 1-2: USB disconnect, address 3
ohci_hcd 0000:00:0f.0: urb cd4eb224 path 2 ep2in 5e160000 cc 5 --> status -=
110
usb 1-2: usb_disable_device nuking all URBs
ohci_hcd 0000:00:0f.0: shutdown urb cd4eb1a4 pipe 40408380 ep1in-intr
ohci_hcd 0000:00:0f.0: shutdown urb cd446a14 pipe 00418380 ep3in-iso
ohci_hcd 0000:00:0f.0: shutdown urb cd446214 pipe 00418380 ep3in-iso
usb 1-2: unregistering interface 1-2:1.0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01ab476
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01ab476>]    Tainted: G S
EFLAGS: 00010246   (2.6.6-paradigm)=20
EIP is at get_kobj_path_length+0x26/0x40
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: cd446538
esi: 00000001   edi: 00000000   ebp: ffffffff   esp: c849ddd8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 8339, threadinfo=3Dc849c000 task=3Dce024130)
Stack: c0216450 ce0c2419 ce0c2400 cd4eb190 c01ab629 c036c560 cd446538 00000=
1a8=20
       d012dac0 c0161f4d c849de18 ce0c2400 00000000 c0334940 d012a731 00000=
000=20
       c0303b9c cd446538 cd446530 d012da60 d012dac0 c01ab7c7 c03032ad c036c=
560=20
Call Trace:
 [<c0216450>] class_hotplug_name+0x0/0x10
 [<c01ab629>] kset_hotplug+0x139/0x270
 [<c0161f4d>] lookup_hash+0x1d/0x30
 [<c01ab7c7>] kobject_hotplug+0x67/0x70
 [<c01abb3b>] kobject_del+0x1b/0x40
 [<c02166d0>] class_device_del+0x90/0xc0
 [<d0125d13>] hci_unregister_dev+0x13/0x80 [bluetooth]
 [<d00f58c5>] hci_usb_disconnect+0x35/0x90 [hci_usb]
 [<d01bc166>] usb_unbind_interface+0x76/0x80 [usbcore]
 [<c02159e6>] device_release_driver+0x66/0x70
 [<c0215b25>] bus_remove_device+0x55/0xa0
 [<c0214a1d>] device_del+0x5d/0xa0
 [<c0214a73>] device_unregister+0x13/0x30
 [<d01c2f58>] usb_disable_device+0xd8/0x120 [usbcore]
 [<d01bce14>] usb_disconnect+0xa4/0x140 [usbcore]
 [<d01bf72f>] hub_port_connect_change+0x2cf/0x2e0 [usbcore]
 [<d01bfab4>] hub_events+0x374/0x420 [usbcore]
 [<d01bfbc5>] hub_thread+0x65/0x1b0 [usbcore]
 [<c0114040>] default_wake_function+0x0/0x20
 [<d01bfb60>] hub_thread+0x0/0x1b0 [usbcore]
 [<c01042ad>] kernel_thread_helper+0x5/0x18

Code: f2 ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e=20
=20
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvPsTUaz2rXW+gJcRAlAlAKC3/uw94vDJgXxIv6YYcLoWNLLq9wCfXNwX
+AglZPsCck9JlWERBRhDiJo=
=LCB0
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
