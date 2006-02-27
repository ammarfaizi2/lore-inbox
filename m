Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWB0UhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWB0UhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWB0UhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:37:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35478 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750840AbWB0UhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:37:13 -0500
Date: Mon, 27 Feb 2006 12:36:59 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andi Kleen <ak@suse.de>, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
In-Reply-To: <20060227121605.fb41d505.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0602271235200.8242@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
 <p731wxo1tpr.fsf@verdi.suse.de> <20060227121605.fb41d505.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006, Paul Jackson wrote:

> Andi wrote:
> > Is there a way to use it without cpumemsets? 
> 
> Not that I know of.  So far as I can recall, the task->mems_allowed
> field (over which the spreading is done) is only manipulated by the
> cpuset code.  So at least what I have here requires cpusets to have
> any useful affect, yes.

Well we could fall back to interleave on the node online map if some sort 
of flag is set.

On the other hand setting memory policy to MPOL_INTERLEAVE already 
provides that functionality.


