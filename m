Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312374AbSDEIJl>; Fri, 5 Apr 2002 03:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312372AbSDEIJa>; Fri, 5 Apr 2002 03:09:30 -0500
Received: from imag.imag.fr ([129.88.30.1]:54667 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id <S312370AbSDEIJT>;
	Fri, 5 Apr 2002 03:09:19 -0500
Date: Fri, 5 Apr 2002 10:09:15 +0200
From: Pierre Lombard <pierre.lombard@imag.fr>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Mark Cooke <mpc@star.sr.bham.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: time jumps
Message-ID: <20020405080915.GA1220@sci41.imag.fr>
Mail-Followup-To: Bernd Schubert <bernd-schubert@web.de>,
	Mark Cooke <mpc@star.sr.bham.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203271729290.15451-100000@pc24.sr.bham.ac.uk> <200204031132.g33BW5M28288@fubini.pci.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 01:32:05PM +0200, Bernd Schubert wrote:
> after changing from 'CONFIG_X86_TSC=n' to 'CONFIG_X86_TSC=y' the problem 
> still exists, so I'm going to try some other suggestions.

> On Wednesday 27 March 2002 18:33, Mark Cooke wrote:
> > There is a hardware bug on some via 686a systems where the RTC appears
> > automagically change it's programmed value.
> >
> > A patch was originally made against 2.4.2, and some version of this
> > appears to be applied to current kernels (I don't have a vanilla
> > 2.4.17 to check against).  Look in arch/i386/kernel/time.c for mention
> > of 686a.
> >
> > It appears to only be used if the kernel's not compiled with
> > CONFIG_X86_TSC though, so if you have that defined you may not see the
> > problem at all...

The workaround below by Vojtech Pavlik has fixed this issue on my
system (I've a VIA based Abit KT7 and under heavy disk I/O between two
IDE channels the timer goes mad):

  Re: [PATCH] VIA timer fix was removed?
  From: Vojtech Pavlik (vojtech@suse.cz)
  Date: Mon Nov 12 2001 - 16:58:32 EST

  http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/0951.html

If you see the message in your logs then congratulations: you hit (one
of) the VIA bug(s) ;)

--
Best regards,
  Pierre Lombard
