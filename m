Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319373AbSIKWwc>; Wed, 11 Sep 2002 18:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319375AbSIKWwc>; Wed, 11 Sep 2002 18:52:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64507 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S319373AbSIKWwb>;
	Wed, 11 Sep 2002 18:52:31 -0400
Message-ID: <3D7FCA36.96B7D1B1@mvista.com>
Date: Wed, 11 Sep 2002 15:56:54 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USER_HZ & NTP problems
References: <200209112236.g8BMaMMD016898@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Rolf Fokkens <fokkensr@fokkensr.vertis.nl> said:
> > On Tuesday 10 September 2002 08:09, Vojtech Pavlik wrote:
> > > Actually, the clock true frequency is 1193181.8 Hz, although most
> > > manuals say 1.19318 MHz, which, because truncating more digits, also
> > > correct. But 1193180 Hz isn't. If you're trying to count the time
> > > correctly, you should better use 1193182 Hz if staying in integers.
> >
> > I copied the clock frequency from the kernel source, timex.h defines:
> >
> > #define CLOCK_TICK_RATE 1193180
> >
> > If what you're saying is correct, timex.h uses the wrong value as wel I guess.
> 
> I'd be _really_ surprised if that number is within 1% (+-11932 or so)
> correct, an error in the last digit (0.0001%) is surely lost.
> --
But it DOES explain why the ACPI pm timer at 3579545 is not
exactly 3 * CLOCK_TICK_RATE.  Inquiring minds want to know
:)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
