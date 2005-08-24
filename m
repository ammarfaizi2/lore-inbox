Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVHXPOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVHXPOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVHXPOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:14:24 -0400
Received: from fmr13.intel.com ([192.55.52.67]:57520 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751050AbVHXPOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:14:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
Date: Wed, 24 Aug 2005 11:13:05 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30046956FE@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
Thread-Index: AcWouk8YNmm235qvTj6+IPGSPMbfigAA3K0w
From: "Brown, Len" <len.brown@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Li, Shaohua" <shaohua.li@intel.com>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Aug 2005 15:13:13.0551 (UTC) FILETIME=[58B61DF0:01C5A8BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
>
>I got the following compile error in 2.6.13-rc6-mm2, but it 
>seems to be 
>a problem coming from Linus' tree introduced by the
>  [ACPI] S3 resume: avoid kmalloc() might_sleep oops symptom
>patch:
>
><--  snip  -->
>
>...
>  LD      .tmp_vmlinux1
>drivers/built-in.o: In function `acpi_os_allocate':
>: undefined reference to `acpi_in_resume'
>make: *** [.tmp_vmlinux1] Error 1
>
><--  snip  -->

Do you have an ACPI-enabled machine that has no PCI?
I'm not aware of any, and would be interested to know
if one exists.

We've had problems with this theoretical build config
for some time:
http://bugzilla.kernel.org/show_bug.cgi?id=1364
because nobody, including me, tests it.

Indeed, one possible fix would be to make CONFIG_ACPI
depend on CONFIG_PCI -- which brings me back to
my origianl question.

-Len
