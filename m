Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752659AbWAHSJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbWAHSJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbWAHSJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:09:14 -0500
Received: from fmr14.intel.com ([192.55.52.68]:55486 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1752659AbWAHSJO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:09:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.15-mm2
Date: Sun, 8 Jan 2006 13:08:53 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A134F9@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.15-mm2
Thread-Index: AcYUN79K5s0ULn1oQWuuDviTmMxF1gARjb0g
From: "Brown, Len" <len.brown@intel.com>
To: "Reuben Farrelly" <reuben-lkml@reub.net>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "Stephen Hemminger" <shemminger@osdl.org>
X-OriginalArrivalTime: 08 Jan 2006 18:08:56.0214 (UTC) FILETIME=[97389360:01C6147E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Any difference if you boot with "acpi=off" or "pci=noacpi"?
>> If that fixes it, then ACPI is shomehow involved in the problem.
>> If it doesn't fix it, then ACPI is not involved.

>Big difference, but probably not the sort of difference you 
>were hoping for ;)

>PCI: No IRQ known for interrupt pin C of device 0000:00:1c.2. 
>Probably buggy MP table.

Yeah, that that's no help.  Sorry, debugging the legacy MPS
code is where I draw the line:-)  I guess if you want to compare
with and without ACPI you have to go all the way down to
UP/PIC mode,  (maxcpus=1 noapic, with and with out acpi=off)
but unless that fails with acpi and works without, we may
not be able to tell much about the failure from it.

thanks
-Len
