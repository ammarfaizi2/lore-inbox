Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267816AbUG3UNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267816AbUG3UNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267820AbUG3UNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:13:51 -0400
Received: from adsl-64-109-89-108.dsl.chcgil.ameritech.net ([64.109.89.108]:55441
	"EHLO redscar") by vger.kernel.org with ESMTP id S267816AbUG3UNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:13:42 -0400
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive
	kernels
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040730130238.0f68f5e7.akpm@osdl.org>
References: <20040730190227.29913e23.ak@suse.de> 
	<20040730130238.0f68f5e7.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jul 2004 16:13:39 -0400
Message-Id: <1091218419.1968.46.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 16:02, Andrew Morton wrote:
> We're paying for past sins here.  I think it would be better to create a
> new version of pci_alloc_consistent() which takes gfp_flags, then migrate
> the drivers you care about to use it.  That way the benefit is available on
> non-preempt kernels too.
> 
> The ultimate aim of course would be to deprecate then remove the old
> function.

True, that's why it was added for dma_alloc_coherent().

Is there any need for a new wrapper?  Why not just use
dma_alloc_coherent() from now on?

James


