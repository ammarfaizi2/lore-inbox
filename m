Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288732AbSANEOd>; Sun, 13 Jan 2002 23:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288731AbSANEOZ>; Sun, 13 Jan 2002 23:14:25 -0500
Received: from mta06ps.bigpond.com ([144.135.25.138]:50922 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S288594AbSANEOM>; Sun, 13 Jan 2002 23:14:12 -0500
Message-Id: <5.1.0.14.0.20020114150837.01e7d560@mail.bigpond.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Jan 2002 15:14:06 +1100
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
From: Dylan Egan <crack_me@bigpond.com.au>
Subject: Diamond Data USB CD-RW
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently recieved a Diamond Data USB CD-RW of my friend hopefully to keep 
but i can't seem to get it to work under linux.

Log INFO:
nitializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi1 : SCSI emulation for USB Mass Storage devices
   Vendor: H45 Tech  Model: ScanLogic USB AT  Rev: 0260
   Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sda : block size assumed to be 512 bytes, disk size 1GB.
  sda: I/O error: dev 08:00, sector 0
  I/O error: dev 08:00, sector 0
  unable to read partition table
scsi2 : SCSI emulation for USB Mass Storage devices
   Vendor: ATAPI     Model: CD-R/RW 4X4X32    Rev: A.AZ
   Type:   CD-ROM                             ANSI SCSI revision: 02
USB Mass Storage support registered.

t:~# mount /dev/scd0 /mnt/cdrw/
Attached scsi CD-ROM sr0 at scsi2, channel 0, id 0, lun 0
usb-uhci.c: interrupt, status 3, frame# 1697
sr0: scsi3-mmc drive: 6x/6x writer cd/rw xa/form2 cdda tray
  I/O error: dev 0b:00, sector 0
/dev/scd0: Input/output error
mount: you must specify the filesystem type

t:~# mount -t iso9660 /dev/scd0 /mnt/cdrw/
mount: block device /dev/scd0 is write-protected, mounting read-only
  I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
mount: wrong fs type, bad option, bad superblock on /dev/scd0,
        or too many mounted file systems

More INFO:
T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=c800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04ce ProdID=0002 Rev= 2.60
S:  Manufacturer=ScanLogic USBIDE
S:  Product=ScanLogic USBIDE
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=1189 ProdID=6000 Rev= a.03
S:  Product=USB Optical Storage Device
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=02 Prot=00 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=  1ms
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=cc00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=05e3 ProdID=0502 Rev= 1.80
S:  Product=USB Host To Host Bridge
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=  8mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usbnet
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl= 16ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms

dmesg:
*** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 07 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 08 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 09 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 0a 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 0b 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 0c 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 0d 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 0e 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: 0
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 0f 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: 0
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 10 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: 0
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_TOC (10 bytes)
usb-storage: 43 02 00 00 00 00 11 00 0c 00 89 d0
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 12 bytes
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: 0
usb-storage: usb_stor_bulk_msg() returned 0 xferred 12/12
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 72 cf 10 bd 72 cf
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage: 1e 00 00 00 01 00 13 c0 00 0b 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 00 00 14 18 45 cf
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 00 00 00 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage: 28 00 00 00 00 10 00 00 01 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 2048 bytes
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x1)
usb-storage: -- Current value of ip_waitq is: 0
usb-storage: usb_stor_bulk_msg() returned 0 xferred 2048/2048
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 1
usb-storage: Got interrupt data (0x0, 0x1)
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: 0
usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
usb-storage: usb_stor_transfer_partial(): transfer complete
usb-storage: CBI data stage result is 0x0
usb-storage: Current value of ip_waitq is: 1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x64, ASCQ: 0x0
usb-storage: Illegal Request: (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
  I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage: 1e 00 00 00 00 00 72 cf 00 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 19 c0 00 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 9c cf 02 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage: 1e 00 00 00 00 00 72 cf 00 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: Current value of ip_waitq is: 0
usb-storage: USB IRQ recieved for device on host 2
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: -1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.


Please Help.

Regards,

Dylan

P.S i also am not able to get my cd-rw which is in my usb-ide box to 
write.. i can read cd's but not write

