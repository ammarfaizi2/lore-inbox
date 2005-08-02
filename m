Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVHBHWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVHBHWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVHBHW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:22:29 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:210 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261411AbVHBHVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:21:47 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 2 Aug 2005 00:21:33 -0700
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, tuukka.tikkanen@elektrobit.com,
       ck@vds.kolivas.org
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Message-ID: <20050802072132.GH15903@atomide.com>
References: <200508021443.55429.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508021443.55429.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [050801 21:41]:
> This is a code reordered version of the dynamic ticks patch from Tony Lindgen 
> and Tuukka Tikkanen - sorry about spamming your mail boxes with this, but 
> thanks for the code. There is significant renewed interest by the lkml 
> audience for such a feature which is why I'm butchering your code (sorry 
> again if you don't like me doing this). The only real difference between your 
> code and this patch is moving the #ifdef'd code out of code paths and putting 
> it into dyn-tick specific files. 

Great! We ported it from ARM to x86 so people could develop it further. Help
is really appreciated to get it into shape for integration.

> This has slightly more build fixes than the last one I posted and boots and 
> runs fine on my laptop. So far at absolute idle it appears this pentiumM 1.7 
> is claiming to have _25%_ more battery life. I'll need to investigate further 
> to see the real power savings. 

What is your HZ according to pmstats?

> My desktop pentium4 did not like the patch erroring with "bad gzip magic 
> number" on boot for reasons that aren't obvious to me. This could be related 
> to trying gcc 4.0.1 on that box whereas the laptop is on gcc 3.4.4 and is 
> working fine.

Yeah, this sounds like an issue with the decompression code.

Tony
