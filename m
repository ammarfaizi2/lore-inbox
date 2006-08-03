Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWHCHX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWHCHX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWHCHX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:23:57 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:43959 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932366AbWHCHX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:23:56 -0400
Date: Thu, 3 Aug 2006 10:23:52 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org
Subject: Re: [PATCH] Move valid_dma_direction() from x86_64 to generic code
Message-ID: <20060803072352.GE4736@rhun.haifa.ibm.com>
References: <200607280928.54306.eike-kernel@sf-tec.de> <200608021720.40815.eike-kernel@sf-tec.de> <20060802185527.GB4982@rhun.ibm.com> <200608030825.19651.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608030825.19651.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 08:25:19AM +0200, Rolf Eike Beer wrote:

> > ./arch/x86_64/kernel/pci-swiotlb.c:6:#include <asm/dma-mapping.h>
> > ./drivers/net/fec_8xx/fec_main.c:40:#include <asm/dma-mapping.h>
> > ./drivers/net/fs_enet/fs_enet.h:11:#include <asm/dma-mapping.h>
> > ./include/asm-x86_64/swiotlb.h:5:#include <asm/dma-mapping.h>
> 
> I suspect it to be a bug anyway that every of this files ever included 
> asm/dma-mapping.h.

Agreed wrt the fs_enet and fec_8xx; the swiotlb stuff I dimly recall I
had a reason for. I'll take a look in bit to verify akpm's fix works.

> > ./include/linux/dma-mapping.h:27:#include <asm/dma-mapping.h>
> 
> This is perfectly valid, isn't it :)

:-)

Cheers,
Muli
