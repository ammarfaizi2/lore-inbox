Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVDFN1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVDFN1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVDFN1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:27:20 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:29577 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262206AbVDFN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:26:10 -0400
To: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NOMMU - How to reserve 1 MB in top of memory in a clean way
References: <1112781027.2687.6.camel@laptop.blackstar.nl>
From: Catalin Marinas <catalin.marinas@gmail.com>
Date: Wed, 06 Apr 2005 14:26:08 +0100
In-Reply-To: <1112781027.2687.6.camel@laptop.blackstar.nl> (Bas Vermeulen's
 message of "Wed, 06 Apr 2005 11:50:28 +0200")
Message-ID: <tnxzmwc9gun.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Vermeulen <bvermeul@blackstar.xs4all.nl> wrote:
> I am currently working on the bfinnommu linux port for the BlackFin 533.
> I need to grab the top 1 MB of memory so I can give it out to drivers
> that need non-cached memory for DMA operations.

I did this long time ago (on a 2.4 kernel), trying to avoid a hardware
problem. I re-ordered the zones so that ZONE_DMA came after
ZONE_NORMAL. Since the DMA memory was quite small (less than 1MB), I
also put a "break" before "case ZONE_DMA" in the
build_zonelists_node() functions to avoid the allocation fallback.

-- 
Catalin

