Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131385AbRCNOjF>; Wed, 14 Mar 2001 09:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRCNOiz>; Wed, 14 Mar 2001 09:38:55 -0500
Received: from dsl-64-129-179-177.telocity.com ([64.129.179.177]:32014 "HELO
	mail.ovits.net") by vger.kernel.org with SMTP id <S131385AbRCNOir>;
	Wed, 14 Mar 2001 09:38:47 -0500
Date: Wed, 14 Mar 2001 09:41:44 -0500
From: Mordechai Ovits <movits@ovits.net>
To: Alex Baretta <alex@baretta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 5Mb missing...
Message-ID: <20010314094144.A18669@ovits.net>
In-Reply-To: <Pine.LNX.4.33.0103070958110.1424-100000@mikeg.weiden.de> <3AAF7AD1.D24E526C@baretta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3AAF7AD1.D24E526C@baretta.com>; from alex@baretta.com on Wed, Mar 14, 2001 at 03:06:09PM +0100
X-Satellite-Tracking: 0x4B305AFF
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 03:06:09PM +0100, Alex Baretta wrote:
> Mike Galbraith wrote:
> > 
> > If crashes are routine on this machine, I'd recommend that you take
> > a serious look at your ram. (or if you're overclocking, don't)
> 
> Crashes were routine, and I was not overclocking, so I took Mike's
> advice and bought a new 256MB DIMM. The computer hasn't crashed
> once since I installed it. Now, though, I have a curious though
> fairly irrelevant problem. My kernel apparently sees less RAM than
> I have.
> 
> 
> [alex@localhost /home]$ free -m
>              total       used       free     shared    buffers    
> cached
> Mem:           251        209         42         60        
> 61         92
> -/+ buffers/cache:         55        196
> 
> 
> I strongly doubt this can be a bug in the kernel. Could anyone
> explain to me why this might happen?

when you boot, your bios decides how much ram is "really" available,
usually for  good reasons.  If the bios knows that its power management
routines need a few meg off the top it'll report a few less meg to the OS
that is to be booted.  You can tell linux to ignore the bios with the kernel
parameter mem=256, but I highly recommend *against* it in this case.  Look
into it.

Mordy
 
> Alex
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
