Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWFBVIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWFBVIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWFBVIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:08:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39865 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030267AbWFBVIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:08:37 -0400
Date: Fri, 2 Jun 2006 14:08:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       David Gibson <david@gibson.dropbear.id.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions on
 vma close
In-Reply-To: <1149281841.9693.39.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606021407580.6179@schroedinger.engr.sgi.com>
References: <1149257287.9693.6.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606021301300.5492@schroedinger.engr.sgi.com>
 <1149281841.9693.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006, Adam Litke wrote:

> The real reason I want to "close" hugetlb regions (even on 64bit
> platforms) is so a process can replace a previous hugetlb mapping with
> normal pages when huge pages become scarce.  An example would be the
> hugetlb morecore (malloc) feature in libhugetlbfs :)

Well that approach wont work on IA64 it seems.
