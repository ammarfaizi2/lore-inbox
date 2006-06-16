Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWFPTqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWFPTqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWFPTqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:46:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4833 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751508AbWFPTqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:46:16 -0400
Date: Fri, 16 Jun 2006 12:46:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use zoned VM Counters for NUMA statistics V2
In-Reply-To: <200606162119.41293.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606161242130.16315@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606161118210.15940@schroedinger.engr.sgi.com>
 <200606162119.41293.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Andi Kleen wrote:

> I don't think such a beast exists so far. So from that
> angle it doesn't help.

Hmmm.. Seemed to me that the L1 cacheline size is 64 byte on i386 at least 
for some modern cpus but then I am not that familiar with i386.

config X86_L1_CACHE_SHIFT
        int
        default "7" if MPENTIUM4 || X86_GENERIC
        default "4" if X86_ELAN || M486 || M386 || MGEODEGX1
        default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
        default "6" if MK7 || MK8 || MPENTIUMM


