Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289986AbSAWTTP>; Wed, 23 Jan 2002 14:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289978AbSAWTTE>; Wed, 23 Jan 2002 14:19:04 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:59610 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S289977AbSAWTSt>; Wed, 23 Jan 2002 14:18:49 -0500
Date: Wed, 23 Jan 2002 20:18:38 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Timothy Covell <timothy.covell@ashavan.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Dave Jones <davej@suse.de>,
        Andreas Jaeger <aj@suse.de>, Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011800844.21246.10.camel@psuedomode>
Message-ID: <Pine.LNX.4.40.0201231951360.2202-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2002, Ed Sweetman wrote:

> What's the official word on the resulting stress on the hardware from
> disconnecting and connecting rapidly like that?   Has any test ever been
> carried out to see if it causes damage after say, a couple months of
> use?  ...in other operating systems that had this already of course.
> always something not so safe sounding about turning the cpu on and off
> rapidly added to the greater temperature extremes.   Also, can you
> relink your patch?

i don't know whether there is a official word on the resulting stress. as
far as i heared, there are some stability problems known on some boards
(but i only heared this problems of people with an sis735 based
motherboard like the eltiegroup k7s5a ... but this is not so importend,
cause the sis735 is not supported by my patch ...)
it looks like some "poor" power supplays could not handle well the
changing current draw between the idle and the load states. BUT ... i
realy only heared this problems from one person with an elitegroup k7s5a
board !
cause i know that there maybee computers who have a problem with the
patch, you have to enter "amd_disconnect=yes" at the kernel-boot-prompt
(or in the append statement in /etc/lilo.conf). so it is easy to test the
funktion and to "not use it" when you have problems whith it...
at the university we have several computers running with the lvcool patch
which has a compareable functionality (but only supports kt133/kx133 based
board). they mostly have durons and working like a charm for several
month.
i have nothing heared about problems caused from "temperature-stress".
personally i don't think that this is a problem ....

i put the patch on the web ...
here is the url:
http://cip.uni-trier.de/nofftz/amd_cool.diff
it is a diff from the 2.4.17 kernel and you have to activate acpi, and
acpi-prozessor in the kernel-config to get benefit from the patch.

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

