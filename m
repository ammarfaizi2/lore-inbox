Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271808AbTHNXq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 19:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHNXq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 19:46:57 -0400
Received: from fmr06.intel.com ([134.134.136.7]:24036 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271808AbTHNXq4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 19:46:56 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Thu, 14 Aug 2003 16:46:45 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502401541708@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNg/yor4H3QUsxSRSCKPTyu1XnoOgBvrPMw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Greg KH" <greg@kroah.com>, "long" <tlnguyen@snoqualmie.dp.intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Aug 2003 23:46:45.0968 (UTC) FILETIME=[523F1500:01C362BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Nguyen, Tom L wrote:
> > IMO Multiplexing would be preferred, we can't be allocating that many 
> > vectors for one device/device driver
> All pre-assigned vectors to all enabled IOxAPIC(s) are reserved.
> Allocating additional vectors to MSI-X driver is determined based on the
> available vectors, which must be greater than the number of vectors requested
> by MSI-X driver.

>Hmm can you avoid grabbing all the free vectors? I think the irq 
>controller subsystem should handle allocation of vectors. Letting MSI grab 
>everything might leave us with problems later on.
Good point. Thanks! we are studying the policy, which ensures that no MSI-X
can grab everything from others. Will post this changes after done ...

Thanks,
Long


