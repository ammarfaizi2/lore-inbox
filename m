Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUEFU4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUEFU4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUEFU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:56:18 -0400
Received: from fmr01.intel.com ([192.55.52.18]:34284 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262931AbUEFU4P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:56:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 13:54:36 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEB1F@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.6 PATCH] Exposing EFI memory map
Thread-Index: AcQzqQ+J7lfdbGR8RJ2m6UoNEbjm3AAASPSg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Cc: "Sourav Sen" <souravs@india.hp.com>,
       "HELGAAS,BJORN (HP-Ft. Collins)" <bjorn_helgaas@am.exch.hp.com>,
       "Matt Domsch" <Matt_Domsch@dell.com>, <linux-ia64@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "lhms" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 06 May 2004 20:54:37.0224 (UTC) FILETIME=[57B75280:01C433AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Interesting. What does ppc64 do with the memmap after that?  
> 
> This doesn't even concern mem_map yet.  The userspace ppc64 hotplug
> tools actually write into the "OpenFirmware" tree from 
> userspace, after
> a hotplug happens.  This is partly because all of the ppc64 hotplug
> operations happen in userspace as it stands now.  

Umm..  my mistake, I meant the memory map passed up by the firmware,
not THE mem_map.  ;-)

> Actually, I was thinking that we'd just allocate the 
> kobjects, and note
> the presence of the memory in the nonlinear phys_section table.  Then,
> when we online it, we can decide where it's mapped, what zone 
> to put it
> in, and where to get the mem_map space from.  I think that approach
> gives the best flexibility. 

Yes, indeed. 

matt
