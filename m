Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267488AbUHJRoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbUHJRoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267544AbUHJRoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:44:00 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:20882 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267488AbUHJRjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:39:48 -0400
Date: Tue, 10 Aug 2004 18:37:56 +0100
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810173756.GB22928@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	Florian Schmidt <mista.tapas@gmx.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <20040810085849.GC26081@elte.hu> <1092157841.3290.3.camel@mindpipe> <1092155147.16979.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092155147.16979.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 05:25:48PM +0100, Alan Cox wrote:
 > On Maw, 2004-08-10 at 18:10, Lee Revell wrote:
 > > OK, with CONFIG_M586TSC, I am getting a lot of lockups.  A few happened
 > > during normal desktop use, and it locks up hard when starting jackd. 
 > > Could this have anything to do with the ALSA drivers (which I am
 > > compiling seperately from ALSA cvs) detecting my build system as i686? 
 > > I have read that the C3 is more like a 486 (with MMX & 3DNow) than a
 > > 686.
 > 
 > The C3 is a full 686 instruction set. The kernel is different because
 > the GNU tool people couldn't read manuals and once the error was made 
 > it was a bit too late to fix it.
 > 
 > Thus ALSA deciding its 686 is fine.

Depends which C3.  If OP's C3 lacks cmov, it definitly is not ok.
Any cmov ending up in that module will blow up.

		Dave

