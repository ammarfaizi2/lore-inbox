Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWIVSnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIVSnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWIVSnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:43:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21957 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750752AbWIVSnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:43:42 -0400
Date: Fri, 22 Sep 2006 11:43:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: David Rientjes <rientjes@cs.washington.edu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [PATCH] do not free non slab allocated per_cpu_pageset
In-Reply-To: <20060922113924.014ce28f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609221141270.8356@schroedinger.engr.sgi.com>
References: <1158884252.5657.38.camel@keithlap> <20060921174134.4e0d30f2.akpm@osdl.org>
 <1158888843.5657.44.camel@keithlap> <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921200806.523ce0b2.akpm@osdl.org> <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921204629.49caa95f.akpm@osdl.org> <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
 <Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
 <20060922113924.014ce28f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Andrew Morton wrote:

> I think I preferred my earlier fix, recently reworked as:

The problem is though that the pcp pointers must point to the static pcp 
arrays for bootup to succeed under NUMA. Your patch may work under SMP. 
For NUMA you may zap pointers to valid static pcps.
