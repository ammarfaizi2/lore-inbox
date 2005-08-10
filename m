Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVHJQ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVHJQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 12:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVHJQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 12:59:18 -0400
Received: from fmr15.intel.com ([192.55.52.69]:37322 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S965210AbVHJQ7R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 12:59:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] consolidate sys_ptrace
Date: Wed, 10 Aug 2005 09:59:01 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F041A27D7@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] consolidate sys_ptrace
Thread-Index: AcWdgbDv+zBMWadbQBSwYzb1oSc/2QASHUtA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Hellwig" <hch@lst.de>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2005 16:59:00.0062 (UTC) FILETIME=[CDBE57E0:01C59DCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Some architectures have a too different ptrace so we have to exclude
>them: alpha, ia64, m32r, parisc, sparc, sparc64.  They continue to
>keep their implementations.

So it should be no surprise that this patch works ok for ia64, but here
is the ACK anyway.

>+#ifndef __ARCH_SYS_PTRACE

Most of the existing "#define ARCH_foo" uses don't have a prepended
"__" (current score is 20 to 3).  So there is a small question of
going with the prevailing style, or doing the right thing.  Just in
case anyone else raises this, my vote is with "__".

-Tony
