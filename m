Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbULVIql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbULVIql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbULVIql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:46:41 -0500
Received: from fmr17.intel.com ([134.134.136.16]:52907 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261907AbULVIqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:46:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Wed, 22 Dec 2004 16:45:49 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013CA39@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Thread-Index: AcTmpdicxpBLC3IRTBCKS0ihIXBLDwBXEsBA
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Rik van Riel" <riel@redhat.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>,
       <lista4@comhem.se>, <linux-kernel@vger.kernel.org>, <mr@ramendik.ru>,
       <kernel@kolivas.org>
X-OriginalArrivalTime: 22 Dec 2004 08:45:50.0368 (UTC) FILETIME=[A37D1A00:01C4E802]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rik van Riel [mailto:riel@redhat.com]
> Sent: Monday, December 20, 2004 11:08 PM
> To: Zou, Nanhai
> Cc: Nick Piggin; Andrew Morton; lista4@comhem.se;
> linux-kernel@vger.kernel.org; mr@ramendik.ru; kernel@kolivas.org

Rik van Riel wrote:

> That's Marcelo's vm-pageout-throttling.patch, which is one
> of the essential ingredients in avoiding false OOM kills.
> 
> I'm waiting on some test results for another two patches
> that I suspect are also needed ...
> 
> --
Seems that vmscan-ignore-swap-token-when-in-trouble.patch +
vm-pageout-throttling.patch dose not fix the problem, 
I ran stress test for 2.6.9 + these 2 patches.
OOM killer was still triggered.

Zou Nan hai
