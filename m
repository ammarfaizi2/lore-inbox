Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbULWA04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbULWA04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 19:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbULWA0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 19:26:55 -0500
Received: from fmr20.intel.com ([134.134.136.19]:14229 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262093AbULWA0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 19:26:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Date: Thu, 23 Dec 2004 08:26:12 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013CA3A@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Thread-Index: AcToMfU3JEe+cL92T46hLpY/jqRZKAAUw7OQ
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Rik van Riel" <riel@redhat.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>,
       <lista4@comhem.se>, <linux-kernel@vger.kernel.org>, <mr@ramendik.ru>,
       <kernel@kolivas.org>
X-OriginalArrivalTime: 23 Dec 2004 00:26:13.0072 (UTC) FILETIME=[020A7D00:01C4E886]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel wrote:
> > Seems that vmscan-ignore-swap-token-when-in-trouble.patch +
> > vm-pageout-throttling.patch dose not fix the problem,
> > I ran stress test for 2.6.9 + these 2 patches.
> > OOM killer was still triggered.
> 
> You need the oneline patch that Andrew Morton posted two
> days ago:
> 
> Message-Id: <20041219230754.64c0e52e.akpm@osdl.org>

You mean that totally disable swap_token?
I have just tried it yesterday on a RHEL4-PRERC kernel, which is based
on 2.6.9.
I still see the OOM killer in a couple of hours..., 


> 
> --
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
