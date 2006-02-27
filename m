Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWB0Icl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWB0Icl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWB0Ick
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:32:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14603 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932245AbWB0Ick (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:32:40 -0500
Date: Mon, 27 Feb 2006 08:32:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Johannes Stezenbach <js@linuxtv.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060227083232.GA21994@flint.arm.linux.org.uk>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <20060225214704.GN13116@waste.org> <20060225215850.GD15276@flint.arm.linux.org.uk> <20060225223737.GO13116@waste.org> <20060225225748.GF15276@flint.arm.linux.org.uk> <20060227011844.GA7218@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227011844.GA7218@linuxtv.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 02:18:44AM +0100, Johannes Stezenbach wrote:
> On Sat, Feb 25, 2006 at 10:57:49PM +0000, Russell King wrote:
> > The email:
> > 
> >   http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html
> > 
> > contains a full and clear explaination of the situation.  The second
> > paragraph of that email is key to understanding the problem and makes
> > it absolutely clear what is trying to be decompressed as the initrd
> > (the corrupted compressed piggy).
> 
> FWIW, I didn't it either. "Work around broken boot firmware which passes
> invalid initrd to kernel" would have been a simpler description.

Sigh, I'm sick of this crap.  I'm not going to debate it any further.

> I agree that it would be nice if inflate.c would fail gracefully
> instead of halting,

IT _DOES_ FAIL GRACEFULLY TODAY.  WITH MATT'S PATCHES, IT _DOESN'T_.
THAT'S A REGRESSION.  WHAT IS IT ABOUT THAT WHICH PEOPLE DON'T
UNDERSTAND?  DO I HAVE TO SPELL IT OUT IN ONE SYLLABLE WORDS?

> but why can't you just use CONFIG_BLK_DEV_INITRD=n?

Because you might want to use an initrd for real (for installation
purposes) and therefore distributions (eg Debian) want it turned on?

Okay, this does it - I'm ignoring further discussion on this stupid
idiotic topic which is soo bloody difficult for others to understand.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
