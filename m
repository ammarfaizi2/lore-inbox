Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVBOSKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVBOSKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVBOSKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:10:23 -0500
Received: from fmr13.intel.com ([192.55.52.67]:5556 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261635AbVBOSKS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:10:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Consolidate compat_sys_waitid
Date: Tue, 15 Feb 2005 10:09:20 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02EA10A0@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Consolidate compat_sys_waitid
Thread-Index: AcUTCsGG/ycXMW5mRG+0LEIuiqoh9gAfnFyQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
       "LKML" <linux-kernel@vger.kernel.org>
Cc: <paulus@samba.org>, <anton@samba.org>, <davem@davemloft.net>,
       <ralf@linux-mips.org>, <ak@suse.de>, <willy@debian.org>,
       <schwidefsky@de.ibm.com>
X-OriginalArrivalTime: 15 Feb 2005 18:09:22.0109 (UTC) FILETIME=[799396D0:01C51389]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch does:
>	- consolidate the three implementations of compat_sys_waitid
>	  (some were called sys32_waitid).
>	- adds sys_waitid syscall to ppc
>	- adds sys_waitid and compat_sys_waitid syscalls to ppc64
>
>Parisc seemed to assume th existance of compat_sys_waitid.  The MIPS
>syscall tables have me confused and may need updating.  I have arbitrarily
>chosen the next available syscall number on ppc and ppc64, I hope this is
>correct.
>
>Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
>Comments?

Compiles cleanly, and my test case runs on ia64.

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
