Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVI1RI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVI1RI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVI1RI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:08:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55772 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750862AbVI1RI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:08:26 -0400
Date: Wed, 28 Sep 2005 10:08:14 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alokk@calsoftinc.com
Subject: Re: 2.6.14-rc2 early boot OOPS (mm/slab.c:1767)
In-Reply-To: <20050928063017.GI1046@vega.lnet.lut.fi>
Message-ID: <Pine.LNX.4.62.0509281006270.14264@schroedinger.engr.sgi.com>
References: <20050927202858.GG1046@vega.lnet.lut.fi>
 <Pine.LNX.4.62.0509271630050.11040@schroedinger.engr.sgi.com>
 <20050928063017.GI1046@vega.lnet.lut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Tomi Lapinlampi wrote:

> > Hmmm. I am not familiar with Alpha. The .config looks as if this is a 
> > uniprocessor configuration? No NUMA? 
> 
> This is a simple uniprocessor configuration, no NUMA, no SMP. 
> 
> > What is the value of MAX_NUMNODES?
> 
> I'm not familiar with NUMA, where can I check this (or does this question
> even apply since it's not a NUMA system) ?

Well, one use of memory nodes is to describe discontiguous memory on some 
architectures. Thus the number of nodes may be more than one even if 
CONFIG_NUMA is off. This is the case f.e. on ppc64. There may be some arch 
specific settings that cause problems here. 


