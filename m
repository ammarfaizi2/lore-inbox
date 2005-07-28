Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVG1OnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVG1OnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVG1OnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:43:16 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:54217 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261544AbVG1Okk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:40:40 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Thu, 28 Jul 2005 15:40:34 +0100
Message-ID: <A95E2296287EAD4EB592B5DEEFCE0E9D282811@liverpoolst.ad.cl.cam.ac.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [openib-general] Re: [PATCH] arch/xx/pci: remap_pfn_range -> io_remap_pfn_range
Thread-Index: AcWTf1Coo/U2Jf5JRDmFbLRO8hHaewAAjQVA
From: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <gregkh@suse.de>, <rolandd@cisco.com>, <mst@mellanox.co.il>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <openib-general@openib.org>,
       <linux-kernel@vger.kernel.org>, <mj@ucw.cz>, <ian.pratt@cl.cam.ac.uk>,
       <ian.pratt@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > For example, drivers/char/mem.c uses io_remap_pfn_range for 
> mmap'ing 
> > /dev/mem
> 
> That is my (limited) understanding also, but when I built 
> io_remap_pfn_range(), I didn't search all callers of
> remap_pfn_range() to see which ones that I could fix (or 
> break) by changing them.  Mostly due to the possible breakage part.

Yep, its not entirely trivial to determine the intended usage. In
particular, some of the sound drivers require both versions in the same
file. 

It's probably best to rely on Xen/Sparc users to find them on a case by
case basis and ask for them to be fixed (unless someone's feeling
brave...)

Ian 
