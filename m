Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSEHRHQ>; Wed, 8 May 2002 13:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314681AbSEHRHP>; Wed, 8 May 2002 13:07:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59403 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314514AbSEHRHN>; Wed, 8 May 2002 13:07:13 -0400
Date: Wed, 8 May 2002 18:07:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Patrick Mochel <mochel@osdl.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508180705.B18698@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205071245370.4189-100000@hawkeye.luckynet.adm> <Pine.LNX.4.33.0205071238000.6307-100000@segfault.osdl.org> <200205072203.g47M3o002102@vindaloo.ras.ucalgary.ca> <20020508091442.A16868@flint.arm.linux.org.uk> <200205081607.g48G7in11351@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 10:07:44AM -0600, Richard Gooch wrote:
> Russell King writes:
> > Really?  What about the case of the missing BKL for device opens that
> > you haven't really commented on?
> 
> I did comment to you, privately, saying I was waiting to see what the
> consensus was on the issue of whether to move the BKL or not. I'll be
> sending a patch later this week to fix it.

Yes, and hey, we still have the problem a week layer, even after the
discussion went dead.

> > Seems like devfs _still_ has locking problems.
> 
> A pretty minor one, given the comment I was responding to: "devfs is
> unfixable". I've noticed that even Al has gone quiet on the "devfs
> races" issue, now that the new code is in place :-)

Never the less, your comment about "no locking problems" is inaccurate.
devfs is calling at least one part of the kernel without obeying the
existing locking rules.  That's definitely a devfs bug.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

