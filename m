Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319450AbSILGSh>; Thu, 12 Sep 2002 02:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319451AbSILGSh>; Thu, 12 Sep 2002 02:18:37 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:48057 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319450AbSILGSg>;
	Thu, 12 Sep 2002 02:18:36 -0400
Date: Thu, 12 Sep 2002 08:23:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USER_HZ & NTP problems
Message-ID: <20020912082307.E18918@ucw.cz>
References: <fokkensr@fokkensr.vertis.nl> <200209112236.g8BMaMMD016898@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209112236.g8BMaMMD016898@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Wed, Sep 11, 2002 at 06:36:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 06:36:22PM -0400, Horst von Brand wrote:

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

Well, the xtal is usually to be specified with a +-50ppm error, though
many have a larger error, but not too much larger - less than 200ppm, so
you can stay surprised, it's within +-0.02% worst case. 2 at the last
place is about 1.5ppm. This is about five seconds a month.

-- 
Vojtech Pavlik
SuSE Labs
