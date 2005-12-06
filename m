Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVLFCZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVLFCZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVLFCZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:25:23 -0500
Received: from fmr13.intel.com ([192.55.52.67]:2513 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S964932AbVLFCYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:24:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: APIC,  x86: How to change the IRQ of one board when BIOS can't ?
Date: Mon, 5 Dec 2005 21:24:51 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005515C89@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC,  x86: How to change the IRQ of one board when BIOS can't ?
Thread-Index: AcX6Cw5KMulrFDegSsejw30nfoesKAAAKQOg
From: "Brown, Len" <len.brown@intel.com>
To: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Dec 2005 02:24:53.0280 (UTC) FILETIME=[3DC50200:01C5FA0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>If the BIOS can't do it, it may not be possible at all, i.e. the 
>interrupt lines may be hard wired that way on the motherboard.

Note that physical interrupt wires are associated with physical
slots.  So if the devices in question are pluggable and you
have multiple slots, then moving devices between slots may
give devices different interrupt lines.  (or they can be all
wired together and this will make no difference)

But it is unusual for PCI IRQs to have lots of sharing in IOAPIC mode.
I didn't see the message preceeding this one -- did you post your
/proc/interrupts and output from dmesg -s64000?

thanks,
-Len
