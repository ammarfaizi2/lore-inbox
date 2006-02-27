Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWB0MID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWB0MID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWB0MID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:08:03 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:11662 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751295AbWB0MIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:08:00 -0500
Date: Mon, 27 Feb 2006 13:07:29 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-ID: <20060227120729.GC7863@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <20060225214704.GN13116@waste.org> <20060225215850.GD15276@flint.arm.linux.org.uk> <20060225223737.GO13116@waste.org> <20060225225748.GF15276@flint.arm.linux.org.uk> <20060227011844.GA7218@linuxtv.org> <20060227083232.GA21994@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227083232.GA21994@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.207.47
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006, Russell King wrote:
> On Mon, Feb 27, 2006 at 02:18:44AM +0100, Johannes Stezenbach wrote:
> > On Sat, Feb 25, 2006 at 10:57:49PM +0000, Russell King wrote:
> > > The email:
> > > 
> > >   http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html
> > > 
> > > contains a full and clear explaination of the situation.  The second
> > > paragraph of that email is key to understanding the problem and makes
> > > it absolutely clear what is trying to be decompressed as the initrd
> > > (the corrupted compressed piggy).
> > 
> > FWIW, I didn't it either. "Work around broken boot firmware which passes
> > invalid initrd to kernel" would have been a simpler description.
> 
> Sigh, I'm sick of this crap.  I'm not going to debate it any further.
> 
> > I agree that it would be nice if inflate.c would fail gracefully
> > instead of halting,
> 
> IT _DOES_ FAIL GRACEFULLY TODAY.  WITH MATT'S PATCHES, IT _DOESN'T_.
> THAT'S A REGRESSION.  WHAT IS IT ABOUT THAT WHICH PEOPLE DON'T
> UNDERSTAND?  DO I HAVE TO SPELL IT OUT IN ONE SYLLABLE WORDS?

I got that already, no need to shout. I just wanted to point
out that from the information you provided so far it
looks like your problem could be fixed in a more straight
forward fashion.

Problem:  Boot firmware passes invalid arguments.
Solution: Ignore invalid boot firmware arguments.

> > but why can't you just use CONFIG_BLK_DEV_INITRD=n?
> 
> Because you might want to use an initrd for real (for installation
> purposes) and therefore distributions (eg Debian) want it turned on?

If you use a distribution kernel which contains one, you
could simply add "noinitrd" to the kernel command line
to ignore it, no?

> Okay, this does it - I'm ignoring further discussion on this stupid
> idiotic topic which is soo bloody difficult for others to understand.

I don't understand your aggressiveness, there must be a dark
secret behind all this. Or maybe it's just the season
for flame wars.


I'm sorry to have bothered you,
Johannes
