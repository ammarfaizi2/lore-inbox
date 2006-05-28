Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWE1VCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWE1VCm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWE1VCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:02:42 -0400
Received: from proof.pobox.com ([207.106.133.28]:28040 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750924AbWE1VCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:02:42 -0400
Date: Sun, 28 May 2006 14:02:38 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell Inspiron
 6000
Message-Id: <20060528140238.2c25a805.dickson@permanentmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I follow the Fedora development kernels and noticed that resuming from
suspending (and hibernate) stopped working at 2.6.16-git15 (Fedora Core
kernel 2102).  Trouble was, my only previous kernel was 2.6.16-rc6-git12
(FC 2064) because I had been out of town for nearly two weeks (I did have
limited net access and that's how I got that last working version).

So yesterday I embarked on a git bisect of the problem.  My first was to
test my two end points and then the release in between (2.6.16).

good	2.6.16-rc6
good	2.6.16
bad	2.6.17-rc1

Building and testing a good kernel takes me about 70 minutes.  If I make
mistakes it can easily take two times (or more!) longer.

I'm cuurently tracking my work at:
    https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108

I'm currently building my fifth bisect.

00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
03:00.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX (rev 02)
03:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
03:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 08)
03:01.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 17)
03:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network Connection (rev 05)

	-Paul

