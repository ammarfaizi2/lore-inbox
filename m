Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbUKSXTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUKSXTz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUKSXSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:18:30 -0500
Received: from lilah.hetzel.org ([199.250.128.2]:61912 "EHLO lilah.hetzel.org")
	by vger.kernel.org with ESMTP id S261680AbUKSXQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:16:50 -0500
Date: Fri, 19 Nov 2004 19:37:54 -0500
From: Dorn Hetzel <kernel@dorn.hetzel.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Dorn Hetzel <kernel@dorn.hetzel.org>, linux-kernel@vger.kernel.org,
       netdev@oss.cgi.com.hetzel.org, jgarzik@pobox.com
Subject: Re: r8169.c
Message-ID: <20041120003754.GA32133@lilah.hetzel.org>
References: <20041119162920.GA26836@lilah.hetzel.org> <20041119201203.GA13522@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119201203.GA13522@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 09:12:03PM +0100, Francois Romieu wrote:
> Dorn Hetzel <kernel@dorn.hetzel.org> :
> [Abit AA8 experience]
> 
> Do something else:
> - take a look at the changes for the 8169 driver in Jeff Garzik's -netdev
>   patchkit (included in -mm). It may be interesting to know how it behaves;

Thank you very much for the pointers.  I have been using Linux for
ages (well, since 1993 anyway), but this is my first attempt at fixing
something in the kernel.  (first time I've needed to :) )

I'm off to look for and try the -mm patchkit after I write this?
Will it apply to 2.6.10-rc2?  (I had to get to rc2 to get my SATA controller
 to work) :)

> - less +/8169 MAINTAINERS;
> - provide a more elaborate description of the issue with your computer
>   (+ gcc version, lspci -vx, dmesg at boot, lsmod, /proc/interrupts, ifconfig);

with regard to the "original" version shipping with 2.6.10-rc2
(which seems to be identical to the version in 2.6.9)...

gcc version = 2.95.4  (happy to update that if you think it will help)

see   http://www.hetzel.org/8169/orig/lspci.txt   for the lspci -vx
see   http://www.hetzel.org/8169/orig/dmesg.txt   for the dmesg

lsmod returns empty because though I have module support enabled, I'm
building everything I'm using in directly...

see   http://www.hetzel.org/8169/orig/interrupts.txt   for the /proc/interrupts
see   http://www.hetzel.org/8169/orig/ifconfig.txt   for the ifconfig -a

"NETDEV WATCHDOG: eth0: transmit timed out" is one of the observed
errors.  "RX: no buffer available" (or similar, from memory) is another.

with regard to version "2.3" (my hacked version)...

gcc version = 2.95.4  (happy to update that if you think it will help)

see   http://www.hetzel.org/8169/v23/lspci.txt   for the lspci -vx
see   http://www.hetzel.org/8169/v23/dmesg.txt   for the dmesg

lsmod returns empty because though I have module support enabled, I'm
building everything I'm using in directly...

see   http://www.hetzel.org/8169/v23/interrupts.txt   for the /proc/interrupts
see   http://www.hetzel.org/8169/v23/ifconfig.txt   for the ifconfig -a


> - realize that the so called version number in 2.6.9 has no meaning.
>
By this, do you mean that the comment of version number in the r8169.c
of 2.6.9 is no longer related to the version numbers at Realtek?
 
> Last time I looked at Realtek's driver (linux-8169(220).zip), it still
> contained bugs which had been fixed in mainline (though it merges some
> part of it) and I did not find anything which should do a difference
> from a correctness POV. Intermediate versions of Realtek's code are
> not available and the datasheet has disappeared from their website.
> With due respect for Realtek's work (serious, really) it does not make
> my life fun _at all_ (and I guess that "my" is also accurate for anyone
> who tries to work with the 8169 driver on the long run).
>
Yeah, I noticed just one version and no history, but to the good, it
does work for me, at least so far, after the minor patch :)
 
> Btw merging a 20 megaton patch is not the way network drivers changes
> are submitted. People expect a serie of small changes whose effects
> are clearly explained (see http://linux.yyz.us/patch-format.html for
> the suggested format).
>
I was pretty sure the Godzilla patch was not the answer, I just couldn't
figure out what the answer was...  I had fixed *my* problem, for now,
but it would be nice to share it if it's worth sharing...
 
> Imho your issue is not completely specific to the 8169 hardware. With
> a wet finger in the wind, I'd suspect something related to timing or irq
> (duration of locking or such).
> 
> Please Cc: netdev@oss.sgi.com on further messages. Cc: jgarzik@pobox.com
> for network devices patches is also suggested.

Done.

-Dorn

