Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbTEMFfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTEMFfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:35:14 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:11925 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262933AbTEMFfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:35:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org,
       Torrey Hoffman <thoffman@arnor.net>
Subject: Re: [2.420] Unexplained repeatable Oops
Date: Tue, 13 May 2003 15:49:58 +1000
User-Agent: KMail/1.5.1
References: <200305112052.51938.devilkin-lkml@blindguardian.org> <200305120739.30154.kernel@kolivas.org> <200305130740.45250.devilkin-lkml@blindguardian.org>
In-Reply-To: <200305130740.45250.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305131549.13371.kernel@kolivas.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003 15:40, DevilKin wrote:
> On Sunday 11 May 2003 23:39, Con Kolivas wrote:
> > On Mon, 12 May 2003 04:52, DevilKin-LKML wrote:
> > > On my main machine at home I have encountered since this morning an
> > > Oops that never happened before. It happened when I was playing a game
> > > of Diablo II through Winex (yes, with the Nvidia modules loaded and
> > > stuff loaded from VMWare). This oops I didn't bother to capture, since
> > > I know that oops'es from a tainted kernel are not accepted.
> > > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
> > > South] (rev 40) Subsystem: ABIT Computer Corp.: Unknown device a702
> > >         Flags: bus master, stepping, medium devsel, latency 0
> > >         Capabilities: [c0] Power Management version 2
> >
> > Good old VIA chipset. I solved a similar problem by underclocking a cpu
> > on a similar chipset :-(
> >
> > Try the mprime client stress test to ensure your hardware is ok.
> > www.mersenne.org
>
> I wasn't able to get this thing working, so I tried cpuburn and seti@home
> instead. Both ran my cpu up to around 70 degrees C, and everything was
> still working perfectly.
>
> All fans were spinning nicely along, including the vidcard fan.
>
> After this, I let things cool down, ran winex+diablo2 and the system
> crashed in under 20 minutes.
>
> To make sure it wasn't hardware related I ran 3dMark 2003 under windows and
> well... it resulted in a blue screen after 10 minutes of running this quite
> intensive test. So I suppose something is wrong with my AGP card.
>
> Strange thing is that I actually get crashes, and not video problems as I
> would expect...
>
> I've already tried turning of AGP Fast Writes, and have tuned down the AGP
> write speed from 4x to 2x (lowest I can put it).
>
> Any other ideas?

mprime will pick up more subtle things than cpuburn will. It's not purely a 
temperature of the cpu issue. It may be the bus.
Try underclocking your bus/cpu. I run a P3 933 (133x7) at 868 (124x7) and all 
problems go away. The same cpu works fine overclocked on a different 
motherboard.

Con
