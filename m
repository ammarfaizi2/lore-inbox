Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbRGPBa3>; Sun, 15 Jul 2001 21:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbRGPBaT>; Sun, 15 Jul 2001 21:30:19 -0400
Received: from c008-h000.c008.snv.cp.net ([209.228.34.63]:4344 "HELO
	c008.snv.cp.net") by vger.kernel.org with SMTP id <S265571AbRGPBaH>;
	Sun, 15 Jul 2001 21:30:07 -0400
X-Sent: 16 Jul 2001 01:30:00 GMT
Message-ID: <3B52438B.3CC6E1BC@acm.org>
Date: Mon, 16 Jul 2001 11:29:47 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15Lnrk-00047x-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Right but we cannot go around breaking support for older setups. A user
> updating their 2.4.x stable kernel and finding X11 no longer works simply isnt
> an acceptable situation for serious users.

Agreed 100%.

> Why was so much of it macroised rather than turned into library routines ?

Customization is the big one.  Some drivers need AGP, some need MTRRs,
some need DMA, some need interrupts etc.  With the templates, this is
done with minimal code duplication, and allows the final routines to be
space-efficient -- only the code that each driver actually needs is
present.  This is advantageous when building as modules, or building a
single driver into the kernel.  You could argue that it's less important
when building many drivers into the kernel, but how many people do that?

Plus, there were symbol clashing problems with building some drivers
into the kernel and some as modules.  Keith Owens could comment on
that.  The new code avoids this problem as well.

> >                                           ...  New drivers are much
> > easier to write as well, which is a nice side-effect.
> 
> That I can believe

Pity that no new drivers have been written to prove this...

-- Gareth
