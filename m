Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279842AbRKMXnn>; Tue, 13 Nov 2001 18:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279839AbRKMXnZ>; Tue, 13 Nov 2001 18:43:25 -0500
Received: from [212.98.85.178] ([212.98.85.178]:37642 "EHLO web1.luka.de")
	by vger.kernel.org with ESMTP id <S279832AbRKMXnN>;
	Tue, 13 Nov 2001 18:43:13 -0500
Date: Wed, 14 Nov 2001 00:41:23 +0100
From: Christoph Kampe <kernelml@kampe.net>
To: linux-kernel@vger.kernel.org
Subject: usb-storage fails with datafab md2-usb (ide hdd on usb) on newer kernels >2.4.8
Message-ID: <20011114004123.A1174@kampe.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: greedy on Linux 2.4.8 i686 for kampe.net
X-PGP-Key: http://www.kampe.net/pubkey.asc
X-PGP-Fingerprint: 4286 CA6C AFD8 BD70 4B8F  78B8 733A 4B40 DFC5 1CF7
X-PGP-ID: 0xDFC51CF7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
On 2.4.13 release, i planed to update my kernel from 2.4.6 to 2.4.13 on
my Debian.woody.
But, after compiling an testing my usb-storage won=B4t work.=20

I searched the web and found a posting in this Kernel-List wich
described this Problem (Okt/2001) without a solving suggestion.
I tried with the new 2.4.15-pre4, but it won=B4t work with this Version
too.
Now im using 2.4.8, in which it works fine.
I took the old configs from 2.4.6 with "make oldconfig" to it,
so the fault shouldn=B4t be my  Kernel-Configuration.

Some Infos:
my Hardware:
Siemens PII-600 Lifebook S4546
Debian woody
DataFab MD2-USB 2,5" IDE Disk on Usb,=20
info on Kernel 2.4.8:
greedy:~# cat /proc/scsi/usb-storage-0/0=20
   Host scsi0: usb-storage
       Vendor: OnSpec Electronic, Inc.      =20
      Product: USB Disk
Serial Number: E01B94DC1B
     Protocol: Transparent SCSI
    Transport: Bulk
         GUID: 07c40103000000e01b94dc1b

greedy:~# cat /proc/scsi/scsi=20
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: MK1214GAP        Rev: 1 A=20
    Type:   Direct-Access                    ANSI SCSI revision: 02

Please let me know if there are any further logs, configs you need for info?

Regards=20
Christoph


