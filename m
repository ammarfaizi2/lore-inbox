Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVH3GKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVH3GKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVH3GKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:10:12 -0400
Received: from mirapoint5.brutele.be ([212.68.199.150]:28993 "EHLO
	mirapoint5.brutele.be") by vger.kernel.org with ESMTP
	id S1750810AbVH3GKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:10:11 -0400
Date: Tue, 30 Aug 2005 08:10:03 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13 : __check_region is deprecated
Message-ID: <20050830061003.GA18507@localhost.localdomain>
References: <20050829231417.GB2736@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050829231417.GB2736@localhost.localdomain>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint5.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090201.4313F562.0004-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=80=A1=0B=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tuesday 30 August 2005 a 01:08, Stephane Wirtel ecrivait: 
> Hi, 
> 
> By compiling my kernel, I can see that the __check_region function (in
> kernel/resource.c) is deprecated.
> 
> With a grep on the source code of the last release, I get this result.
> 
> drivers/pnp/resource.c:255:             if (__check_region(&ioport_resource, *port, length(port,end))) 
> include/linux/ioport.h:117:#define check_mem_region(start,n) __check_region(&iomem_resource, (start), (n))
> include/linux/ioport.h:120:extern int __check_region(struct resource *, unsigned long, unsigned long);
> include/linux/ioport.h:125:     return __check_region(&ioport_resource, s, n);
> kernel/resource.c:468:int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
> kernel/resource.c:481:EXPORT_SYMBOL(__check_region);


This morning, I worked on a patch to remove this deprecated function,
there are three patchs, 
patch for kernel/resource.c
patch for include/linux/ioport.h
patch for drivers/pnp/resource.c

I go to my job, but after, I will check my patches.

Best Regards, 

Stephane
-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>


