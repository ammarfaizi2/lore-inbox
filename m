Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbUKDWi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUKDWi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUKDWi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:38:29 -0500
Received: from mx.inch.com ([216.223.198.27]:55050 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S262470AbUKDWa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:30:58 -0500
Date: Thu, 4 Nov 2004 17:30:49 -0500 (EST)
From: John McGowan <jmcgowan@inch.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9: i810 video
In-Reply-To: <418AA075.3070303@tmr.com>
Message-ID: <20041104172521.I42459@shell.inch.com>
References: <21d7e99704110314156bb270de@mail.gmail.com><20041102215308.GA3579@localhost.localdomain>
 <20041103234045.G92772@shell.inch.com> <418AA075.3070303@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Bill Davidsen wrote:

> John McGowan wrote:
> > On Thu, 4 Nov 2004, Dave Airlie wrote:
>
> >>What chipset have you got?
> >
> >
> > An HP 7850 - various motherboards used ... this one has an
> > e-machine motherboard. Bios has no controls for the video
> > chip. Does FW82810E sound line the chipset? It is mentioned
> > somewhere in the motherboard doc I found on some site (not HP's
> > so it may or may not be correct).
>
> I think the output of 'lspci' posted here will provide the information.

00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory Controller Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:0d.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)

By the way, the X server runs. There is no problem with that.

If I start it (say, with ICE as a window manager starting up an xterm)
*immediately after boot* I get a clean, black screen. It should be dark
green. I get the frame for the xterm. No xterm. I can right click to get
the menu to display on the screen but it gets locked there. I can right
click again to get a working menu and choose to logout.

If I do something befor starting it, the screen is filled with junk.
Something is writing to the video ram. If I close it and restar it,
different junk.

It seems that the initialization of the i810 is leaving its video ram
free to be grabbed and used.

I saw from the ChangeLog that the 810 initialization code was cleaned up.
It used some strange work around to do something the author thought was
unneccessary and which he cleaned up. It was changed, items reordered,
etc. Might that have something to do with the problem?

Regards from:

    John McGowan  |  jmcgowan@inch.com                [Internet Channel]
                  |  jmcgowan@coin.org                [COIN]
    --------------+-----------------------------------------------------
