Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273027AbTHRT10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274964AbTHRT1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:27:25 -0400
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([66.93.172.17]:34956
	"EHLO nevyn.them.org") by vger.kernel.org with ESMTP
	id S273027AbTHRT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:27:18 -0400
Date: Mon, 18 Aug 2003 15:27:09 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030818192709.GA25121@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030814130810.A332@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:19:17AM -0700, Linus Torvalds wrote:
> 
> On Thu, 14 Aug 2003, Russell King wrote:
> > 
> > After reviewing the /proc/kcore and kclist issues, I've decided that I'm
> > no longer prepared to even _think_ about supporting /proc/kcore on ARM -
> 
> I suspect we should just remove it altogether.
> 
> Does anybody actually _use_ /proc/kcore? It was one of those "cool 
> feature" things, but I certainly haven't ever used it myself except for 
> testing, and it's historically often been broken after various kernel 
> infrastructure updates, and people haven't complained..
> 
> Comments?

Speaking only for me, and all that.

I use it.  It's actually pretty handy sometimes, because it lets me
peek at task structures et cetera from userspace; so when I have a
problem with the kernel accessing the wrong memory, I can go figure out
what it's actually looking at.

This is a sort of poor-man's-kgdb.  I don't think there's much need for
/proc/kcore if you have a working kgdb, which I'd still like to see
cleaned up and integrated.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
