Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWHFXTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWHFXTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHFXTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:19:55 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:3462 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750767AbWHFXTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:19:54 -0400
Message-ID: <44D6791F.8030001@drzeus.cx>
Date: Mon, 07 Aug 2006 01:19:59 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx>	 <20060806204842.GE16816@flint.arm.linux.org.uk>	 <44D657BF.6070004@drzeus.cx>	 <20060806210509.GF16816@flint.arm.linux.org.uk>	 <44D65F4D.3060907@drzeus.cx> <20060806213524.GC8907@home.fluff.org>	 <44D66491.1090606@drzeus.cx> <1154907141.25998.2.camel@localhost.localdomain>
In-Reply-To: <1154907141.25998.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Sul, 2006-08-06 am 23:52 +0200, ysgrifennodd Pierre Ossman:
>   
>> Sorry, my intention wasn't to assert that it was only to be used on x86
>> but that the 16-bit assumption was safe.
>>     
>
> Your ISA bus mappings on a non x86 processor are likely to be 32bit MMIO
> -> PIO windows in memory space. 
>
>   

Since we configure the device, the PIO address must not be subject to
translation. If it is, then we must know how the translation is done.

As this is a rather crappy chip which nobody in their right mind would
use, we'll cross that bridge when/if someone decides to use it in a
system that doesn't behave like x86.

Rgds
Pierre

