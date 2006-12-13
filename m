Return-Path: <linux-kernel-owner+w=401wt.eu-S1751630AbWLMWYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWLMWYn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWLMWYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:24:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:8992 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbWLMWYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:24:42 -0500
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 17:24:42 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="174140335:sNHT29576610"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: sg_dma_address and sg_dma_len
Date: Wed, 13 Dec 2006 14:14:56 -0800
Message-ID: <617E1C2C70743745A92448908E030B2AEA3F7C@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sg_dma_address and sg_dma_len
Thread-Index: Acce+QcWVEnoTjEmQLuAjMihmqwNLwACqd+Q
From: "Luck, Tony" <tony.luck@intel.com>
To: "Ralph Campbell" <ralph.campbell@qlogic.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Dec 2006 22:14:57.0640 (UTC) FILETIME=[1FC0AE80:01C71F04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since pci.h includes <asm/scatterlist.h> it seems like the fix would be
> to move the two lines:
>	#define sg_dma_len(sg)          ((sg)->dma_length)
>	#define sg_dma_address(sg)      ((sg)->dma_address)
> to include/asm-ia64/scatterlist.h

Sounds like a good plan ... a test build with this change fixed all the
infiniband build issues, and didn't introduce any new ones.  I've applied
this to my ia64 tree and asked Linus to pull it.

Thanks.

-Tony
