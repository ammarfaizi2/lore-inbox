Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTJUQUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 12:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTJUQUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 12:20:22 -0400
Received: from fmr06.intel.com ([134.134.136.7]:10424 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263166AbTJUQUQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 12:20:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPIP-state driver
Date: Tue, 21 Oct 2003 08:47:51 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304B031@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPIP-state driver
Thread-Index: AcOXrsdgCNm9x/U2TJiTdnaZUD2a7AAMpEYw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <arjanv@redhat.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 15:47:52.0964 (UTC) FILETIME=[B0219C40:01C397EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> it's all nice code and such, but I still wonder why this can't be done
> by a userland policy daemon. The 2.6 kernel has the infrastructure to
> give very detailed information to userspace (eg top etc) about idle
> percentages...... I didn't see anything in this driver that couldn't
be
> done from userspace.
> 

It's about the frequency of the feedback loop. As we have much lower
latency with P-state transitions, the sampling time can be order of
millisecond (or shorter if meaningful). A userland daemon can have a
high-level policy (preferences, or set of parameters), but it cannot be
part of the real feedback loop. If we combine P-state transitions and
deeper C-state transitions, the situation is worse with a userland
daemon.

	Jun








