Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbULHRoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbULHRoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbULHRoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:44:37 -0500
Received: from fmr99.intel.com ([192.55.52.32]:18633 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261268AbULHRod convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:44:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Anticipatory prefaulting in the page fault handler V1
Date: Wed, 8 Dec 2004 09:44:09 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02844270@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Anticipatory prefaulting in the page fault handler V1
Thread-Index: AcTdSt6rCb6OrY84QTC3CTDLnliUKAAAi/Eg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@sgi.com>, <nickpiggin@yahoo.com.au>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <torvalds@osdl.org>, <hugh@veritas.com>,
       <benh@kernel.crashing.org>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2004 17:44:13.0192 (UTC) FILETIME=[87B06080:01C4DD4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If a fault occurred for page x and is then followed by page 
>x+1 then it may be reasonable to expect another page fault
>at x+2 in the future.

What if the application had used "madvise(start, len, MADV_RANDOM)"
to tell the kernel that this isn't "reasonable"?

-Tony
