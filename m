Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130684AbRCEVfh>; Mon, 5 Mar 2001 16:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130686AbRCEVf2>; Mon, 5 Mar 2001 16:35:28 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:31293 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S130684AbRCEVfV>; Mon, 5 Mar 2001 16:35:21 -0500
Date: Mon, 5 Mar 2001 15:35:14 -0600
From: Matthew Fredrickson <matt@frednet.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: [jford@tusc.net: LUNA: Megaraid problems]
Message-ID: <20010305153514.A789@frednet.dyndns.org>
Reply-To: luna-list@luna.huntsville.al.us
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <luna-list-return-12816-matt=frednet.dyndns.org@luna.huntsville.al.us>
Delivered-To: matt@frednet.dyndns.org
Received: (qmail 739 invoked from network); 5 Mar 2001 21:12:06 -0000
Received: from servatus.dinkdonk.com (216.207.242.129)
  by user-33qt4ng.dialup.mindspring.com with SMTP; 5 Mar 2001 21:12:06 -0000
Received: (qmail 31484 invoked by uid 1013); 5 Mar 2001 14:05:23 -0000
Mailing-List: contact luna-list-help@luna.huntsville.al.us; run by ezmlm
Delivered-To: mailing list luna-list@luna.huntsville.al.us
Received: (qmail 31477 invoked from network); 5 Mar 2001 14:05:23 -0000
X-Authentication-Warning: ns2.uronramp.net: jford owned process doing -bs
Date: Sun, 4 Mar 2001 21:12:41 -0600 (CST)
From: James Ford <jford@tusc.net>
X-Sender: <jford@ns2.onramp.tuscaloosa.al.us>
To: <luna-list@luna.huntsville.al.us>
Message-ID: <Pine.GSO.4.30.0103042112090.27588-100000@ns2.onramp.tuscaloosa.al.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: LUNA: Megaraid problems

I have a machine with a built-in Adaptec aic7xxx card and a Megaraid PCI
card.  My system (raid 5) boots off the Megaraid.  For this to work I
compiled the Megaraid module into the kernel while the aic7xxx loads as a
module.  dmesg shows the following:

megaraid: v107 (December 22, 1999)
megaraid: found 0x101e:0x9010:idx 0:bus 0:slot 14:func 0
scsi0 : Found a MegaRAID controller at 0x7810, IRQ: 10
megaraid: [UF80:1.61] detected 1 logical drives
scsi0 : AMI MegaRAID UF80 254 commands 16 targs 3 chans 8 luns
scsi : 1 host.
scsi0: scanning channel 1 for devices.
scsi0: scanning channel 2 for devices.
scsi0: scanning channel 3 for devices.
scsi0: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5 34712R  Rev: UF80
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 3, id 0, lun 0
scsi : detected 1 SCSI generic 1 SCSI disk total.

Works great with kernel 2.2.16.  Worked great up to kernel 2.3.99-test8 or
so.  However under the current 2.4.x kernels (2.4.0, 2.4.1, 2.4.2) I get
the following message:

scsi subsystem driver rev 1.0
megaraid: v107 (Dec 22, 1999)
megaraid: found 0x101e: 0x9010: in 00:0e.0
scsi0: found a megaraid controller at 0x7810, irq 10
megaraid: couldn't register I/O register
requested_modules[scsi_hostadapter] root fs not found
(repeat above 2 more time)
VFS - cannot open boot device 806 or 08:06

which makes sense - can't register device, can open device. The only
difference I've been able to find between the working and non-working
kernels is the "SCSI Subsystem Driver Rev 1.0" line.

So, what direction should I go?  Anyone have any pointers?

Tia.

-- James



----
LUNA-LIST help:                  luna-list-help@luna.huntsville.al.us
To unsubscribe:           luna-list-unsubscribe@luna.huntsville.al.us
To email the list keeper:                        todd@toddstevens.net 
LUNA-LIST Web Site:   <URL:http://luna.huntsville.al.us/lunalist.htm>


--C7zPtVaVf+AK4Oqc--
