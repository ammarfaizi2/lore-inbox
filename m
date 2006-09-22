Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWIVTGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWIVTGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWIVTGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:06:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:41601 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S932131AbWIVTGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:06:19 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,204,1157353200"; 
   d="scan'208"; a="135255329:sNHT17433227"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: ZONE_DMA
Date: Fri, 22 Sep 2006 12:06:57 -0700
User-Agent: KMail/1.9.4
Cc: Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rohit Seth <rohitseth@google.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <200609221139.03250.jesse.barnes@intel.com> <Pine.LNX.4.64.0609221139570.8356@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221139570.8356@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221206.57701.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 22, 2006 11:40 am, Christoph Lameter wrote:
> On Fri, 22 Sep 2006, Jesse Barnes wrote:
> > Right, the internals are arch specific and don't necessarily have to
> > rely on a zone, depending on their DMA constraints.
>
> From what I can see the arch specific do some tricks and then pick
> GFP_DMA or something to get memory that is appropriately limited. Having
> the ability to retrieve pages from a certain range from the page
> allocator would fix this issue and improve the ability of devices to
> allocate memory.

Right, being able to allocate from specific ranges would obviate the need 
for GFP_DMA and the various zones.  It would come with a cost though since 
the VM would have to become aware of pressure at various ranges rather 
than just on zones like we have now.  I think that's where things get 
tricky.

Jesse
