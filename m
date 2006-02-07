Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWBGSCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWBGSCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWBGSCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:02:16 -0500
Received: from mail.suse.de ([195.135.220.2]:23995 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964771AbWBGSCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:02:16 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Tue, 7 Feb 2006 18:51:38 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, steiner@sgi.com, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602071828.49370.ak@suse.de> <Pine.LNX.4.62.0602070941040.24841@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602070941040.24841@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071851.39330.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 18:42, Christoph Lameter wrote:

> > > and therefore there are only small latencies  
> > > involved. NUMA only gives small benefits.
> > 
> > That's also not true. Everytime I get memory placement for 
> > process memory wrong users complain _very_ loudly and there 
> > are clear benefits in benchmarks too.
> 
> What are the latencies in an 8 way opteron system? I.e. Local memory, next 
> processor, most distant processor?

The NUMA factor is surprisingly good because of the way the cache coherency
works even the local memory access gets slower with more
nodes @) iirc it's <3. Worst case latency tends to be <200ns.

-Andi
