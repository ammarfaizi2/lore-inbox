Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272204AbRHXQGN>; Fri, 24 Aug 2001 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272210AbRHXQGD>; Fri, 24 Aug 2001 12:06:03 -0400
Received: from ns.suse.de ([213.95.15.193]:46859 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272204AbRHXQFu> convert rfc822-to-8bit;
	Fri, 24 Aug 2001 12:05:50 -0400
Date: Fri, 24 Aug 2001 18:06:00 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Padraig Brady <Padraig@AnteFacto.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OT] CPU temperature control
In-Reply-To: <3B86771E.3050207@AnteFacto.com>
Message-ID: <Pine.LNX.4.30.0108241801420.14354-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Padraig Brady wrote:

> I'm using a C3 700MHz CPU underclocked to 466MHz (66MHz FSB),
> and @ full load I'm getting the CPU to 63°C in a fanless 1U case.
> What I would like is to throttle the CPU back X% if the temperature
> exceeds say 50% which I can easily read using lm sensors.
> So, what's the best way to do this? user space / kernel space??
> Note the C3 has a suspend on halt (instruction) option which will
> help things also.

Russell King has been working on a architecture independant framework
for this kind of feature. I recently started work on VIA support for it.
After this weekend, my socket 370 motherboard should turn up and
I'll be able to test / finish the support for it.

You can find the code so far at..
cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot co cpufreq

So far, there are several implementations in there, in various stages
of completion. The various x86 types need finishing, and it'll be
ready (as long as rmk has nothing else to add to it) for submission.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

