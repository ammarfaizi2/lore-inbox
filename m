Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264969AbUFGSAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbUFGSAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbUFGSAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:00:39 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:61108 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S264965AbUFGR7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:59:35 -0400
Date: Mon, 7 Jun 2004 19:59:33 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matrox Kconfig
Message-ID: <20040607175933.GA10578@k3.hellgate.ch>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	linux-kernel@vger.kernel.org
References: <8A46A014187@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A46A014187@vcnet.vc.cvut.cz>
X-Operating-System: Linux 2.6.7-rc1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2004 19:43:56 +0200, Petr Vandrovec wrote:
> On  5 Jun 04 at 13:40, Roger Luethi wrote:
> > The descriptions for CONFIG_FB_MATROX_G450 and CONFIG_FB_MATROX_G100A
> > in drivers/video/Kconfig (current 2.6) are confusing: Both want to be
> > selected for Matrox G100, G200, G400 based video cards.
> > 
> > In the menu, it's
> > 
> > # G100/G200/G400/G450/G550 support (sets FB_MATROX_G100, FB_MATROX_G450)
> > #   G100/G200/G400 support     (sets FB_MATROX_G100)
> > #   G400 second head support
> > 
> > where the second depends on the first _not_ being selected.
> > 
> > How about this instead?
> > 
> > # Gxxx (generic) (sets FB_MATROX_G100)
> > #   G400 second head (depends FB_MATROX_GXXX, FB_MATROX_I2C)
> >              (sets FB_MATROX_G450)
> > #   G450/550 support (depends on FB_MATROX_GXXX)
> 
> Please no. It was this way in 2.4.x, and I was receiving at least
> two complaints a week that their G450 does not work with their
> system.
> 
> G400's second head has nothing to do with G450/G550, so there is
> no reason why G400 second head should set FB_MATROX_G450...

Sorry, typo. Should have been:

# Gxxx (generic) (sets FB_MATROX_G100)
#   G400 second head (depends FB_MATROX_GXXX, FB_MATROX_I2C)
#            (sets FB_MATROX_MAVEN)
#   G450/550 support (depends on FB_MATROX_GXXX)
#            (sets FB_MATROX_G450)

> If anything, then let's remove G100/G200/G400 choice completely,
> making G450/G550 support unconditional.

That's fine with me, too. As far as I am concerned, you can throw the
whole Matrox G??? bunch together :-). It's just the current presentation
that is confusing.

Roger
