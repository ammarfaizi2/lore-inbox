Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbTH0RHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTH0RHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:07:32 -0400
Received: from fmr09.intel.com ([192.52.57.35]:50668 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263410AbTH0RHa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:07:30 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Interesting problem with 450NX based Compaq server
Date: Wed, 27 Aug 2003 10:07:27 -0700
Message-ID: <C1B7430B33A4B14F80D29B5126C5E94701191DBB@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Interesting problem with 450NX based Compaq server
Thread-Index: AcNrk0wE5IJXr3bxR8OYpbNaj6X1QABKjkXQ
From: "Mroczek, Joseph T" <joseph.t.mroczek@intel.com>
To: "Bryan Ballard" <ballard@netsolus.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Aug 2003 17:07:27.0805 (UTC) FILETIME=[B17046D0:01C36CBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most 450NX systems have SMC/SMC/Shahalee controller. Check the compaq
diagnostics hardware log. It should contain the reason for the reboot.

~joe

-----Original Message-----
From: Bryan Ballard [mailto:ballard@netsolus.com] 
Sent: Monday, August 25, 2003 10:24 PM
To: linux-kernel@vger.kernel.org
Subject: Interesting problem with 450NX based Compaq server


Hello, I've looked through the kernel list archives and haven't found
anything that might help. I have a Compaq 5500r 4x500mhz Xeons and
whenever a heavy load is placed on the box it reboots without any kernel
panics or oops. It seems to be related primarily to multiple PCI card
access, i.e. during heavy RAID card / NIC interaction. I've tried to
isolate it by replacing NICs and RAID cards, but the only thing I can
come up with is that it is related to the 450NX chipset. 
Since I am not sure anyone is still working on the 450NX chipset I've
refrained from cluttering the list with a giant E-mail full of /proc
data until someone answers back that they would be interested in any
information that I can provide them.

Please CC me since I am not a list subscriber. 
Thanks in advance.

	Bryan Ballard

output of lspci:

00:02.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev
01)
00:0c.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
14)
00:0d.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
14)
00:0e.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
215IIC [Mach64 GT IIC] (rev 7a)
00:0f.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:0f.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:0f.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:0f.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:10.0 Host bridge: Intel Corp. 450NX - 82451NX Memory & I/O Controller
(rev 03)
00:12.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander
Bridge (rev 04)
00:13.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander
Bridge (rev 04)
04:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 05)
04:05.0 PCI bridge: IBM IBM27-82351 (rev 01)
05:00.0 Unknown mass storage controller: Compaq Computer Corporation
Smart-2/P RAID Controller (rev 02)




   

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
