Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWDSLUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWDSLUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWDSLUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:20:06 -0400
Received: from web38913.mail.mud.yahoo.com ([209.191.125.119]:35441 "HELO
	web38913.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750887AbWDSLUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:20:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0DhH0XLrDcqzgPSVxiRdYir+Pqa/0mBhG+h5l22o4+XN5WBj/CpX9kcaNcH3x/ToEu+pn+jxfnL5toMQWaCxoVBITUEkbW0kg9Y940wwES38T7pIAa9W25kW8KcfH01ue49y6xzxT0ANYjdTSGKrLolaPmyhMY4usRUdC2eXIL8=  ;
Message-ID: <20060419112004.4565.qmail@web38913.mail.mud.yahoo.com>
Date: Wed, 19 Apr 2006 04:20:04 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: RFC: rename arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx
To: Dimitry Andric <dimitry@andric.com>, Ben Dooks <ben-linux-arm@fluff.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <4446187C.2090603@andric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Dimitry Andric <dimitry@andric.com> wrote:

> Ben Dooks wrote:
> > With the advent of the s3c2410 port adding support for
> > more of the samsung SoC product line (s3c2440, s3c2442,
> > s3c2400) there have been several requests by other people
> > to rename the (in their opinion) increasingly inaccurate
> > arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx.
> 
> Well, if you start this way, you might also consider renaming it to
> mach-s3cxxxx, since Samsung also seems to have S3C3410, S3C44B0 and
> who
> knows what else.  Otherwise you'd maybe have to do such an operation
> again in the future...
> 
> Also, I've always found the dichotomy of having
> "include/asm-arm/arch-s3c2410" and "arch/arm/mach-s3c2410" rather
> weird.
> Isn't s3cxxxx an "architecture", instead of a specific machine?  If
> so,
> arch/arm/arch-s3cxxxx would be more logical.

I am not sure, this will apply to Samsung chips or not. But in case of
TI OMAP we had separated the directories based on the "Generation" of
processors produced by TI, which is OMAP1 (OMAP1510, OMAP1610,
OMAP1710, OMAP730, OMAP5910, OMAP5912) and OMAP2 (OMAP2420, OMAP2430 -
(2430 support is not added to git tree yet)). So directory structure
now becomes like

arch/arm/mach-omap1
arch/arm/mach-omap2
include/asm-arm/arch-omap
arch/arm/plat-omap - This directory contains the things which are
common between OMAP1 and OMAP2 generation of processors and can be
#ifdefed with specific CONFIG_ARCH_OMAP1/2. e.g gpio, dma apis etc.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
