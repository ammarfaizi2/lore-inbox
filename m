Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWEATDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWEATDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWEATDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:03:17 -0400
Received: from mx.pathscale.com ([64.160.42.68]:38809 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932143AbWEATDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:03:16 -0400
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada3bftvatf.fsf@cisco.com>
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	 <ada3bftvatf.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 12:03:16 -0700
Message-Id: <1146510196.4544.1.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 11:50 -0700, Roland Dreier wrote:
>     Bryan> Move away from an obsolete, unportable routine for
>     Bryan> translating physical addresses.
> 
> This change:
> 
>  > -		isge->vaddr = bus_to_virt(sge->addr);
>  > +		isge->vaddr = phys_to_virt(sge->addr);
> 
> is really wrong.  bus_to_virt() is really what you want, because in
> this case the address is a bus address that came from dma_map_xxx().

Well, bus_to_virt is not portable, so we definitely can't use it.  I'll
have to do some thinking about this.

	<b

