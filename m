Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVHETGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVHETGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVHETEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:04:37 -0400
Received: from imap.gmx.net ([213.165.64.20]:160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262718AbVHETDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:03:06 -0400
X-Authenticated: #3439220
From: Martin Maurer <martinmaurer@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Elitegroup K7S5A + usb_storage problem
Date: Fri, 5 Aug 2005 21:02:57 +0200
User-Agent: KMail/1.7.2
References: <200508051751.34496.martinmaurer@gmx.at>
In-Reply-To: <200508051751.34496.martinmaurer@gmx.at>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1204521.Fj763hPrA9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508052102.59872.martinmaurer@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1204521.Fj763hPrA9
Content-Type: multipart/mixed;
  boundary="Boundary-01=_hf78CpcyqoxpMu8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_hf78CpcyqoxpMu8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

An update on this issue:

I realized a problem with my kernel configuration - i was missing sd_mod. T=
his=20
fixed the problem with the harddrive, but the usb stick still doesn't work.
attached a new dmesg output of the mp3stick problem (only very little chang=
es)

greetings
Martin Maurer

On Friday, 5. August 2005 17:51, Martin Maurer wrote:
> Hi everybody,
>
> For quite some time now I have got a problem mounting my usb-stick (MP3
> FUN256 from DNT) with linux. This stick worked back in the 2.4.x days,
> though it needed one of the later versions (I switched to 2.6.x as soon
> about when it was released, so I didnt test the newest versions.)
>
> Recently I bought an usb harddisk encasing and tried this one, but it
> doesnt work either. Taking a look at dmesg I think the devices are not
> correctly found by the kernel. (I attached the two dmesg outputs).
>
> As I dont know which part of the kernel causes this problem I did not so
> far report a bug using bugzilla. (And as it may be my fault too).
>
> I currently use 2.6.13-rc5 + software-suspoend 2 patch 2.1.9.12
> (I tried 2.6.12-rc5, and some earlier versions too)
>
> Processor: AMD Athlon XP 1700+
> Distribution: Debian unstable (though not updated for about a month).
>
> Anyone knows help for this issues ?
> (patches to try and verify happily accepted)
>
> greetings
> Martin Maurer

--Boundary-01=_hf78CpcyqoxpMu8
Content-Type: text/plain;
  charset="iso-8859-1";
  name="mp3stick.dmesg.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mp3stick.dmesg.2"

hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
hub 1-1:1.0: port 4, status 0101, change 0001, 12 Mb/s
hub 1-1:1.0: debounce: port 4: total 100ms stable 100ms status 0x101
usb 1-1.4: new full speed USB device using ohci_hcd and address 18
usb 1-1.4: ep0 maxpacket = 32
usb 1-1.4: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1.4: hotplug
usb 1-1.4: adding 1-1.4:1.0 (config #1, interface 0)
usb 1-1.4:1.0: hotplug
usb-storage 1-1.4:1.0: usb_probe_interface
usb-storage 1-1.4:1.0: usb_probe_interface - got id
usb-storage: USB Mass Storage device detected
usb-storage: -- associate_dev
usb-storage: Vendor: 0x0f19, Product: 0x0103, Revision: 0x0100
usb-storage: Interface Subclass: 0x06, Protocol: 0x50
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is -32, data is 85
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=01 len=0
usb-storage: usb_stor_clear_halt: result = 0
scsi10 : SCSI emulation for USB Mass Storage devices
usb-storage: *** thread sleeping.
hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
usb-storage: device found at 18
usb-storage: waiting for device to settle before scanning
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 13/36
usb-storage: -- short transfer
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
ohci_hcd 0000:00:02.2: urb cf61ca60 path 1.4 ep2in 82160000 cc 8 --> status -75
usb-storage: Status code -75; transferred 13/13
usb-storage: -- babble
usb-storage: Bulk status result = 3
usb-storage: -- transport indicates error, resetting
hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
usb 1-1.4: reset full speed USB device using ohci_hcd and address 18
hub 1-1:1.0: state 5 ports 4 chg 0000 evt 0010
usb 1-1.4: ep0 maxpacket = 32
usb-storage: usb_reset_device returns 0
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x2 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x2 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000002 L 18 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000002 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
usb-storage: Illegal Request: Invalid field in cdb
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: device scan complete

--Boundary-01=_hf78CpcyqoxpMu8--

--nextPart1204521.Fj763hPrA9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC87fjXHsqb5Up6wURAj8GAKC5tZywATmMvmUKJNZo+q20Yl91sgCfcyol
7PMm86nPGJY3cgyyPtA9SUU=
=OSXz
-----END PGP SIGNATURE-----

--nextPart1204521.Fj763hPrA9--
