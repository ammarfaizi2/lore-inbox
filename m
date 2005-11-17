Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVKQTwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVKQTwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVKQTwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:52:05 -0500
Received: from khc.piap.pl ([195.187.100.11]:28164 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964826AbVKQTwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:52:04 -0500
To: dsaxena@plexity.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: dma_is_consistent() is nonsensical...
References: <20051117184745.GA23776@plexity.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 17 Nov 2005 20:52:02 +0100
In-Reply-To: <20051117184745.GA23776@plexity.net> (Deepak Saxena's message
 of "Thu, 17 Nov 2005 10:47:45 -0800")
Message-ID: <m3ek5frr19.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena <dsaxena@plexity.net> writes:

> Working on adding support for cache-coherent operation to ARM and 
> wondering exactly what this API is supposed to do. From the name it
> is obviously supposed to tell the caller (only one in the kernel...
> drivers/scsi/53c700.c) whether the provided dma_handle is cache-coherent
> or not.  In the case of multiple DMA domains where certain devices
> are on snooping interfaces and others are not we really want to know what
> device the DMA address is on so can we add a struct device* ptr to this 
> function? Or can we just kill it since nobody is actually using it? 
> Calling dma_alloc_coherent should always return coherent/consistent 
> (why the different naming conventions too?) so I don't really see a real 
> use case. 

I would have to look at the current code but yes, there were issues
like that in the past. Coherent vs consistent - there are two APIs
(DMA and PCI) each with a different name for this.
-- 
Krzysztof Halasa
