Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUDPHkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 03:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUDPHkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 03:40:21 -0400
Received: from fmr01.intel.com ([192.55.52.18]:59042 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262605AbUDPHkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 03:40:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] fix Acer TravelMate 360 interrupt routing
Date: Fri, 16 Apr 2004 03:39:47 -0400
Message-ID: <29AC424F54821A4FB5D7CBE081922E401F8579@hdsmsx403.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix Acer TravelMate 360 interrupt routing
Thread-Index: AcQjdBibneX62bA3QP2kq7pDVIAtjgAEaZag
From: "Brown, Len" <len.brown@intel.com>
To: "Kitt Tientanopajai" <kitt@gear.kku.ac.th>, <daniel.ritz@gmx.ch>
Cc: <daniel.ritz@alcatel.ch>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>
X-OriginalArrivalTime: 16 Apr 2004 07:39:48.0214 (UTC) FILETIME=[FE96E160:01C42385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>Linux version 2.6.5-mm4 (root@peorth.kitty.in.th) (gcc version 
>3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 Sun Apr 11 11:46:57 ICT 2004
...
>Acer TravelMate 36x Laptop detected - fixing broken IRQ routing
>Acer TravelMate 36x Laptop detected: force use of pci=noacpi

Kitt,
The patch is a platform specific workaround that forces "pci=noacpi"
for this specific machine -- as if you supplied it on the cmdline.

The idea is to run the kernel w/o this patch and see
If we can fix the root cause, thus possibly helping other
systems which have the same problem.

If we fail to find/fix the root cause, or discover that
the platform has an issue that we simply can't fix
in the kernel, then it makes sense to add this automatic
workaround, but not before.

>> >
>> > So for the ACPI mode part, I encourage you to file a bug here
>> >
>> > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>> > Component Config-Interrupts
>> > and assign it to me.  Or if a bug is open already,
>> > please direct me to it.
>> >
>> > thanks,
>> > -Len
