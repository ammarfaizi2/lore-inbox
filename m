Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVIVUiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVIVUiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVIVUiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:38:16 -0400
Received: from fmr14.intel.com ([192.55.52.68]:22965 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751153AbVIVUiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:38:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Date: Thu, 22 Sep 2005 13:37:46 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0475A8B6@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Thread-Index: AcW3qaWCeTX+wvI0QOmoo7o87wADyAICwCKg
From: "Luck, Tony" <tony.luck@intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       <linux-ia64@vger.kernel.org>
Cc: <ak@suse.de>, "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 22 Sep 2005 20:37:47.0300 (UTC) FILETIME=[7DF32640:01C5BFB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Conduct some maintenance of the swiotlb code:
>
>	-- Move the code from arch/ia64/lib to lib

I agree that this code needs to move up out of arch/ia64, it is messy
that x86_64 needs to reach over and grab this from arch/ia64.

But is "lib" really the right place for it to move to?  Perhaps
a more logical place might be "drivers/pci/swiotlb/" since this
code is tightly coupled to pci?

-Tony
