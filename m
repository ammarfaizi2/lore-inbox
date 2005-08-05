Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVHEBaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVHEBaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVHEBaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:30:46 -0400
Received: from pop-6.dnv.wideopenwest.com ([64.233.207.24]:55274 "EHLO
	pop-6.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S262800AbVHEBao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:30:44 -0400
Date: Thu, 4 Aug 2005 21:30:40 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@kolivas.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050805013040.GC7117@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
	kernel@kolivas.org
References: <200508031559.24704.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org>, on Wed Aug 03, 2005 [03:59:24 PM] said:
> This is the dynamic ticks patch for i386 as written by Tony Lindgen 
> <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>. 
> Patch for 2.6.13-rc5
> 
> There were a couple of things that I wanted to change so here is an updated 
> version. This code should have stabilised enough for general testing now.
> 
> The sysfs interface was moved to its own directory 
> in /sys/devices/system/dyn_tick and split into separate files to 
> enable/disable dynamic ticks and usage of apic on the fly. It makes sense to 
> enable dynamic ticks and usage of apic by default if they're actually built 
> into the kernel so that is now done.
> 
> Cheers,
> Con

	Hi;

	Ive been running this all afternoon on a pIIx2 @400mhz desktop
machine, SMP enabled Preempt kernel.
	Initially, I tried it using APIC, got X up and tried to play
some music, but mplayer just hung and prompts in other terminals
were super slugish or blocked until I killed mplayer. (there were
no interrupts from the sound card during this time.) Without using
APIC, it seems to work just great.
	With my regular desktop running and me not doing much, 'vmstat 5'
shows interrupts at 100-200 per entry. Loading the box completely with
'make -j4' kernel build their are just over 1000 interrupts. Various other
loads show numbers in between. (eg. it seems to work as one would expect,
presuming the timer interupts dominate...)
	Time seems fine. I havent noticed any interactivity problems.
Performance on 'kernbench' was within a percentage point of 2.6.12
	It does not seem to make any difference as far as the heat of the
cpus or mb, though.

Hope this datapoint is useful;
Paul
set@pobox.com
