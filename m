Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284837AbRLXNi3>; Mon, 24 Dec 2001 08:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284857AbRLXNiU>; Mon, 24 Dec 2001 08:38:20 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:386 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S284837AbRLXNiL>; Mon, 24 Dec 2001 08:38:11 -0500
From: spamtrap@use.reply-to (Erik Hensema)
Subject: bug: de2104x driver in 2.5.1
Date: 24 Dec 2001 13:38:08 GMT
Message-ID: <slrna2ebu0.39m.spamtrap@dexter.hensema.xs4all.nl>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.6.3 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last weekend my cablemodem connection went dead. I was running 2.5.1 using
the de2104x driver (previously the tulip driver).

/var/log/messages:

Dec 22 04:43:28 dexter kernel: eth0: 10baseT auto link ok, mode 7ffc2002 status 51c8
Dec 22 04:44:28 dexter kernel: eth0: 10baseT auto link ok, mode 7ffc2002 status 51c8
Dec 22 04:45:28 dexter kernel: eth0: 10baseT auto link ok, mode 7ffc2002 status 51c8
Dec 22 04:46:28 dexter kernel: eth0: 10baseT auto link ok, mode 7ffc2002 status 51c8
Dec 22 04:46:37 dexter kernel: eth0: link down
Dec 22 04:46:42 dexter kernel: eth0: link up, media 10baseT-HD
Dec 22 04:46:42 dexter kernel: eth0: set link 10baseT-HD, mode 7ffc0000, sia c0,ffffef01,ffff6f3f,ffff0008
Dec 22 04:46:42 dexter kernel:                  set mode 7ffc0000, set sia ef01,6f3f,8
Dec 22 04:46:42 dexter kernel: bug: kernel timer added twice at cc8ed139.
Dec 22 04:46:42 dexter kernel: eth0: no link, trying media 10baseT-HD, status 21ce
Dec 22 04:47:41 dexter kernel: eth0: 10baseT-HD link ok, mode 7ffc2002 status 1c0
Dec 22 04:48:41 dexter kernel: eth0: 10baseT-HD link ok, mode 7ffc2002 status 1c0
Dec 22 04:49:41 dexter kernel: eth0: 10baseT-HD link ok, mode 7ffc2002 status 1c0

(the messages are repeated every minute)

dexter:~$ /sbin/lspci 
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:0a.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
00:0c.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)

-- 
Erik Hensema (erik@hensema.net)
I'm on the list, no need to Cc: me, though I appreciate one if your
mailer doesn't support the References header.
