Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVDFPQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVDFPQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVDFPQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:16:10 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:5085 "EHLO laptop.blackstar.nl")
	by vger.kernel.org with ESMTP id S262225AbVDFPQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:16:05 -0400
Subject: Re: NOMMU - How to reserve 1 MB in top of memory in a clean way
From: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <tnxzmwc9gun.fsf@arm.com>
References: <1112781027.2687.6.camel@laptop.blackstar.nl>
	 <tnxzmwc9gun.fsf@arm.com>
Content-Type: text/plain
Message-Id: <1112800564.2687.40.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 06 Apr 2005 17:16:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 15:26, Catalin Marinas wrote:
> Bas Vermeulen <bvermeul@blackstar.xs4all.nl> wrote:
> > I am currently working on the bfinnommu linux port for the BlackFin 533.
> > I need to grab the top 1 MB of memory so I can give it out to drivers
> > that need non-cached memory for DMA operations.
> 
> I did this long time ago (on a 2.4 kernel), trying to avoid a hardware
> problem. I re-ordered the zones so that ZONE_DMA came after
> ZONE_NORMAL. Since the DMA memory was quite small (less than 1MB), I
> also put a "break" before "case ZONE_DMA" in the
> build_zonelists_node() functions to avoid the allocation fallback.

This will put me in the zone of 'it ain't ever going to be integrated'.
I'd preferrably find a solution without changing the zones. My ideal
solution would be grabbing pages before they are assigned to a zone, or
at least for the zone to recognize them as used.

Bas Vermeulen

