Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVALTsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVALTsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVALTlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:41:23 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:49673 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S261337AbVALTid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:38:33 -0500
Date: Wed, 12 Jan 2005 13:37:27 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Brian Gerst <bgerst@didntduck.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>
Subject: Re: inter_module_get and __symbol_get
Message-ID: <20050112193727.GM1933@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20050106213225.GJ6184@hygelac> <41DDB465.8000705@didntduck.org> <20050106225140.GO6184@hygelac> <9e4733910501072000491d6c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501072000491d6c04@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 12 Jan 2005 19:37:22.0214 (UTC) FILETIME=[22B82C60:01C4F8DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


it would seem like the old mechanism was preferable, but perhaps I'm
missing something. in this particular case, there are times when a user
wants to avoid using agp at all for testing purposes, but if I
understand correctly, we'll be forced to load agpgart anyways due to
unresolved symbols.

but I think Keith Owens was correct in his larger picture view that
this mechanism is useful for much more than just agp. I'm just
confused why it was regressed from a non-gpl symbol to a gpl symbol
(or more appropriately why the non-gpl symbol was regressed in favor
of a gpl-only symbol).

Thanks,
Terence


On Fri, Jan 07, 2005 at 11:00:09PM -0500, jonsmirl@gmail.com wrote:
> The inter_module_xxx free DRM is already in Linus BK. Sooner or later
> the inter_module_xx exports in the AGP driver should disappear too.
> 
> DRM now handles things at compile time. If AGP is enabled at compile
> time, AGP support gets built into the DRM module. If AGP is not
> enabled, AGP does not get compiled in. If you try to take a DRM that
> was built for AGP and move it to a system without, it's not going to
> load because it will need the AGP symbols.
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
