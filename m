Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTDPQrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTDPQq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:46:57 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:35485 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S264519AbTDPQpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:45:54 -0400
From: "Riley Williams" <rhw@MemAlpha.fslife.co.uk>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: firmware separation filesystem (fwfs)
Date: Wed, 16 Apr 2003 17:57:41 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAKEDNCHAA.rhw@MemAlpha.fslife.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

 >> On the other hand, there are already many drivers in the kernel
 >> that include firmware in headers, keyspan, io_edgeport, dabusb,
 >> ser_a2232, sym53c8xx_2, ...

 > But so would loading it from hotplug via ioctl. It might be we
 > want a clean hotplug way to ask for 'firmware for xyz'.

I know that PCI uses a 32-bit number (or two 16-bit numbers if one
prefers to think of it that way) to identify each piece of equipment.
Is there a similar number for USB, Firewire, etc?

If so, the hotplug firmware driver could use those numbers prefixed
by a code for the relevant bus to identify the relevant firmware.
For example...

	P:1234:5678		PCI Bus code 1234:5678
	U:1234:5678		USB Bus code 1234:5678

...and the hotplug driver would know whether those two were the same
device on different buses, or two different devices.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.471 / Virus Database: 269 - Release Date: 10-Apr-2003

