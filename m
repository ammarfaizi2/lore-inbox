Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315401AbSEGJMD>; Tue, 7 May 2002 05:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315405AbSEGJMC>; Tue, 7 May 2002 05:12:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44046 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315401AbSEGJMB>;
	Tue, 7 May 2002 05:12:01 -0400
Message-ID: <3CD79AFA.F3B11E95@zip.com.au>
Date: Tue, 07 May 2002 02:14:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kees Bakker <kees.bakker@altium.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x: LK1.1.17 gives No MII transceivers found
In-Reply-To: <3CD78BDC.B6ED1BA5@zip.com.au> <15575.38538.231057.425097@koli.tasking.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Bakker wrote:
> 
> >>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:
> 
> Andrew> Kees Bakker wrote:
> >>
> >> In 2.5.8 there was an update of the 3c59x driver. I have two NICs,
> >> both use this driver, a 3c900 Boomerang and a 3c905C Tornado.
> >>
> >> Linux 2.4.17 and 2.5.7 both report
> >> 00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.16
> >> 00:09.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.16
> >>
> >> However, the new driver produces:
> >> 00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.17
> >> phy=0, phyx=24, mii_status=0xffff
> >> phy=1, phyx=0, mii_status=0xffff
> 
> Andrew> It's just random debug code.
> 
> Is that also true for the "***WARNING*** No MII transceivers found!"
> message?

Not really.  The driver shouldn't have gone looking for MII
transceivers for a 3c900.

I'll take a look, see if I can remember how the darn driver
works.  3c59x is very much in "it works, don't futz with it" mode...

> Andrew> Does the 3c900 actually work correctly?
> 
> I can't tell, because since it hangs at boot. That is, every kernel after
> 2.5.7 that I could build, including 2.5.13. (I'm having those hda: lost
> interrupt messages).

Ouch.  So 2.5.7 worked OK?  What sort of controller and disks do
you have?

-
