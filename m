Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVEOJn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVEOJn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVEOJn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:43:58 -0400
Received: from colin.muc.de ([193.149.48.1]:46852 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261594AbVEOJnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:43:53 -0400
Date: 15 May 2005 11:43:52 +0200
Date: Sun, 15 May 2005 11:43:52 +0200
From: Andi Kleen <ak@muc.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: "Richard F. Rebel" <rrebel@whenu.com>, Gabor MICSKO <gmicsko@szintezis.hu>,
       linux-kernel@vger.kernel.org, mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515094352.GB68736@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513212620.GA12522@hexapodia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 02:26:20PM -0700, Andy Isaacson wrote:
> On Fri, May 13, 2005 at 09:05:49PM +0200, Andi Kleen wrote:
> > On Fri, May 13, 2005 at 02:38:03PM -0400, Richard F. Rebel wrote:
> > > Why?  It's certainly reasonable to disable it for the time being and
> > > even prudent to do so.
> > 
> > No, i strongly disagree on that. The reasonable thing to do is
> > to fix the crypto code which has this vulnerability, not break
> > a useful performance enhancement for everybody else.
> 
> Pardon me for saying so, but that's bullshit.  You're asking the crypto
> guys to give up a 5x performance gain (that's my wild guess) by giving
> up all their data-dependent algorithms and contorting their code wildly,
> to avoid a microarchitectural problem with Intel's HT implementation.

And what you're doing is to ask all the non crypto guys to give
up an useful optimization just to fix a problem in the crypto guy's
code. The cache line information leak is just a information leak
bug in the crypto code, not a general problem.

There is much more non crypto code than crypto code around - you
are proposing to screw the majority of codes to solve a relatively
obscure problem of only a few functions, which seems like the totally
wrong approach to me.

BTW the crypto guys are always free to check for hyperthreading
themselves and use different functions.  However there is a catch
there - the modern dual core processors which actually have
separated L1 and L2 caches set these too to stay compatible
with old code and license managers.

-Andi
