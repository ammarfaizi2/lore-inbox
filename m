Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWHCEZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWHCEZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWHCEZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:25:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31410 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932343AbWHCEZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:25:33 -0400
Date: Wed, 2 Aug 2006 21:25:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: virtualization@lists.osdl.org, Zachary Amsden <zach@vmware.com>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <200608030555.34569.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608022124111.26980@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <44D14ECC.3080600@vmware.com>
 <Pine.LNX.4.64.0608021821350.26404@schroedinger.engr.sgi.com>
 <200608030555.34569.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Andi Kleen wrote:

> On Thursday 03 August 2006 03:25, Christoph Lameter wrote:
> 
> > Good idea. This will also make it easier to support this special 
> > functionality. And it will avoid use in contexts where these are
> > not necessary.
> 
> I think it's a bad idea. We don't want lots of architecture ifdefs
> in some Xen specific file

Thats not how it would be done. We would do this with
architecture specific xen files and a default in asm-generic.

