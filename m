Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVBCV2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVBCV2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbVBCV2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:28:38 -0500
Received: from ns.suse.de ([195.135.220.2]:22967 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261178AbVBCVWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:22:16 -0500
Date: Thu, 3 Feb 2005 22:22:12 +0100
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, andrew@walrond.org
Subject: Re: i386 HPET code
Message-ID: <20050203212212.GD3181@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <1107459056.2040.243.camel@cog.beaverton.ibm.com> <20050203120233.A23267@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203120233.A23267@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically I am thinking of something like this will be a good generic solution
> in place of simple two writes.
> 
> for (i = 0 ; i <some number for max retries>; i++) {
> 	hpet_writel(hpet_tick, HPET_T0_CMP);
> 	if (hpet_tick == hpet_readl(hpet_tick, HPET_T0_CMP))
> 		break;
> }

Makes sense. There were so many bugs in PIT timer access over time,
it would be probably a miracle if the hardware engineers got all
the HPET implementations right ;-) 

If you do a fix like this please change x86-64 too.

-Andi

