Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbTBPWSb>; Sun, 16 Feb 2003 17:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTBPWSa>; Sun, 16 Feb 2003 17:18:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18436 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267750AbTBPWS2>; Sun, 16 Feb 2003 17:18:28 -0500
Date: Sun, 16 Feb 2003 22:28:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Signal/gdb oddity in 2.5.61
Message-ID: <20030216222824.G12489@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030216191543.D12489@flint.arm.linux.org.uk> <20030216221023.GA6806@nevyn.them.org> <20030216221454.F12489@flint.arm.linux.org.uk> <20030216222104.GA7319@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030216222104.GA7319@nevyn.them.org>; from dan@debian.org on Sun, Feb 16, 2003 at 05:21:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 05:21:04PM -0500, Daniel Jacobowitz wrote:
> On Sun, Feb 16, 2003 at 10:14:54PM +0000, Russell King wrote:
> > On Sun, Feb 16, 2003 at 05:10:23PM -0500, Daniel Jacobowitz wrote:
> > > This is a consequence of ARM's separate get_signal_to_deliver. 
> > >
> > > Roland's changes for group stops require code in get_signal_to_deliver,
> > > so if you aren't using the common version, you're out of luck.
> > > 
> > > I think you'll have to either update yours to match, or use the new
> > > hooks David Miller added to use the common get_signal_to_deliver.
> > 
> > This is using the common version in 2.5.61.
> > 
> > You might want to completely review your reply in light of this.
> 
> Just checking - do you mean "with a change to 2.5.61 for ARM to use the
> common version"?  The copy of 2.5.61 I'm staring at right now has:
> 
> include/asm-arm/signal.h:#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER

If Linus pulls my BK tree, then Linus will also have the code.
If you also look at the backtraces I provided, you will also notice
that the functions concerned *are* the generic ones in kernel/signal.c

This /is/ using the generic get_signal_to_deliver() from kernel/signal.c
in Linus' released 2.5.61 kernel tree.

If you don't believe me, please try to reproduce it in an x86 2.5.61
box and report the results.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

