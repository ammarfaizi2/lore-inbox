Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbVBCTb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbVBCTb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbVBCTbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:31:25 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4561 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263787AbVBCTbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:31:06 -0500
Subject: RE: i386 HPET code
From: john stultz <johnstul@us.ibm.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, andrew@walrond.org
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 11:30:56 -0800
Message-Id: <1107459056.2040.243.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 06:28 -0800, Pallipadi, Venkatesh wrote:
> Can you check whether only the following change makes the problem go
> away. If yes, then it looks like a hardware issue.
> 
> >	hpet_writel(hpet_tick, HPET_T0_CMP);
> >+	hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
> >

Yep. Adding only the second write seems to make the box boot.

Since this isn't just affecting our hardware (see Andrew Walrond's
comment in the thread), would doing two writes like x86-64 does be
acceptable? 

thanks
-john


