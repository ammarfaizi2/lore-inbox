Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVLOSBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVLOSBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVLOSA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:00:59 -0500
Received: from witte.sonytel.be ([80.88.33.193]:43259 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750875AbVLOSA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:00:58 -0500
Date: Thu, 15 Dec 2005 19:00:54 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
In-Reply-To: <20051215175536.GA27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0512151858100.6884@pademelon.sonytel.be>
References: <20051215085516.GU27946@ftp.linux.org.uk>
 <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk>
 <Pine.LNX.4.61.0512151832270.1609@scrub.home> <20051215175536.GA27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, Al Viro wrote:
> On Thu, Dec 15, 2005 at 06:51:40PM +0100, Roman Zippel wrote:
> > On Thu, 15 Dec 2005, Al Viro wrote:
> > > So who should I put as the author?  You or Geert (or whatever attributions
> > > might have been in said big patch)?  Incidentally,  ADBREQ_RAW had leaked
> > > into mainline (sans definition) in 2.3.45-pre2, which was Feb 13 2000, i.e.
> > > more than 1.5 year before your commit, so there's quite a chunk of history
> > > missing...
> > 
> > I'd say Geert, but it probably comes from the Mac tree. Anyway, it 
> > wouldn't be such a bad idea to ask him first why it's in his postponed 
> > queue:

Indeed, usually there's a good reason for being in that state instead of not
being merged ;-)

> > http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/POSTPONED/130-adbraw.diff
> > 
> > My guess it needs some ack from the ppc people.
> 
> It doesn't - behaviour in case when ADBREQ_RAW is not passed in flags had
> been obviously unchanged.  And only m68k passes ADBREQ_RAW in there.
> So no, it doesn't affect ppc at all.

Even if behavior is unchanged, this doesn't mean that people like their code
being modified behind their back...

Anyway, last time I tried to bring this up with the union of Mac and PowerMac
guys, no one seemed to remember why ADBREQ_RAW was really needed...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
