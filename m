Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268795AbTCCUtz>; Mon, 3 Mar 2003 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268796AbTCCUtz>; Mon, 3 Mar 2003 15:49:55 -0500
Received: from mail.mediaways.net ([193.189.224.113]:48090 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268795AbTCCUty>; Mon, 3 Mar 2003 15:49:54 -0500
Subject: re: Linux 2.4.21pre4-ac5 status report
From: Soeren Sonnenburg <kernel@nn7.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Edward King <edk@cendatsys.com>, Mikael Pettersson <mikpe@user.it.uu.se>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030303195750.GI6946@louise.pinerecords.com>
References: <200303011252.h21CqBpl013357@harpo.it.uu.se>
	 <1046523858.26074.7.camel@sun> <3E63B227.8030101@cendatsys.com>
	 <20030303195750.GI6946@louise.pinerecords.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046725013.1743.96.camel@fortknox>
Mime-Version: 1.0
Date: 03 Mar 2003 21:56:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 20:57, Tomas Szepe wrote:
> > [edk@cendatsys.com]
> > 
> > >>Maybe that's changed in 2.4.21-pre-ac new IDE code, I don't know.
> > >>
> > >>Your cards don't share interrupts with anything else I hope?
> > >>
> > I tried  two pdc20268's which failed miserably
> > 
> > Used an Asus motherboard and an FIC motherboard, different cables, 
> > different cards, different powersupply.Hard drives are 200GB western 
> > digitals, one drive per channel.  
> > 
> > Tried an SIIG card with the SiI680 chipset -- same problem using is and 
> > the pdc20268, but is more stable than a single pdc -- so now I have 4 
> > drives on that card.
> > 
> > My kernel is 2.4.21-pre4-ac6 -- let me know if the pre5's solve the problem.
> 
> I'd be quite interested to know whether the FreeBSD IDE driver can handle
> these setups properly.

Me too... I would not think so, but who know.

However at least the freeze was reproducable here. Just take two
pdc20268 controller, attach one driver per channel, setup a raid5, let
it build up the raid. Then start bonnie and you will get a freeze within
15min when using something higher than mdma0.

The system now is really rock stable with these htp370 based
dawicontrol-100 cards (which are in the same slots as the pdcs were).

Soeren.

