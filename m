Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWHCFTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWHCFTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 01:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWHCFTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 01:19:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27032 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932265AbWHCFTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 01:19:51 -0400
Date: Wed, 2 Aug 2006 22:19:38 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <200608030649.11452.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608022213530.26980@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <200608030445.38189.ak@suse.de>
 <Pine.LNX.4.64.0608022125320.26980@schroedinger.engr.sgi.com>
 <200608030649.11452.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Andi Kleen wrote:

> > Those operations are only needed for special xen driver and not for 
> > regular kernel code!
> 
> The Xen driver will be "regular" kernel code.

As far as I can tell from this conversation there are special "Xen" 
drivers that need this not the rest of the system.

> > for those special xen drivers.
> 
> Well there might be reasons someone else uses this in the future too.
> It's also not exactly Linux style - normally we try to add generic
> facilities.

What possible use could there be to someone else?

The "atomic" ops lock/unlock crap exists only for i386 as far as I can 
tell. As you said most architectures either always use atomic ops or 
never. The lock/unlock atomic ops are i386 specific material that 
better stay contained. Its arch specific and not generic.

