Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbUB2XpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUB2XpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:45:22 -0500
Received: from fmr11.intel.com ([192.55.52.31]:36077 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262188AbUB2XpR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:45:17 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.3-mm1 and aic7xxx
Date: Sun, 29 Feb 2004 18:45:00 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0028B41D7@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.3-mm1 and aic7xxx
Thread-Index: AcP/HBMV32Z9MXoFSLeLKMpFYChztQAANX2w
From: "Brown, Len" <len.brown@intel.com>
To: "Fabio Coatti" <cova@ferrara.linux.it>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Feb 2004 23:45:01.0767 (UTC) FILETIME=[0C578570:01C3FF1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio,
I think this failure is from something else in -mm besides ACPI.
Otherwise, 2.6.4-rc1 wouldn't be working for you -- because 2.6.4
includes the ACPI patch you were running when you first hit this.

>I've also tried 2.6.4-rc1 and 2.6.4-rc1-mm1: 2.6.4-rc1 boots 
>and works, -mm1 hang at the very same point.

To verify with the latest software, please apply the latest ACPI patch
to 2.6.4-rc1:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
2.6.4/acpi-20040220-2.6.4.diff.gz

If it works, then something else in -mm is causing your problem.  If it
fails, then something in the latest ACPI patch (which is included in
-mm1) is causing the failure.

Thanks,
-Len
