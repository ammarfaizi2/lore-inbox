Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWCaDIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWCaDIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWCaDIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:08:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15314 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750807AbWCaDIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:08:52 -0500
Date: Thu, 30 Mar 2006 19:08:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Zoltan Menyhart'" <Zoltan.Menyhart@bull.net>,
       "'Boehm, Hans'" <hans.boehm@hp.com>,
       "'Grundler, Grant G'" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310301.k2V31Gg28423@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301907070.3145@schroedinger.engr.sgi.com>
References: <200603310301.k2V31Gg28423@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> > > See, no memory ordering there, because clear_bit already has a LOCK prefix.
> No, not the memory ordering semantics you are thinking about.  It just tell
> compiler not to be over smart and schedule a load operation above that point
> Intel compiler is good at schedule memory load way ahead of its use to hide
> memory latency. gcc probably does that too, I'm not 100% sure. This prevents
> the compiler to schedule load before that line.

The compiler? I thought we were talking about the processor.

I was referring to the LOCK prefix. Doesnt that insure the processor to 
go into a special state and make the bus go into a special state that 
implies a barrier?

