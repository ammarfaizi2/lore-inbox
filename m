Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319451AbSILGW6>; Thu, 12 Sep 2002 02:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319452AbSILGW6>; Thu, 12 Sep 2002 02:22:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:51641 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319451AbSILGW5>;
	Thu, 12 Sep 2002 02:22:57 -0400
Date: Thu, 12 Sep 2002 08:27:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: george anzinger <george@mvista.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Rolf Fokkens <fokkensr@fokkensr.vertis.nl>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USER_HZ & NTP problems
Message-ID: <20020912082729.F18918@ucw.cz>
References: <200209112236.g8BMaMMD016898@pincoya.inf.utfsm.cl> <3D7FCA36.96B7D1B1@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D7FCA36.96B7D1B1@mvista.com>; from george@mvista.com on Wed, Sep 11, 2002 at 03:56:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 03:56:54PM -0700, george anzinger wrote:
> Horst von Brand wrote:
> > 
> > Rolf Fokkens <fokkensr@fokkensr.vertis.nl> said:
> > > On Tuesday 10 September 2002 08:09, Vojtech Pavlik wrote:
> > > > Actually, the clock true frequency is 1193181.8 Hz, although most
> > > > manuals say 1.19318 MHz, which, because truncating more digits, also
> > > > correct. But 1193180 Hz isn't. If you're trying to count the time
> > > > correctly, you should better use 1193182 Hz if staying in integers.
> > >
> > > I copied the clock frequency from the kernel source, timex.h defines:
> > >
> > > #define CLOCK_TICK_RATE 1193180
> > >
> > > If what you're saying is correct, timex.h uses the wrong value as wel I guess.
> > 
> > I'd be _really_ surprised if that number is within 1% (+-11932 or so)
> > correct, an error in the last digit (0.0001%) is surely lost.
> > --
> But it DOES explain why the ACPI pm timer at 3579545 is not
> exactly 3 * CLOCK_TICK_RATE.  Inquiring minds want to know
> :)

Yeah. It's all based on NTSC dotclock from the old IBM PC.
(which is 4x ACPI clock and 12x PIT clock)

-- 
Vojtech Pavlik
SuSE Labs
