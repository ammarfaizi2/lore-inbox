Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVCDCEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVCDCEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVCDBoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:44:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:23250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262730AbVCDADg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:03:36 -0500
Date: Thu, 3 Mar 2005 16:03:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: greg@kroah.com, jgarzik@pobox.com, torvalds@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303160330.5db86db7.akpm@osdl.org>
In-Reply-To: <20050303234523.GS8880@opteron.random>
References: <42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<20050303234523.GS8880@opteron.random>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Mar 03, 2005 at 03:17:52PM -0800, Andrew Morton wrote:
> > That's the only way it _can_ work.  The maintainer of 2.6.x.y shouldn't be
> 
> Andrew, what about my suggestion of shifting left x.y of 8 bits? ;) Do
> we risk the magic 2.7 number to get us stuck in unstable mode for 2
> years instead of 2 months? Doesn't 2.6.x.y pose the same risk but
> by also breaking the numbering and the stable kernel identification for
> no good reason? (ignoring the "2.6." part that carries no useful info
> anymore ;)

I think this is all a bit of a storm in a teacup, really.

2.6.x is making good progress but there have been a handful of prominent
regressions which seem to be making people think that the whole process is
bust.  I don't believe that this has been proven yet.

There is still potential to make good improvements to the existing
processes, and the main way of doing this is for the various subsystems to
be a bit more disciplined.  That means:

a) Have all your 2.6.n stuff ready to go when 2.6.n-1 is released.

b) Merge your 2.6.n stuff promptly - within two weeks of the 2.6.n-1 release.

c) Then, keep your sticky paws off it.  New development and
   not-completely-trustworthy development goes into your subsystem tree and
   Linus's tree just gets bugfixes.

That's how it _should_ work, and I'm not sure that we're sufficiently close
to it now.

Or, to put it another way, we're getting a small number of irritating
regressions, mainly in device drivers which is giving the whole thing a bad
rep.  Is there some way in which we can fix that problem without
reinventing the whole world?
