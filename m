Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277942AbRKHUJD>; Thu, 8 Nov 2001 15:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278038AbRKHUIy>; Thu, 8 Nov 2001 15:08:54 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:54801 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S278046AbRKHUIn>; Thu, 8 Nov 2001 15:08:43 -0500
Date: Thu, 8 Nov 2001 21:08:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA 686 timer bugfix incomplete
Message-ID: <20011108210840.A6266@suse.cz>
In-Reply-To: <20011107211445.A2286@suse.cz> <Pine.LNX.4.05.10111080917140.19515-100000@marina.lowendale.com.au> <20011108090215.G3708@suse.cz> <20011108102124.31ca040f.diemer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108102124.31ca040f.diemer@gmx.de>; from diemer@gmx.de on Thu, Nov 08, 2001 at 10:21:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 10:21:24AM +0100, Jonas Diemer wrote:

> Well, then maybe Vojtech's suggestion is best: use RTC for timing, not the
> chipset...
> as to my knowledge, every i38 system has a standard RTC, so why not use this? or
> even better: make an option in the config to choose whether use RTC or the
> chipset.

There is a little problem with RTC, though:

While you can set it up to generate interrupts at say 1024 Hz, you can't
read any value of how much time passed since last interrupt. You can do
this on the PIT (i8253), and this is the part that is buggy.

TSC is perfect, precise and accurate, but not reliable in long term.
Some CPUs do thermal throttling, notebooks play with CPU speed, etc,
etc. And it's not synchronized to any interrupt source.

Ugly, ugly, ugly is the PC architecture.

-- 
Vojtech Pavlik
SuSE Labs
