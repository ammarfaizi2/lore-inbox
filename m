Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbTFYRGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264679AbTFYRGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:06:09 -0400
Received: from fmr05.intel.com ([134.134.136.6]:42970 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264666AbTFYRGG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:06:06 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI 100002 IRQ 9 problem.
Date: Wed, 25 Jun 2003 10:20:15 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE65@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI 100002 IRQ 9 problem.
Thread-Index: AcM65a8cgy5b4kslQ+ahhV//v1eZDgAV7Rxw
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Joshua Schmidlkofer" <menion@asylumwear.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 25 Jun 2003 17:20:15.0837 (UTC) FILETIME=[0B3268D0:01C33B3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Joshua Schmidlkofer [mailto:menion@asylumwear.com] 
>    First is there a different list for ACPI questions?

>From MAINTAINERS:

ACPI
P:	Andy Grover
M:	andrew.grover@intel.com
L:	acpi-devel@lists.sourceforge.net
W:	http://sf.net/projects/acpi/
S:	Maintained

>    For the sake of disclosure, the dump I am reporting is 2.5.73, plus
> the Davide Libenzis' SiS-96x patch.  I also am currently using the
> nvidia driver, I was able to reproduce this in vanilla 2.5.72 (no
> nvidia), and I will try tomorrow with a vanilla setup of 2.5.73-bk3.
> [unless bk4 is available].
> 
>    I have a Soyo P4S-645D, with the SiS 645 chipset.  I have had some
> problems w/ the IRQ routing, but 2.5.7[123] have sorted it 
> out (mostly) 
> I am having problems ACPI, it is better if I say 
> 'pci=noacpi', but what
> happens is when the ACPI interrupt count hit 100002, then I get the
> following message on all consoles:
> 
> menion kernel: Disabling IRQ #9
> 
> Then, I have the following as part of dmesg:
> 
> Call Trace: [<c010cad4>]  [<c010cbad>]  [<c010ce46>]  [<c010880e>] 
> [<c010880e>]  [<c010b320>]  [<c010880e>]  [<c010880e>]  [<c0108832>] 
> [<c010889a>]  [<c0105000>]  [<c041c6bd>]  [<c041c41e>]
> [<c0247446>]
> Warning (Oops_read): Code line not seen, dumping what data is 
> available

There is a known, as-yet-unfixed problem, but the usual symptom is you
hit 100000 interrupts and then it gets nicely disabled - I'm not sure
why your system oopses.

Regards -- Andy
