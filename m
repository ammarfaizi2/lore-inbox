Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVLLQet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVLLQet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVLLQet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:34:49 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:54190 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751253AbVLLQes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:34:48 -0500
Date: Mon, 12 Dec 2005 08:34:39 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org
Subject: Re: [RFC 3/6] Make nr_pagecache a per zone counter
In-Reply-To: <20051212115731.GA3599@dmt.cnet>
Message-ID: <Pine.LNX.4.62.0512120833510.14274@schroedinger.engr.sgi.com>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
 <20051210005456.3887.94412.sendpatchset@schroedinger.engr.sgi.com>
 <20051211183241.GD4267@dmt.cnet> <20051211194840.GU11190@wotan.suse.de>
 <20051211204943.GA4375@dmt.cnet> <439CF3B1.4050803@yahoo.com.au>
 <20051212115731.GA3599@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005, Marcelo Tosatti wrote:

> But nr_pagecache is not accessed at interrupt code, is it? It does
> not need to be an atomic type.

nr_pagecache is only updated when interrupts are disabled. It could be 
simply switched to unsigned long for UP.


