Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVGZFCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVGZFCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVGZFCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:02:03 -0400
Received: from fmr13.intel.com ([192.55.52.67]:24992 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261702AbVGZFCC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:02:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI oddity
Date: Tue, 26 Jul 2005 01:01:45 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300424AE17@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI oddity
Thread-Index: AcWRXdQWKL2AmaJpSwamF0n96sUawwAQK91w
From: "Brown, Len" <len.brown@intel.com>
To: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 26 Jul 2005 05:01:48.0006 (UTC) FILETIME=[20717060:01C5919F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On a HT system, why does ACPI recognize CPU0 and CPU1, refer 
>to them as such in dmesg

This is the Linux CPU number. ie the namespace where 0
is the boot processor and the others are numbered in
the order that they were started.

> and then call them CPU1 and CPU2 in 
>/proc/acpi/processor?

These are arbitrary device identifiers written
by the BIOS developer and foolishly advertised
to the user by Linux.  The BIOS writer could have
also called them ABC9 and XYZ4 and it would be
equally valid.

We're planning to get rid of all the ACPI stuff
in /proc and move to sysfs.  At that time we'll
use device identifies that are deterministic,
like cpu%d that /sys/devices/system uses today.

cheers,
-Len
