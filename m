Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269528AbTGOS5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269522AbTGOS5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:57:05 -0400
Received: from fmr05.intel.com ([134.134.136.6]:49390 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269528AbTGOS43 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:56:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 12:11:17 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE91@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI patches updated (20030714)
Thread-Index: AcNLAexunnhgJxR5SledNBIMmf2LvwAAclIQ
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, <hugh@veritas.com>,
       "Brown, Len" <len.brown@intel.com>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
X-OriginalArrivalTime: 15 Jul 2003 19:11:18.0216 (UTC) FILETIME=[DE8BC480:01C34B04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> I would like to see HT_ONLY generalized to parsing the MADT for
> I/O-APICs. The problem I have is that some mainboards, like my
> i850 ASUS P4T-E, have I/O-APICs but no MP tables. The only way for
> the Linux kernel to discover the I/O-APICs on these mainboard is
> through MADT parsing.
> 
> However, this currently requires me to enable all of ACPI, which
> I don't need or want for many reasons, including code bloat and
> behavioural side-effects.
> 
> Replacing "HT_ONLY" with "MADT_PARSING_ONLY" would be ideal, IMO.

This won't help you. If you have *no* MPS tables, then you need ACPI
(and specifically the ability to execute the _PRT control methods) for
interrupt routing information, in addition to ioapic and local apic
(CPU) enumeration. If this wasn't the case, I'm sure someone would have
implemented ioapic MADT enumeration code long ago.

Also, nothing is going to fundamentally change the size of the ACPI code
(but we do keep chipping away at it, as evidenced by the dynamic SDT
patch, -Os, etc.) but I'd like to hear more about the behavioral
side-effects you'd mentioned, with an eye towards fixing them.

Regards -- Andy
