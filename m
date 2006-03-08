Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWCHHpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWCHHpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWCHHpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:45:00 -0500
Received: from fmr20.intel.com ([134.134.136.19]:55963 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751120AbWCHHo7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:44:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Wed, 8 Mar 2006 15:44:56 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B22AB1A@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
thread-index: AcZCf6qO3fOTJFunSwCKZ2qecIxapgAAcNMQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2006 07:44:57.0321 (UTC) FILETIME=[32461D90:01C64284]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I hope what I've explained above makes sense. To reiterate, if you
>want me to do something with respect to hotkey, I still don't
>understand how and where hotkey is involved. Perhaps you could help me
>by elaborating further.

I know this user-defined region needs address space handler, but your
address space handler below  is so weird that make me doubt
the correctness.  The example of address space handler is:
ec.c : acpi_ec_space_handler

I suggest LCD support in hotkey.c like:
http://bugzilla.kernel.org/attachment.cgi?id=6843&action=view

Implement device ASIM  in a separate driver to support user-defined
address space handler.

Config userspace acpi daemon to respond events by evoking
LCD._BCM with command:
	echo -n xx > /sys/hotkey/brightness.

If you do these, then the only specific thing would be ASIM.

Thanks,
Luming 
