Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbTLIUcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbTLIU37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:29:59 -0500
Received: from fmr02.intel.com ([192.55.52.25]:44691 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S266145AbTLIU3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:29:19 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: ACPI Bug: 2.6.0-test11, Incomplete pci bus scan
Date: Tue, 9 Dec 2003 15:28:59 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC88D4@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI Bug: 2.6.0-test11, Incomplete pci bus scan
Thread-Index: AcO+kLb7FyAxOMwsQRm1aFcx0CFJoAAACgwQ
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Walrond" <andrew@walrond.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Dec 2003 20:29:05.0223 (UTC) FILETIME=[1705C570:01C3BE93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
This may be a duplicate of a dual P3 serverworks failure:
http://bugzilla.kernel.org/show_bug.cgi?id=1585

But as I've got no feedback on that bug, feel free to file a new one --
worst case we'll end up closing it as a dupe when we get to the bottom
of it.

Thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.

> -----Original Message-----
> From: Andrew Walrond [mailto:andrew@walrond.org] 
> Sent: Tuesday, December 09, 2003 3:03 PM
> To: linux-kernel@vger.kernel.org
> Cc: Brown, Len
> Subject: ACPI Bug: 2.6.0-test11, Incomplete pci bus scan
> 
> 
> Asus PR-DLS Dual Xeon (P4) motherboard
> 
> 2.6.0-test11 kernel with acpi configured.
> 
> If I boot normally, the e1000 device is not recognised.
> If I boot with pci=noacpi, the e1000 is recognised ( but 
> e100/e1000 are 
> assigned opposite ethx compared to 2.4)
> 
> lspci in both cases gives these devices
> 
> 00:00.0 Host bridge: ServerWorks CMIC-LE (rev 13)
> 00:00.1 Host bridge: ServerWorks CMIC-LE
> 00:00.2 Host bridge: ServerWorks: Unknown device 0000
> 00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet 
> Pro 100] (rev 10)
> 00:03.0 VGA compatible controller: ATI Technologies Inc Rage 
> XL (rev 27)
> 00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
> 00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
> 00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
> 00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
> 
> But these extra devices only appear when booting with 
> pci=noacpi. Net access 
> to a machine can also be arranged if it would help
> 
> 02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 
> 53c1030 (rev 07)
> 02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 
> 53c1030 (rev 07)
> 03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit 
> Ethernet Controller 
> (LOM) (rev 02)
> 
> If I can give any further info, let me know.
> 
> As a seperate issue, with pci=noacpi, both the net interfaces 
> are recognised, 
> but in reverse order to 2.4 kernel (eth0 <=> eth1)
> 
> Andrew Walrond
> 
> 
