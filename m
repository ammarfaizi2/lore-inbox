Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWCVGNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWCVGNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWCVGNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:13:11 -0500
Received: from nwd2mail2.analog.com ([137.71.25.51]:5567 "EHLO
	nwd2mail2.analog.com") by vger.kernel.org with ESMTP
	id S1750801AbWCVGNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:13:09 -0500
Message-Id: <6.1.1.1.0.20060321224917.01ec6970@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 22 Mar 2006 01:12:52 -0500
To: akpm@osdl.org
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Cc: linux-kernel@vger.kernel.org, luke.adi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang wrote:
>On 3/21/06, Andrew Morton <akpm@osdl.org> wrote:
> > - How widespread/popular is the blackfin?  Are many devices using it?
> >   How old/mature is it?  Is it a new thing or is it near end-of-life?
>   As a DSP, Blackfin has been there for years and is somewhat popular.
>But as a CPU which can run Linux, we are trying to make it popular.
>Anyway a 5$ chip runs Linux and can do audio/video codec is a good toy to 
>play with.

I would not describe it as a toy (sorry Luke), plus I would consider the 
work we have done to be mildly popular in terms of Linux support. I think 
that since Luke mostly has his head down doing development, doesn't see all 
the people that are in production...

I still consider Blackfin a "new" architecture (in terms of processors). 
Some background on Blackfin/MSA can be found:
http://www.intel.com/design/msa/

Blackfin is a low cost (under $5.00 @ 400MHz) high performance (Dual core 
at 600MHz each) processor that people are using, and shipping in real products.
http://www.analog.com/processors/processors/blackfin/BlackfinFamilyReferenceTable.html
Our kernel source supports BF531, BF532, BF533, BF534, BF536, BF537, BF561

A few people what started shipping that we did press releases with (many 
others did not):
thermal infrared imaging camera:
http://www.analog.com/en/press/0,2890,3%255F%255F92455,00.html
Internet-Protocol Television (IPTV) set-top boxes:
http://www.analog.com/en/press/0,2890,3%255F%255F86425,00.html

We are engaged with lots of people - from students to people shipping 
millions of units. We have almost 1600 registered developers on our web 
site, and have had over 66,000 individual downloads of our kernel source 
(not including checkouts or rsync of our cvs) - lots of people are using 
it. That doesn't compare to the traffic on kernel.org, or people using x86, 
but it is not bad for a "new" architecture.

People are making uClinux based SBC based on Blackfin:
http://www.zbrain.ch/htm/docs/zbrain_flyer_gnu_kit.pdf
http://www.tinyboards.com/rainbow2006/site/hardware/core_modules/__cm-bf537e/313/cm-bf537e.aspx
http://www.camsig.co.uk/products.htm

People are making 3rd party emulators (for those who don't want to use gdb 
or kgdb, - we support both):
http://www.section5.ch/?which=1&sub=1

It is not a toy - people (including the 15 and growing people working full 
time on this at ADI) make their living making sure it is acceptable both to 
the people deploying it in a product, but also to the community at large - 
we don't want to end up with a maintenance issues either, and have been 
working pretty hard in getting into the mainline trees for all the projects 
we are working on (toolchain, bootloader, ltp, kernel). Luke is spending 
almost 90% of his time, ensuring that everything in our kernel source meets 
the feedback from the mainline maintainers (and soon will help re-write the 
serial driver, based on Russell King's feedback :)


> >   It's a cost/benefit thing.  It costs us to add code to the kenrel.  How
> >   many people would benefit from us doing that?
>    As multimedia is becoming popular in embedded world, I believe many 
> people would benefit from a DSP running Linux.

IMHO - It is more than just another processor running Linux.

For people who ship large volume, it is a new mix of 
price/performance/power/peripherals that embedded Linux has not been able 
to meet in the past. We are enabling people to add (or keep) Linux to their 
products, and decrease their cost. We enable Linux on the network edge - 
for example : IP Phones - we worked with the maintainer of Linphone, and 
people are deploying that in their systems for VoIP.

For people who ship zero volume (which is great) - it is a completely free 
system. free toolchain, free debugger, free libraries, free kernel, free 
applications, free schematics, free simulator (skyeye), free documentation 
(web site), free support (web site). Free as in speech (open source), and 
in beer(zero cost). For those who want to run it on hardware - - $200(US) 
at Digikey, you get a board with 10/100 Networking, 500MHz CPU, 64Meg 
SDRAM, 4 Meg Flash, and lots of expansion.

If you think our patch sucks, fine - let us know where to fix it. We will 
be back at 2.6.17 with an update - and you can tell us where that sucks 
then too. (Just like we did at 2.6.13, where lots of people pointed out 
issues, which we worked on fixing for now)

-Robin

