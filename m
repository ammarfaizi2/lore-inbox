Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWHCBH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWHCBH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWHCBH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:07:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21471 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932084AbWHCBH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:07:26 -0400
Date: Wed, 2 Aug 2006 18:06:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <44D144EC.3000205@goop.org>
Message-ID: <Pine.LNX.4.64.0608021805150.26314@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <20060803002518.061401577@xensource.com>
 <Pine.LNX.4.64.0608021726540.25963@schroedinger.engr.sgi.com>
 <44D144EC.3000205@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006, Jeremy Fitzhardinge wrote:

> > Would it not be simpler to always use the locked implementation on UP? At
> > least when the kernel is compiled with hypervisor support? This is going to
> > add yet another series of bit operations
> 
> You mean make the standard bit-ops atomic on UP when compiling for
> CONFIG_PARAVIRT?  We think its too much of a burden; there are only a few
> operations which must be locked in the hypervisor case, and bit ops are used
> everywhere.  I'd like to get it to the point where there's no significant
> overhead in configuring for PARAVIRT, even if you run on native hardware.

Thats a good goal but what about the rest of us who have to maintain 
additional forms of bit operations for all architectures. How much is this 
burden? Are locked atomic bitops really that more expensive?
