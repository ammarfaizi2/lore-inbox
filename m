Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbTBPWLK>; Sun, 16 Feb 2003 17:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbTBPWLJ>; Sun, 16 Feb 2003 17:11:09 -0500
Received: from crack.them.org ([65.125.64.184]:37820 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267662AbTBPWLH>;
	Sun, 16 Feb 2003 17:11:07 -0500
Date: Sun, 16 Feb 2003 17:21:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Signal/gdb oddity in 2.5.61
Message-ID: <20030216222104.GA7319@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030216191543.D12489@flint.arm.linux.org.uk> <20030216221023.GA6806@nevyn.them.org> <20030216221454.F12489@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216221454.F12489@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 10:14:54PM +0000, Russell King wrote:
> On Sun, Feb 16, 2003 at 05:10:23PM -0500, Daniel Jacobowitz wrote:
> > This is a consequence of ARM's separate get_signal_to_deliver. 
> >
> > Roland's changes for group stops require code in get_signal_to_deliver,
> > so if you aren't using the common version, you're out of luck.
> > 
> > I think you'll have to either update yours to match, or use the new
> > hooks David Miller added to use the common get_signal_to_deliver.
> 
> This is using the common version in 2.5.61.
> 
> You might want to completely review your reply in light of this.

Just checking - do you mean "with a change to 2.5.61 for ARM to use the
common version"?  The copy of 2.5.61 I'm staring at right now has:

include/asm-arm/signal.h:#define HAVE_ARCH_GET_SIGNAL_TO_DELIVER

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
