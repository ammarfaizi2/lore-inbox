Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWHRQ6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWHRQ6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWHRQ6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:58:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33949 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161052AbWHRQ6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:58:46 -0400
Date: Fri, 18 Aug 2006 09:58:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: manfred@colorfullife.com, ak@muc.de, mpm@selenic.com, marcelo@kvack.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, ak@suse.de,
       dgc@sgi.com
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <20060818161739.f7581645.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0608180956080.31844@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
 <44E3FC4F.2090506@colorfullife.com> <Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
 <20060818161739.f7581645.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006, KAMEZAWA Hiroyuki wrote:

> Just a note: with SPARSEMEM, we need more calculation and access to
> mem_section[] table and page structs(mem_map).

Uhh, a regression against DISCONTIG. Could you address that issue?

> > vmalloc_to_addr is certainly slower due to the page table walking. But the 
> > user already is aware of the fact that vmalloc memory is not as fast as
> > direct mapped.

> Considering some code walking through a list of objects scattered over all memory,
> Is virtually-mapped area really slow ?

On most arches it is somewhat slower. IA64 is special in the sense that it 
has virtually mapped kernel memory.