The Log of the usbmgr & usb-storage (sorry it is very big :(
So, I hope this is helpfull)

kernel: usb.c: registered new driver usbdevfs
kernel: usb.c: registered new driver hub
kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
kernel: PCI: Found IRQ 15 for device 00:07.2
kernel: uhci.c: USB UHCI at I/O 0x1ca0, IRQ 15
kernel: usb.c: new USB bus registered, assigned bus number 1
kernel: uhci.c: detected 2 ports
kernel: usb.c: kmalloc IF c141fba0, numif 1
kernel: usb.c: new device strings: Mfr=3D0, Product=3D2, SerialNumber=3D1
kernel: usb.c: USB device number 1 default language ID 0x0
kernel: Product: USB UHCI-alt Root Hub
kernel: SerialNumber: 1ca0
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: hub.c: standalone hub
kernel: hub.c: ganged power switching
kernel: hub.c: global over-current protection
kernel: hub.c: Port indicators are not supported
kernel: hub.c: power on to power good time: 2ms
kernel: hub.c: hub controller current requirement: 0mA
kernel: hub.c: port removable status: RR
kernel: hub.c: local power source is good
kernel: hub.c: no over-current condition exists
kernel: hub.c: enabling power on all ports
kernel: usb.c: hub driver claimed interface c141fba0
kernel: usb.c: call_policy add, num 1 -- no FS yet
kernel: uhci.c: root-hub INT complete: port1: 80 port2: 93 data: 4
kernel: hub.c: port 2 connection change
kernel: hub.c: port 2, portstatus 101, change 1, 12 Mb/s
kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
kernel: usb.c: kmalloc IF c141fd60, numif 1
kernel: usb.c: new device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0
kernel: usb.c: USB device number 2 default language ID 0x409
kernel: Product: General Purpose USB Hub
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: hub.c: standalone hub
kernel: hub.c: ganged power switching
kernel: hub.c: global over-current protection
kernel: hub.c: Port indicators are not supported
kernel: hub.c: power on to power good time: 100ms
kernel: hub.c: hub controller current requirement: 100mA
kernel: hub.c: port removable status: RR
kernel: hub.c: local power source is good
kernel: hub.c: no over-current condition exists
kernel: hub.c: enabling power on all ports
kernel: usb.c: hub driver claimed interface c141fd60
kernel: usb.c: kusbd: /sbin/hotplug add 2
kernel: usb.c: kusbd policy returned 0xfffffffe
kernel: SCSI subsystem driver Revision: 1.00
kernel: Initializing USB Mass Storage driver...
kernel: usb.c: registered new driver usb-storage
kernel: USB Mass Storage support registered.
usbmgr[723]: start 0.4.8
kernel: usb.c: registered new driver hid
kernel: hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
kernel: hid-core.c: USB HID support drivers
kernel: mice: PS/2 mouse device common for all mice
usbmgr[726]: "hid" was loaded
usbmgr[726]: "mousedev" was loaded
usbmgr[726]: open error "host"
usbmgr[731]: mount /proc/bus/usb
usbmgr[726]: class:0x9 subclass:0x0 protocol:0x0
usbmgr[726]: USB device is matched the configuration
usbmgr[726]: "none" isn't loaded
usbmgr[726]: vendor:0x451 product:0x2036
usbmgr[726]: class:0x9 subclass:0x0 protocol:0x0
usbmgr[726]: USB device is matched the configuration
usbmgr[726]: "none" isn't loaded
kernel: uhci.c: root-hub INT complete: port1: 93 port2: 95 data: 2
kernel: hub.c: port 1 connection change
kernel: hub.c: port 1, portstatus 101, change 1, 12 Mb/s
kernel: hub.c: port 1, portstatus 103, change 0, 12 Mb/s
kernel: hub.c: USB new device connect on bus1/1, assigned device number 3
kernel: usb.c: kmalloc IF cc54cf00, numif 1
kernel: usb.c: new device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
kernel: usb.c: USB device number 3 default language ID 0x409
kernel: Manufacturer: OnSpec Electronic, Inc.      =20
kernel: Product: USB Disk
kernel: SerialNumber: E01B94DC1B
kernel: usb-storage: act_altsettting is 0
kernel: usb-storage: id_index calculated to be: 72
kernel: usb-storage: Array length appears to be: 74
kernel: usb-storage: USB Mass Storage device detected
kernel: usb-storage: Endpoints: In: 0xcb4273f4 Out: 0xcb4273e0 Int: 0x00000=
000 (Period 0)
kernel: usb-storage: New GUID 07c40103000000e01b94dc1b
kernel: usb-storage: GetMaxLUN command result is -32, data is 202
kernel: usb-storage: clearing endpoint halt for pipe 0x80000380
kernel: usb-storage: Transport: Bulk
kernel: usb-storage: Protocol: Transparent SCSI
kernel: usb-storage: *** thread sleeping.
kernel: scsi0 : SCSI emulation for USB Mass Storage devices
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command INQUIRY (6 bytes)
kernel: usb-storage: 12 00 00 00 ff 00 00 00 95 52 18 c0
kernel: usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 255 F 12=
8 CL 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 255/255
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x1 R 0 Stat 0x0
kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel:   Vendor:           Model:                   Rev:    =20
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad LUN (0/1)
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad target number (1/0)
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad target number (2/0)
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad target number (3/0)
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad target number (4/0)
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad target number (5/0)
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad target number (6/0)
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Bad target number (7/0)
kernel: usb-storage: *** thread sleeping.
kernel: WARNING: USB Mass Storage data integrity not assured
kernel: USB Mass Storage device found at 3
kernel: usb.c: usb-storage driver claimed interface cc54cf00
kernel: usb.c: kusbd: /sbin/hotplug add 3
kernel: usb.c: kusbd policy returned 0xfffffffe
usbmgr[726]: vendor:0x7c4 product:0x103
usbmgr[726]: class:0x8 subclass:0x6 protocol:0x50
usbmgr[726]: USB device is matched the configuration
kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
kernel: usb-storage: 00 00 00 00 00 00 00 00 00 00 00 00
kernel: usb-storage: Bulk command S 0x43425355 T 0xa Trg 0 LUN 0 L 0 F 0 CL=
 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0xa R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command READ_CAPACITY (10 bytes)
kernel: usb-storage: 25 00 00 00 00 00 00 00 00 00 00 00
kernel: usb-storage: Bulk command S 0x43425355 T 0xb Trg 0 LUN 0 L 8 F 128 =
CL 10
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 8 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 8/8
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0xb R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel: SCSI device sda: 23579137 512-byte hdwr sectors (12073 MB)
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command MODE_SENSE (6 bytes)
kernel: usb-storage: 1a 00 3f 00 ff 00 00 00 00 00 00 00
kernel: usb-storage: Bulk command S 0x43425355 T 0xc Trg 0 LUN 0 L 255 F 12=
8 CL 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/255
kernel: usb-storage: Bulk data transfer result 0x1
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: clearing endpoint halt for pipe 0xc0010380
kernel: usb-storage: Attempting to get CSW (2nd try)...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0xc R 243 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel: sda: Write Protect is off
kernel:  sda:<7>usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command READ_10 (10 bytes)
kernel: usb-storage: 28 00 00 00 00 00 00 00 08 00 00 00
kernel: usb-storage: Bulk command S 0x43425355 T 0xd Trg 0 LUN 0 L 4096 F 1=
28 CL 10
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0xd R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel:  sda1 <<7>usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command READ_10 (10 bytes)
kernel: usb-storage: 28 00 00 00 00 38 00 00 08 00 00 00
kernel: usb-storage: Bulk command S 0x43425355 T 0xe Trg 0 LUN 0 L 4096 F 1=
28 CL 10
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 4096/4096
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0xe R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel:  sda5 >
usbmgr[726]: "scsi_mod" was loaded
usbmgr[726]: "sd_mod" was loaded
usbmgr[726]: "usb-storage" was loaded
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command START_STOP (6 bytes)
kernel: usb-storage: 1b 00 00 00 01 00 00 00 60 65 ff bf
kernel: usb-storage: Bulk command S 0x43425355 T 0xf Trg 0 LUN 0 L 0 F 0 CL=
 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0xf R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
kernel: usb-storage: 1e 00 00 00 01 00 ff ff d8 fe 12 c0
kernel: usb-storage: Bulk command S 0x43425355 T 0x10 Trg 0 LUN 0 L 0 F 0 C=
L 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x10 R 0 Stat 0x1
kernel: usb-storage: -- transport indicates command failure
kernel: usb-storage: Issuing auto-REQUEST_SENSE
kernel: usb-storage: Bulk command S 0x43425355 T 0x10 Trg 0 LUN 0 L 18 F 12=
8 CL 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x10 R 0 Stat 0x0
kernel: usb-storage: -- Result from auto-sense is 0
kernel: usb-storage: -- code: 0x0, key: 0x0, ASC: 0x0, ASCQ: 0x0
kernel: usb-storage: No Sense: no additional sense information
kernel: usb-storage: scsi cmd done, result=3D0x2
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command REQUEST_SENSE (6 bytes)
kernel: usb-storage: 03 00 00 00 ff 00 ff ff d8 fe 12 c0
kernel: usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 0 L 255 F 12=
8 CL 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 255/255
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x0 R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: device_reset() called
kernel: usb-storage: Bulk reset requested
kernel: usb-storage: Bulk soft reset completed
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
kernel: usb-storage: 00 00 00 00 00 00 ff ff d8 fe 12 c0
kernel: usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 0 L 0 F 0 CL=
 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x0 R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
kernel: usb-storage: 1e 00 00 00 01 00 ff ff d8 fe 12 c0
kernel: usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 0 L 0 F 0 CL=
 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x0 R 0 Stat 0x1
kernel: usb-storage: -- transport indicates command failure
kernel: usb-storage: Issuing auto-REQUEST_SENSE
kernel: usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 0 L 18 F 128=
 CL 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x0 R 0 Stat 0x0
kernel: usb-storage: -- Result from auto-sense is 0
kernel: usb-storage: -- code: 0x0, key: 0x0, ASC: 0x0, ASCQ: 0x0
kernel: usb-storage: No Sense: no additional sense information
kernel: usb-storage: scsi cmd done, result=3D0x2
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: bus_reset() called
kernel: uhci.c: root-hub INT complete: port1: 288 port2: 95 data: 2
kernel: hub.c: port 1 enable change, status 110
kernel: hub.c: port 1, portstatus 103, change 0, 12 Mb/s
kernel: usb-storage: Examinging driver usb-storage...skipping ourselves.
kernel: usb-storage: bus_reset() complete
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
kernel: usb-storage: 00 00 00 00 00 00 ff ff d8 fe 12 c0
kernel: usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 0 L 0 F 0 CL=
 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x0 R 0 Stat 0x0
kernel: usb-storage: scsi cmd done, result=3D0x0
kernel: usb-storage: *** thread sleeping.
kernel: usb-storage: queuecommand() called
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
kernel: usb-storage: 1e 00 00 00 01 00 ff ff d8 fe 12 c0
kernel: usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 0 L 0 F 0 CL=
 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x0 R 0 Stat 0x1
kernel: usb-storage: -- transport indicates command failure
kernel: usb-storage: Issuing auto-REQUEST_SENSE
kernel: usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 0 L 18 F 128=
 CL 6
kernel: usb-storage: Bulk command transfer result=3D0
kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
kernel: usb-storage: Bulk data transfer result 0x0
kernel: usb-storage: Attempting to get CSW...
kernel: usb-storage: Bulk status result =3D 0
kernel: usb-storage: Bulk status Sig 0x53425355 T 0x0 R 0 Stat 0x0
kernel: usb-storage: -- Result from auto-sense is 0
kernel: usb-storage: -- code: 0x0, key: 0x0, ASC: 0x0, ASCQ: 0x0
kernel: usb-storage: No Sense: no additional sense information
kernel: usb-storage: scsi cmd done, result=3D0x2
kernel: usb-storage: *** thread sleeping.
kernel: scsi: device set offline - not ready or command retry failed after =
bus reset: host 0 channel 0 id 0 lun 0
kernel:  I/O error: dev 08:05, sector 0
kernel: uhci.c: root-hub INT complete: port1: 8a port2: 95 data: 2
kernel: hub.c: port 1 connection change
kernel: hub.c: port 1, portstatus 100, change 3, 12 Mb/s
kernel: usb.c: USB disconnect on device 3
kernel: usb-storage: storage_disconnect() called
kernel: usb-storage: -- releasing main URB
kernel: usb-storage: -- usb_unlink_urb() returned -19
kernel: usb.c: kusbd: /sbin/hotplug remove 3
kernel: usb.c: kusbd policy returned 0xfffffffe
kernel: uhci.c: root-hub INT complete: port1: 88 port2: 95 data: 2
kernel: hub.c: port 1 enable change, status 100
kernel: usb-storage: usb_stor_exit() called
kernel: usb-storage: -- calling usb_deregister()
kernel: usb.c: deregistering driver usb-storage
kernel: usb-storage: -- calling scsi_unregister_module()
kernel: usb-storage: release() called for host usb-storage
kernel: usb-storage: -- sending US_ACT_EXIT command to thread
kernel: usb-storage: *** thread awakened.
kernel: usb-storage: -- US_ACT_EXIT command received
kernel: scsi : 0 hosts left.
usbmgr[726]: "scsi_mod" was unloaded
usbmgr[726]: "sd_mod" was unloaded
usbmgr[726]: "usb-storage" was unloaded
init: Switching to runlevel: 6
usbmgr[1787]: umount /proc/bus/usb
usbmgr[726]: bye!

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE78a+jczpLQN/FHPcRAm/YAJ4yOkiLX4R0pZfDQ5jbsYPkeAiM+wCg0P/u
imVqjo2aUpGRm2/GfDRfNcw=
=0OYM
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
