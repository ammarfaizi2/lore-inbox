Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319156AbSH2JsN>; Thu, 29 Aug 2002 05:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319160AbSH2JsM>; Thu, 29 Aug 2002 05:48:12 -0400
Received: from k100-159.bas1.dbn.dublin.eircom.net ([159.134.100.159]:61200
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S319156AbSH2JsM>; Thu, 29 Aug 2002 05:48:12 -0400
Message-ID: <3D6DEEA6.1010400@corvil.com>
Date: Thu, 29 Aug 2002 10:51:34 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Cort Dougan <cort@fsmlabs.com>,
       Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <Pine.LNX.4.33.0208281249520.4507-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On 28 Aug 2002, Alan Cox wrote:
> 
>>Systems designers are designing on the basis of thermal slowdowns being
>>the optimal way to build some systems. Its actually quite reasonable for
>>many workloads.
> 
> Absolutely. Thermal policy is often an overriding thing, where even 
> non-transmeta CPU's will simply do the decision "on their own", without 
> input from the OS. That's simply because some designs will literally not 
> work above certain temperatures and do not have the heat sink capacity to 
> get out of a tight spot by purely external cooling. 
> 
> But that's just one part of it. Even aside from thermal concerns, you want 
> to drop frequency aggressively when the machine is idle, because dropping 
> the frequency allows you to drop the voltage and effetively gets you a 
> cubed power reduction (which not only saves your battery, but also cools 
> the chip down so that when you _do_ start going full speed again you have 
> more thermal headroom).
> 
> So in order to avoid the thermal shutdown, you need to be proactive about 
> the frequency. Which again means that a user-level "once a second" or 
> "once in a blue moon" approach is fundamentally flawed.

Just a data point from my application. First of all with VIA CPUs
there is a 1ms delay per change when it resyncs things, so it's
not practical to do it very often or for realtime apps etc.
My application was purely a heat reduction exercise where the
timescale from 0°C to 70°C was around 10 minutes at max voltage/frequency,
so it could easily be controlled by a userspace application.
In fact I didn't control it manually and only set the frequency
(for which the appropriate voltage was chosen by the cpufreq code)
at system startup.

> I don't disagree with _also_ being able to set the frequency statically. 
> However, I do disagree with an interface that seems to be _purely_ 
> designed for this, and nothing else. 
> 
> 		Linus

Pádraig.

