Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWIGPaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWIGPaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIGP37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:29:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4526 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932145AbWIGP36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:29:58 -0400
Date: Thu, 7 Sep 2006 08:29:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
In-Reply-To: <20060907105801.GC3077@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0609070828460.16285@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060907105801.GC3077@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Nick Piggin wrote:

> So what I worry about with this approach is that it can really blow
> out the latency of a balancing operation. Say you have N-1 CPUs with
> lots of stuff locked on their runqueues.
> 
> The solution I envisage is to do a "rotor" approach. For example
> the last attempted CPU could be stored in the starving CPU's sd...
> and it will subsequently try another one.
> 
> I've been hot and cold on such an implementation for a while: on one
> hand it is a real problem we have; OTOH I was hoping that the domain
> balancing might be better generalised. But I increasingly don't
> think we should let perfect stand in the way of good... ;)
> 
> Would you be interested in testing a patch?

Sure but I think we should move fast on this one. This has now been known 
for around a year or so.
 
