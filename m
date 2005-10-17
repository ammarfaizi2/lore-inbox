Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVJQWhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVJQWhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVJQWhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:37:34 -0400
Received: from fmr13.intel.com ([192.55.52.67]:43687 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932353AbVJQWhd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:37:33 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: 2.6.14-rc4-mm1, acpi, irq problems, hdc (cdrom) dead
Date: Mon, 17 Oct 2005 18:38:33 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004E6C758@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.14-rc4-mm1, acpi, irq problems, hdc (cdrom) dead
Thread-Index: AcXTXw8NYtSreymuQhOfV9GAhFzcKAACfEJQ
From: "Brown, Len" <len.brown@intel.com>
To: "Norbert Preining" <preining@logic.at>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 17 Oct 2005 22:36:43.0497 (UTC) FILETIME=[3FC82590:01C5D36B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Since some kernel revisions (hard to tell since when, I don't use cdrom
>very often), the cdrom hdc is not working any more:
>
>vmunix: hdc: lost interrupt

> 2.6.14-rc4-mm1

Can you try vanilla 2.6.14?

If 2.6.14 works, then does 2.6.14-rc4-mm1 with git-acpi.patch backed out work better?:
http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/broken-out/git-acpi.patch

If 2.6.14 fails, does 2.6.13 work better?


> Kernel command line: BOOT_IMAGE=2.6.14-rc4-mm1 ro root=303 lapic
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

forcing the LAPIC to be enabled when the BIOS didn't enable it
is risky -- you're asserting that you know more
about the hardware than the BIOS writer knew.

Do you still have the issue without the "lapic" boot option?

>     ACPI-0284: *** Info: Table [DSDT] replaced by host OS

You're somewhat on your own here since you've replaced the OEM's firmware.
Do you still have the issue without replacing the BIOS?

cheers,
-Len


