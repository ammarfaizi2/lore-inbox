Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVK0P5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVK0P5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 10:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVK0P5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 10:57:37 -0500
Received: from ns.tasking.nl ([195.193.207.2]:18393 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S1751099AbVK0P5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 10:57:36 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: ppdev interface for USB to parallel port adapter?
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <254.4389d740.5e12d@altium.nl>
Date: Sun, 27 Nov 2005 15:56:48 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an AVR microcontroller programmer that connects to the parallel
port. It is controlled by a programm called avrdude that uses the
ppdev programming interface on /dev/parport* to manipulate the
parallel port I/O signals.

On my legacy-free laptop, I use an external USB-BAY that provides a
serial and parallel port. However, this parallel port is controlled by
the usblp driver, and cannot be accesed via ppdev. I checked the usblp
driver to see if parport support could be added, but I'm not sure.
It isn't clear to me whether the USB protocol provides enough
functionality to implement the ppdev ioctl's. Can anyone shed some
light on this?

BTW, lsusb reports for this device:

Bus 001 Device 005: ID 0711:0300 Magic Control Technology Corp. BAY-3U1S1P Parallel Port

and the kernel reports:

Nov 27 16:48:24 zaphod kernel: usb 1-1.5: new full speed USB device using uhci_hcd and address 9
Nov 27 16:48:25 zaphod kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 9 if 0 alt 1 proto 2 vid 0x0711 pid 0x0300

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

