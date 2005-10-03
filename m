Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVJCQU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVJCQU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJCQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:20:29 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:44172 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751079AbVJCQU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:20:28 -0400
Date: Mon, 3 Oct 2005 12:20:27 -0400
To: Grant Coady <grant_lkml@dodo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051003162027.GF7949@csclub.uwaterloo.ca>
References: <20050927111038.GA22172@ime.usp.br> <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com> <20050927140434.GL28578@csclub.uwaterloo.ca> <20051001212806.GD6397@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051001212806.GD6397@ime.usp.br>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 06:28:06PM -0300, Rog?rio Brito wrote:
> Right now, I'm using just a single 512MB module, but it is single-sided
> (I guess that by double-sided you guys mean that it has chips on both
> sides of the module, right?). The only double-sided module that I have
> here is the 256MB module.
> 
> OTOH, with just one 512MB everything *seems* to be working fine, but,
> honestly, I'm not sure.

Well maybe a single sided 512M can still have the same interface as a
double sided.  Depends how it is wired I suppose.

> Hummm, nice to see that you have also experienced this. With 256 + 128,
> I had to use PC100 to have it work stably.
> 
> I'd obviously prefer to have everything working at PC133 speed, but
> wouldn't mind running at PC100 speed if I could use everything, since I
> sometimes need to use some large programs (for some dynamic programming
> problems).

Actually you probably DON'T want the ram to run PC133 since at PC133 the
latency is a bit higher (in clock counts) than at PC100, so overall the
latency stays about the same.  On the other hand running the ram
asynchrounous from the front side bus of the cpu makes getting memory
access aligned more complicated and inserts different delays.  So most
likely the system really runs fastest when the ram matches the cpu bus
speed which on an A7V is 100MHz (since it never did actually support any
133FSB cpus, you needed the fixed KT133A chipset for that that the A7V-E
had on it).  I also only run a 700MHz cpu so heat isn't a problem.  I
know the 1GHz cpu made a lot of heat and really needed good cooling.  I
don't remember what cpu speed you have.

Len Sorensen
