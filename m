Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWCHOzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWCHOzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWCHOzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:55:15 -0500
Received: from cantor2.suse.de ([195.135.220.15]:34955 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751076AbWCHOzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:55:14 -0500
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document Linux's memory barriers
References: <5NONi-2hp-3@gated-at.bofh.it> <5NQ2U-462-29@gated-at.bofh.it>
	<5NRLg-6LJ-31@gated-at.bofh.it> <5NRUR-6Yo-11@gated-at.bofh.it>
	<5NUSF-30Z-5@gated-at.bofh.it> <440E2EE8.10708@shaw.ca>
From: Andi Kleen <ak@suse.de>
Date: 08 Mar 2006 15:55:08 +0100
In-Reply-To: <440E2EE8.10708@shaw.ca>
Message-ID: <p73fyltf0kz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock <hancockr@shaw.ca> writes:

> Alan Cox wrote:
> > On Maw, 2006-03-07 at 22:24 +0100, Andi Kleen wrote:
> >>> But on most arches those accesses do indeed seem to happen in-order.  On
> >>> i386 and x86_64, it's a natural consequence of program store ordering.
> >> Not true for reads on x86.
> > You must have a strange kernel Andi. Mine marks them as volatile
> > unsigned char * references.
> 
> Well, that and the fact that IO memory should be mapped as uncacheable
> in the MTRRs should ensure that readl and writel won't be reordered on
> i386 and x86_64.. except in the case where CONFIG_UNORDERED_IO is
> enabled on x86_64 which can reorder writes since it uses nontemporal
> stores..

CONFIG_UNORDERED_IO is a failed experiment. I just removed it.

-Andi
