Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752465AbVHGRsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbVHGRsX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbVHGRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:48:22 -0400
Received: from hockin.org ([66.35.79.110]:31447 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S1752465AbVHGRsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:48:22 -0400
Date: Sun, 7 Aug 2005 10:48:11 -0700
From: Tim Hockin <thockin@hockin.org>
To: Andi Kleen <ak@suse.de>
Cc: Erick Turnquist <jhujhiti@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Message-ID: <20050807174811.GA31006@hockin.org>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel> <p73mznuc732.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73mznuc732.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 01:36:01PM +0200, Andi Kleen wrote:
> Erick Turnquist <jhujhiti@gmail.com> writes:
> 
> > Hi, I'm running an Athlon64 X2 4400+ (a dual core model) with an
> > nVidia GeForce 6800 Ultra on a Gigabyte GA-K8NXP-SLI motherboard and
> > getting nasty messages like these in my dmesg:
> > 
> > warning: many lost ticks.
> > Your time source seems to be instable or some driver is hogging interupts
> > rip default_idle+0x20/0x30
> 
> It's most likely bad SMM code in the BIOS that blocks the CPU too long
> and is triggered in idle. You can verify that by using idle=poll
> (not recommended for production, just for testing) and see if it goes away.
> 
> No way to fix this, but you can work around it with very new kernels
> by compiling with a lower HZ than 1000.

Some BIOSes do not lock SMM, and you *could* turn it off at the chipset
level.
