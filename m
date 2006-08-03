Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWHCA3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWHCA3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWHCA3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:29:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64421 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751130AbWHCA3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:29:39 -0400
Date: Wed, 2 Aug 2006 17:28:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jeremy Fitzhardinge <jeremy@xensource.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <20060803002518.061401577@xensource.com>
Message-ID: <Pine.LNX.4.64.0608021726540.25963@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <20060803002518.061401577@xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006, Jeremy Fitzhardinge wrote:

> Add "always lock'd" implementations of set_bit, clear_bit and
> change_bit and the corresponding test_and_ functions.  Also add
> "always lock'd" implementation of cmpxchg.  These give guaranteed
> strong synchronisation and are required for non-SMP kernels running on
> an SMP hypervisor.

I think I asked this before....

Would it not be simpler to always use the locked implementation on UP? At 
least when the kernel is compiled with hypervisor support? This is going 
to add yet another series of bit operations.

