Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSDDTYP>; Thu, 4 Apr 2002 14:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSDDTYH>; Thu, 4 Apr 2002 14:24:07 -0500
Received: from ECE.CMU.EDU ([128.2.136.200]:64229 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S310241AbSDDTXw>;
	Thu, 4 Apr 2002 14:23:52 -0500
Date: Thu, 4 Apr 2002 14:23:31 -0500 (EST)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
Reply-To: Nilmoni Deb <ndeb@ece.cmu.edu>
To: Andre Pang <ozone@algorithm.com.au>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, davej@suse.de
Subject: Re: Summary of KL133/KM133 problems w/2.4.18
In-Reply-To: <1017915759.167695.7510.nullmailer@bozar.algorithm.com.au>
Message-ID: <Pine.LNX.3.96L.1020404133004.7594B-100000@d-alg.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andre,
	I just now discovered from http://www.viaarena.com/?PageID=70
that:

KM133 => VT8365 northbridge _always_
KL133 => VT8361 northbridge _OR_ VT8364 northbridge

Now (from kernel 2.4.18) linux-2.4.18/arch/i386/kernel/pci-pc.c has these
comment lines:

  * VIA 8363,8622,8361 Northbridges: 
  * - bits 5, 6, 7 at offset 0x55 need to be turned off 

It appears that ur patch doesnot affect chipsets with VT8361 northbridge.

Basically, ur patch is applicable for all KM133 (VT8365) chipsets.
But should it apply only to those KL133 chipsets with VT8364
northbridge or to KL133 chipsets with VT8361 northbridge too ?

So, besides the issue of renaming two macros, this patch needs to decide
which (or all) of the two types of KL133 chipsets is to be targeted.

thanks
- Nil


On Thu, 4 Apr 2002, Andre Pang wrote:

> On Thu, Apr 04, 2002 at 03:24:58AM -0500, Nilmoni Deb wrote:
> 
> > But the naming could have been more accurate and the following may be
> > good suggestions:
> > 
> > #define VIA_8364_KL133_REVISION_ID 0x84
> > #define VIA_8365_KM133_REVISION_ID 0x81
> 
> Thanks Nil!  I'll send off another patch to Alan/Marcelo/Dave
> when I get some time :).  (Feel free to do that if you like, of
> course.)
> 
> 
> -- 
> #ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
> 




