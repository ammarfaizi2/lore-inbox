Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278447AbRKHVW7>; Thu, 8 Nov 2001 16:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278470AbRKHVWu>; Thu, 8 Nov 2001 16:22:50 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:29970 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S278450AbRKHVWj>; Thu, 8 Nov 2001 16:22:39 -0500
Date: Thu, 8 Nov 2001 22:22:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA 686 timer bugfix incomplete
Message-ID: <20011108222236.A6581@suse.cz>
In-Reply-To: <20011107211445.A2286@suse.cz> <Pine.LNX.4.05.10111080917140.19515-100000@marina.lowendale.com.au> <20011108090215.G3708@suse.cz> <20011108102124.31ca040f.diemer@gmx.de> <20011108210840.A6266@suse.cz> <20011108221751.5273484e.diemer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108221751.5273484e.diemer@gmx.de>; from diemer@gmx.de on Thu, Nov 08, 2001 at 10:17:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 10:17:51PM +0100, Jonas Diemer wrote:

> On Thu, 8 Nov 2001 21:08:40 +0100
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > There is a little problem with RTC, though:
> > 
> > While you can set it up to generate interrupts at say 1024 Hz, you can't
> > read any value of how much time passed since last interrupt. You can do
> > this on the PIT (i8253), and this is the part that is buggy.
> > 
> > TSC is perfect, precise and accurate, but not reliable in long term.
> > Some CPUs do thermal throttling, notebooks play with CPU speed, etc,
> > etc. And it's not synchronized to any interrupt source.
> > 
> > Ugly, ugly, ugly is the PC architecture.
> > 
> 
> can't you just read the battery buffered clock? how are other OSes such as
> Window$ doing the timing?

You can. But you only get 0.5 second resolution, which obviously isn't
good enough for microsecond timing.

-- 
Vojtech Pavlik
SuSE Labs
