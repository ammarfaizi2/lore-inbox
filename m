Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWHCGGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWHCGGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHCGGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:06:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11482 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932354AbWHCGGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:06:36 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Thu, 3 Aug 2006 08:02:44 +0200
User-Agent: KMail/1.9.3
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <200608030739.13334.ak@suse.de> <Pine.LNX.4.64.0608022252270.27488@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608022252270.27488@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030802.44391.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 07:54, Christoph Lameter wrote:
> On Thu, 3 Aug 2006, Andi Kleen wrote:
> 
> > > I still wonder why you are so focused on ifdefs. Why would we need those?
> > 
> > Because the Xen drivers will run on a couple of architectures, including
> > IA64 and PPC.
> > 
> > If IA64 or PPC didn't implement at least wrappers for the sync ops
> > then they would all need special ifdefs to handle this.
> 
> No they would just need to do an #include <xen-bitops.h>

If IA64 and PPC64 wouldn't have xen-bitops.h (which you seem to argue 
for) then they would need ifdefs.

> > But you would still need to add that to IA64, PPC etc. too, so it 
> > would only avoid adding a single to the other architectures.
> 
> Could we not just add one fallback definition to asm-generic?

You mean into asm-generic/bitops.h? Then it would need ifdefs
to handle the i386/x86-64 case.

-Andi
 
