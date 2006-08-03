Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWHCRQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWHCRQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWHCRQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:16:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:56963 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932584AbWHCRQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:16:46 -0400
Date: Thu, 3 Aug 2006 10:18:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, akpm@osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Message-ID: <20060803171806.GB2654@sequoia.sous-sol.org>
References: <20060803002510.634721860@xensource.com> <200608030739.13334.ak@suse.de> <Pine.LNX.4.64.0608022252270.27488@schroedinger.engr.sgi.com> <200608030802.44391.ak@suse.de> <Pine.LNX.4.64.0608030943110.29745@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608030943110.29745@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Lameter (clameter@sgi.com) wrote:
> An include <asm/xen-bitops.h> would need to fall back to asm-generic if
> there is no file in asm-arch/xen-bitops.h. I thought we had such a 
> mechanism?

While Xen is the primary user, it is a misnomer to call it xen-bitops.
These are simply always locked, hence the sync-bitops name.  Also,
there's a use of sync_cmpxchg, and cmpxchg is not in bitops.h.

As for the mechanism, it is manual.  Arch specific header includes
asm-generic one.
