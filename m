Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319233AbSHNHEs>; Wed, 14 Aug 2002 03:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSHNHEs>; Wed, 14 Aug 2002 03:04:48 -0400
Received: from jabberwock.ucw.cz ([212.71.128.53]:7438 "HELO jabberwock.ucw.cz")
	by vger.kernel.org with SMTP id <S319233AbSHNHEr>;
	Wed, 14 Aug 2002 03:04:47 -0400
Date: Wed, 14 Aug 2002 09:08:37 +0200
From: Martin Mares <mj@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
Message-ID: <20020814090837.A28439@ucw.cz>
References: <Pine.LNX.4.44.0208131013060.7411-100000@home.transmeta.com> <2011880000.1029268652@flay> <1029269633.22847.92.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1029269633.22847.92.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Aug 13, 2002 at 09:13:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It wants to force its own conf1/conf2 over the BIOS even if BIOS is
> preferred because some BIOSes dont honour the size requested and the
> hardware has bugs.
> 
> That to me says there may well be cleaner approaches.

I haven't looked at the current source yet, but the PCI access code
used to work this way: if both BIOS and direct access were enabled
(which was the default) and both worked, BIOS was used only for getting
information about interrupt routing and last bus number and direct
access for everything else. Hence the problematic BIOS calls were used
only if there were no other possibility or the user explicitly told
us to.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
No fortune, no luck, no sig!
