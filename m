Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVCYWga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVCYWga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVCYW2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:28:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:58805 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261855AbVCYW1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:27:23 -0500
Subject: Re: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6ab08e99eb9f0823f7f7fb12e728e90d@kernel.crashing.org>
References: <1111645464.5569.15.camel@gaston>
	 <6ab08e99eb9f0823f7f7fb12e728e90d@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 09:26:52 +1100
Message-Id: <1111789613.5569.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 19:20 +0100, Segher Boessenkool wrote:
> > While experimenting with framebuffer access performances, we noticed a
> > very significant improvement in write access to it when not setting
> > the "guarded" bit on the MMU mappings. This bit basically says that
> > reads and writes won't have side effects (it allows speculation).
> 
> Unless the data is already in cache.
> 
> > It appears that it also disables write combining.
> 
> When the page is also cache-inhibited, it indeed does.
> 
> 
> Btw, did you ever get to fix the problem with mapping the last page
> of physical address space via /dev/mem ?

I don't think so, but I'll have to double check.

Ben.


