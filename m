Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWAWWRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWAWWRO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWAWWRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:17:13 -0500
Received: from fmr15.intel.com ([192.55.52.69]:55772 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030202AbWAWWRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:17:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: EHCI + APIC errors = no usb goodness
Date: Mon, 23 Jan 2006 17:16:23 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005CF0F7E@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EHCI + APIC errors = no usb goodness
Thread-Index: AcYgYSsFMotqOhd6T3u7A6+5XasheQACOWOQ
From: "Brown, Len" <len.brown@intel.com>
To: "Greg KH" <gregkh@suse.de>, "David Brownell" <david-b@pacbell.net>,
       <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 23 Jan 2006 22:16:56.0982 (UTC) FILETIME=[B90BD360:01C6206A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>Anyway, below is the kernel log from 2.6.16-rc1-mm2 (contains 
>the latest acpi tree, which I thought might help out.)

I don't recall any boot-time ACPI interrupt configuration
changes recently, so I wouldn't be surprised if you get
the same behaviour back several kernel versions.

if it comes up in IOAPIC mode when "acpi=off", then
that would be a clue -- but it seems that recent
systems don't include MPS, and thus when ACPI is off,
so it IOAPIC.

That said, it should also boot with ACPI in "noapic" mode,
and if it doesn't, then that could indicate an ACPI-specific issue
that may carry over into ACPI+ioapic mode.

-Len
