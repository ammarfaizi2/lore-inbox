Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTBCWkN>; Mon, 3 Feb 2003 17:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTBCWkF>; Mon, 3 Feb 2003 17:40:05 -0500
Received: from fmr02.intel.com ([192.55.52.25]:12759 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267033AbTBCWiJ>; Mon, 3 Feb 2003 17:38:09 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A14B@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Valdis.Kletnieks@vt.edu, John Bradford <john@grabjohn.com>,
       Seamus <assembly@gofree.indigo.ie>, linux-kernel@vger.kernel.org
Subject: RE: CPU throttling??
Date: Mon, 3 Feb 2003 13:51:13 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@codemonkey.org.uk] 
>  > Throttling offers a linear power/perf tradeoff if your 
> system doesn't
>  > have C state support (or if you aren't using it) but really it is
>  > preferable to keep the CPU at its nominal speed, get the work done
>  > sooner, and start sleeping right away. The quote above 
> makes it sound
>  > like the voltage is scaled when throttling, and that isn't 
> accurate -
>  > voltage is scaled when sleeping (to counteract leakage current), at
>  > least on modern Intel mobile processors.
> 
> Most (all?[1]) other modern x86 mobile processors behave the 
> way I mentioned.
> AMD Powernow (K6 and K7), VIA longhaul/powersaver all have 
> optimal voltages
> they can be run at when clocked to different speeds. By way 
> of example, a table from
> my mobile athlon..
> 
>     FID: 0x12 (4.0x [532MHz])   VID: 0x13 (1.200V)
>     FID: 0x4 (5.0x [665MHz])    VID: 0x13 (1.200V)
>     FID: 0x6 (6.0x [798MHz])    VID: 0x13 (1.200V)
>     FID: 0xa (8.0x [1064MHz])   VID: 0xd (1.350V)
>     FID: 0xf (10.5x [1396MHz])  VID: 0x9 (1.550V)
> 
> Sure I *could* run that at 523MHz and still pump 1.550V into it,
> but why would I want to do that ?

Voltage scaling. Yes, it's widespread. I was referring to an additional
capability to lower voltage while the CPU is sleeping. But I digress.

But this whole thread didn't start as a discussion of voltage scaling,
it started as a discussion of throttling - e.g. keeping your system at
1400MHz 1.550V and simulating a slower processor by toggling the STPCLK#
pin. And you're exactly right that no you *wouldn't* want to do that.

I think we are in agreement. ;-)

Regards -- Andy
