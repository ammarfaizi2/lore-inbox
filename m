Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbTCFXA1>; Thu, 6 Mar 2003 18:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261177AbTCFXA1>; Thu, 6 Mar 2003 18:00:27 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12292 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261165AbTCFXAX>;
	Thu, 6 Mar 2003 18:00:23 -0500
Date: Thu, 6 Mar 2003 22:26:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving physical memory at boot time
Message-ID: <20030306212607.GA173@elf.ucw.cz>
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com> <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net> <b442s0$pau$1@cesium.transmeta.com> <32981.4.64.238.61.1046844111.squirrel@www.osdl.org> <b453mj$qpi$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b453mj$qpi$1@cesium.transmeta.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > OK, with feeling:
> > 
> > I agree with you since the boot protocol is well-defined.
> > 
> > Just to be clear, my comment was referring to
> > Documentation/kernel-parameters.txt, not to any C code.
> > 
> > And it would really be helpful to catch issues like this soon
> > after they happen...
> > 
> 
> Unfortunately last time I commented on this the response was roughly
> "well, the patch already made it into Linus' kernel, it's too late to
> fix it now."  That isn't exactly a very helpful response.
> 
> The mem= parameter has the semantic in the i386/PC boot protocol that
> it specifies the top address of the usable memory region that begins
> at 0x100000.  It's a bit of a wart that the boot loaders have to be
> aware of this, but it's so and it's been so for a very long time.

Really? So user has to know where ACPI tables are and specify less
than that on mem= command line? That seems very
counter-intuitive. [Ahha, its probaly okay because e820 saves you.]

What do you pass on 4GB machine as mem= parameter? AFAIK those beasts
have hole at 3.75G. [Hopefully bigmem machines have working e820
tables?]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
