Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVC3ALe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVC3ALe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVC3ALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:11:34 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:46582 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261683AbVC3ALW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:11:22 -0500
From: Ron Gage <ron@rongage.org>
To: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, jonas.oreland@mysql.com
Subject: Continuing woes - Yenta PCMCIA and USB 2.0 Cardbus Card
Date: Tue, 29 Mar 2005 19:06:19 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503291906.19890.ron@rongage.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

I am trying to get a generic cardbus based USB 2.0 card working with an 
external USB hard drive.  Even though I have received some good help to date, 
things are still not going well.

The original problem was that inserting the cardbus card into my laptop would 
cause the entire PCMCIA system to die instantly.  This problem is fixed - 
inserting the card no longer kills the PCMCIA system.

What appears to be happening now is that there are codepath problems in the 
EHCI/UHCI/OHCI code as they relate to the SCSI Disk driver.  All this is 
tested against 2.6.11.6 on a Slackware 9.1 based laptop.

The USB drive works perfectly (albiet very slowly) when plugged directly into 
the laptop's USB 1.1 port.

When the USB drive is plugged into the USB 2.0 cardbus card, the drive is ID'd 
correctly (make/model), but the driver can not read the partition table.  
Attempting to mount the drive doesn't work.  Unplugging the USB drive causes 
the lockup to unlock.

Plugging a USB keydrive into the USB 2.0 card causes no problems.  Drive is 
ID'd, make/model read, partition table read, can read/write/mount the key 
drive without issue.  Same when plugging the keydrive into the laptop's 
USB1.1 port.

Laptop is an HP Pavilion N5150, Intel USB chipset (UHCI).  Cardbus card is 
generic ALI based USB chipset (EHCI/OHCI).  USB drive is a Sony VAIO external 
case for a 2.5" drive.  The chip in the usb drive has no manufacturer 
markings on it, just the following character sequences: CS881BAG, 0451B0C104, 
107

HELP!!!!


-- 
Ron Gage - Pontiac, Michigan
(MCP, LPIC1, A+, Net+)
