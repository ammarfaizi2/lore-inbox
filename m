Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWCaCz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWCaCz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWCaCz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:55:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25305 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750807AbWCaCz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:55:58 -0500
Date: Thu, 30 Mar 2006 18:55:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Zoltan Menyhart'" <Zoltan.Menyhart@bull.net>,
       "'Boehm, Hans'" <hans.boehm@hp.com>,
       "'Grundler, Grant G'" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310250.k2V2ofg28252@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301855280.3045@schroedinger.engr.sgi.com>
References: <200603310250.k2V2ofg28252@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> By the way, this is the same thing on x86: look at include/asm-i386/bitops.h:
> 
> #define smp_mb__before_clear_bit()      barrier()
> #define smp_mb__after_clear_bit()       barrier()
> 
> A simple compiler barrier, nothing but
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> See, no memory ordering there, because clear_bit already has a LOCK prefix.

And that implies barrier behavior right?

