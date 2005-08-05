Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVHEDaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVHEDaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 23:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbVHEDaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 23:30:24 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:33749 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262833AbVHEDaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 23:30:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Paul <set@pobox.com>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Fri, 5 Aug 2005 13:25:40 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200508031559.24704.kernel@kolivas.org> <20050805013040.GC7117@squish.home.loc>
In-Reply-To: <20050805013040.GC7117@squish.home.loc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051325.40961.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005 11:30 am, Paul wrote:
> Con Kolivas <kernel@kolivas.org>, on Wed Aug 03, 2005 [03:59:24 PM] said:
> > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> > Patch for 2.6.13-rc5

> 	Ive been running this all afternoon on a pIIx2 @400mhz desktop
> machine, SMP enabled Preempt kernel.
> 	Initially, I tried it using APIC, got X up and tried to play
> some music, but mplayer just hung and prompts in other terminals
> were super slugish or blocked until I killed mplayer. (there were
> no interrupts from the sound card during this time.) Without using
> APIC, it seems to work just great.
> 	With my regular desktop running and me not doing much, 'vmstat 5'
> shows interrupts at 100-200 per entry. Loading the box completely with
> 'make -j4' kernel build their are just over 1000 interrupts. Various other
> loads show numbers in between. (eg. it seems to work as one would expect,
> presuming the timer interupts dominate...)
> 	Time seems fine. I havent noticed any interactivity problems.
> Performance on 'kernbench' was within a percentage point of 2.6.12
> 	It does not seem to make any difference as far as the heat of the
> cpus or mb, though.

Thanks for the feedback. As Tony mentioned, it simply allows for better power 
management to be done rather than saving power on its own. At idle it allows 
the processor to enter a lower power state for example, which I doubt the pII 
does.

Cheers,
Con
