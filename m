Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbTIOWIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTIOWII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:08:08 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:32700 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261657AbTIOWIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:08:05 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "David S. Miller" <davem@redhat.com>, mroos@linux.ee,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>
In-Reply-To: <Pine.LNX.4.44.0309152320130.24675-100000@deadlock.et.tudelft.nl>
References: <Pine.LNX.4.44.0309152320130.24675-100000@deadlock.et.tudelft.nl>
Message-Id: <1063663632.585.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 16 Sep 2003 00:07:12 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-15 at 23:24, Daniël Mantione wrote:
> On Mon, 15 Sep 2003, Marcelo Tosatti wrote:
> 
> > Ben reported it breaks PPC, too...
> 
> The patch was tested on ppc, it is propably not PowerPC specific.
> 
> Benjamin, on what kind of machine did things break? Can you provide some
> info?

I reported that I got user reports of breakage... so far, I don't know
more as I only have one mach64 machine that I couldn't test on yet.

At least, iBook1 is broken (M1 chipset) from what Olaf says (in CC
list).

There are a few PPC machines for which atyfb is "critical":

 - PowerBook Wallstreet I (Rage LT-G, that one I can test)
 - PowerBook Wallstreet II (Rage LT-Pro I think)
 - PowerBook 101 (aka Lombard) (Rage LT-Pro)
 - iBook1 (Rage M1)
 - iMac rev A,B and C (not sure which chip, LT-Pro or just 3D Pro)
 - Beige G3 (older XL iirc)
 
Along with some older "performa" I forgot about (5400 I think).

The current driver works at least well enough to get a console on all
of these. I'm not sure a stable serie should get a new driver if it
has not been properly validated on these. Unfortunately, I don't have
access to all of this HW to test with, so...

Why don't you push it to 2.6 first then backport to 2.4 ? That would
be better imho...

Ben.
 

Ben.


