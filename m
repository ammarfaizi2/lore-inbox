Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274824AbTHPQNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274820AbTHPQNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:13:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45186 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S274804AbTHPQNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:13:42 -0400
Date: Sat, 16 Aug 2003 17:12:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: rob@landley.net, george@mvista.com, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org
Subject: Re: APM and 2.5.75 not resuming properly
Message-ID: <20030816161213.GA24293@mail.jlokier.co.uk>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200308132024.36967.rob@landley.net> <3F3B41C7.1000906@mvista.com> <200308160510.44627.rob@landley.net> <20030816142933.GE23646@mail.jlokier.co.uk> <20030817010320.0668d246.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817010320.0668d246.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> On Sat, 16 Aug 2003 15:29:33 +0100 Jamie Lokier <jamie@shareable.org> wrote:
> > Rob Landley wrote:
> > > (APM suspends, and then never comes back until you yank the #*%(&#
> > > battery.  Great.  Trying it with the real mode bios calls next
> > > reboot...)
> > 
> > Similar here.  Using 2.5.75.  APM with no local APIC (kernel is unable
> > to enable it anyway).
> > 
> > It suspends.  On resume, the screen is blank and the keyboard doesn't
> > respond (no Caps Lock or SysRq).  Occasionally when it resumes the
> > keyboard does respond, but the screen stays blank.  At least it is
> > possible to do SysRq-S SysRq-B in this state.  Sometimes, if I'm
> > lucky, I can make it reboot by holding down the power key for 5 seconds.
> 
> I may have missed somthing, but let me ask anyway: What laptop? Have you
> tried switching to a text console before suspending?  Have you tried
> 	Options "NoPM" "True"
> in the ServerFlags section of your XF86Config?

Toshiba Satellite 4070CDT.  APM has worked without any problems, in
2.4 and earlier kernels, both Red Hat kernels and vanilla ones.

I'm not using X :)

I am using vesafb, as my text console.  Same with 2.4.

I've just noticed a notable change: the Toshiba SMM driver.  That is
now configured in, whereas before it was a module and I never loaded
it.  Although I don't use it, when it initialises it does some funky
SMM stuff - might that be breaking resume?

-- Jamie
