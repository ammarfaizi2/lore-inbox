Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318109AbSFTDno>; Wed, 19 Jun 2002 23:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318110AbSFTDnn>; Wed, 19 Jun 2002 23:43:43 -0400
Received: from pcp01314487pcs.hatisb01.ms.comcast.net ([68.63.220.2]:20864
	"EHLO bacchus.jdhouse.org") by vger.kernel.org with ESMTP
	id <S318109AbSFTDnn>; Wed, 19 Jun 2002 23:43:43 -0400
Date: Wed, 19 Jun 2002 22:46:09 -0500 (CDT)
From: "Jonathan A. Davis" <davis@jdhouse.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT266 PCI-related crashes fixed.  Now whats the catch?
In-Reply-To: <200206190509.g5J59bL11170@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0206192214140.2110-100000@bacchus.jdhouse.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Denis Vlasenko wrote:

> 
> Heh... doc says 0x00 and 0x10 are the same for reg 0x76...
> did you test with 0x76 unchanged?
> 

I don't know what 0x76 does exactly, but I can say there is a very real
difference between 0x00 and 0x10 on my system.  Leaving the register
unchanged (0x10) results in system hangs.  They are a little harder to
provoke than running without any changes, but they could still be
triggered under severe disk load.  Clearing that register and the same
tests run to completion (I've done about 5 iterations).  Perhaps this may
be unique to specific board designs or chip steppings.  Clearing 0x76 and
leaving 0x75 with it's initial value results in hangs that trigger just
about as quickly (subjectively) as leaving both registers in their
original state.

Kinda reminds me of the original Tandy 1000 computers.  99.99% compatible
which left you with a 0.01% that would drive you batty.  ;-)

Oh, another data point.  Back when I first put this machine together and
before I discovered ALSA drivers that would actually work properly with
the onboard CMI chip, I dropped an Ensoniq 1371 (SB) card in.  Although
the machine didn't crash, the sound was horrible with clicks, pops, etc.
-- even when no actual sounds were being generated.  As that was about an
hour before the discovery of ALSA and I had heard that some of the
Ensoniq-based cards had PCI issues -- I didn't put much effort into
diagnosing it.

-Jonathan <davis@jdhouse.org>



