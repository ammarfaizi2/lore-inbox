Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131962AbRBAViy>; Thu, 1 Feb 2001 16:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131943AbRBAViq>; Thu, 1 Feb 2001 16:38:46 -0500
Received: from alex.intersurf.net ([216.115.129.11]:23819 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S131911AbRBAVib>; Thu, 1 Feb 2001 16:38:31 -0500
Message-ID: <XFMail.20010201153828.markorr@intersurf.com>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010129175752.A657@grobbebol.xs4all.nl>
Date: Thu, 01 Feb 2001 15:38:28 -0600 (CST)
Reply-To: Mark Orr <markorr@intersurf.com>
From: Mark Orr <markorr@intersurf.com>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Subject: RE: esp causing crashes..
Cc: miquels@cistron.nl, arobinso@nyx.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29-Jan-2001 Roeland Th. Jansen wrote:
> [mike -- included you for refs only]
> 
> recently I started to dive into a problem that causes 2.2.x and 2.4.x to
> crash at shutdown and when minicom/mgetty is used. e.g. shutdown almost
> always crashed the system; if a fax is received, 3 out of 4 faxes ok,
> but also crashes system.
> 
> I tried to contact the author of the hayes esp also but he seems to be
> pretty busy...
> 
> Initially I thought that killall5, mike's product, somehow caused the
> mentioned crash but diving deeper into it I found that killall5 tries to
> kill mgetty -- and crashes the system. I tried a source version as well.
> same stuff (I use suse 7.0)

I dont like to be the sort of person who, when people report problems,
fires back "it works fine here!"...but...just as a point of reference,
I have a Hayes ESP too -- it's connected to a 56k modem.  I havent
had any crashes or hangs related to it, but I dont use mgetty.  (I use
rungetty, a variant of mingetty,  for VC's).    Seeing this, I will
compile up mgetty here to see if I can replicate it.

(once in a while, communications becomes non-responsive -- but I
suspect that it's just my Zoom modem, which clams up for no apparent
reason.  The port seems to be doing it's thing.)

> the IRQ is 11, not using DMA, IRQ is set to legacy in the BIOS.
> it happens with any 2.2.xx version and also happens with 2.4.0.

I'm running 2.4.0-ac12 here.   ESP is set to 180h, IRQ 3, DMA 3.
(I disabled my onboard serial ports).   CPU is a classic Pentium.
I've been running it w/  rx_timeout=1  (the minimum usable value,
since it seems to give lower ping times)

Got this ESP off eBay -- in fact, I got it after reading Mr. Jansen's
recommendation 2 years ago in the comp.dcom.* groups (probably ISDN),
noting how flexible and tweakable the ESP drivers are.  FWIW, I was
getting mountains of TCP errors before I got this card, and they all
disappeared once I installed the ESP.  It's an amazing card.

--
Mark Orr
markorr@intersurf.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
