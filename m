Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVGZNPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVGZNPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGZNPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:15:16 -0400
Received: from styx.suse.cz ([82.119.242.94]:15001 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261778AbVGZNOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:14:40 -0400
Date: Tue, 26 Jul 2005 15:14:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-ID: <20050726131439.GB2134@ucw.cz>
References: <20050721200448.5c4a2ea0.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721200448.5c4a2ea0.lista1@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 08:04:48PM +0200, Voluspa wrote:
> 
> I'd gladly (ehum..) redo this mind-numbingly boring test if someone can
> point me to a magic software which unleashes some untapped powersaving
> feature of the CPU.
> 
> _Kernel 2.6.13-rc3 Boot to Death_:
> 
> 2h48m at 100 HZ
> 2h48m at 250 HZ
> 2h47m at 1000 HZ

Is USB loaded? It'll do 1000 interrupts per second if it is. I'm not sure if
this still is the case on 2.6.13-rc3, please check your /proc/interrupts
to see the rate at which interrupt counters are increasing.

> Acer Aspire 1520 (1524) WLMi, AMD Athlon 64 3400+ (socket 754 according
> to dmidecode-2.6). L1 64K/64K, L2 1024K, 512MB DDR RAM. Manufacturing
> date 18 March 2005. Bought 20 May 2005. Battery used to full drain ca 5
> times prior to this test (after the initial 3 charge/drains to reach its
> full potential). "cat /proc/acpi/battery/BAT0/info":
 
This almost looks like a regular Athlon 64, not even the mobile version.
I wouldn't expect very big deep sleep capabilities on that one. You can
check the 

	/proc/acpi/processor/CPU1/power

file for the list of C states. A normal Athlon64 will likely have only
C0. Mobile chips can go up to C4, which is really deep sleep.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
