Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265080AbUFGVqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUFGVqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUFGVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:46:19 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:31162 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265080AbUFGVqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:46:03 -0400
From: "Thomas Gleixner" <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
Organization: linutronix
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2.4] jffs2 aligment problems
Date: Mon, 7 Jun 2004 23:40:30 +0200
User-Agent: KMail/1.5.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
References: <40C484F9.20504@timesys.com> <200406072256.46952.tglx@linutronix.de> <1086643763.29255.63.camel@localhost.localdomain>
In-Reply-To: <1086643763.29255.63.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406072340.30674.tglx@linutronix.de>
X-Seen: false
X-ID: SUFT--ZBZeOehcIgaAeQC+cRUD0FPfx890MoAaxnP43HLm2apFQlwp@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 June 2004 23:29, David Woodhouse wrote:
> On Mon, 2004-06-07 at 22:56 +0200, Thomas Gleixner wrote:
> > So we did not care if it took ms + x µs due to an alignement trap
>
> Indeed. But since many machines I care about can't fix up unaligned
> accesses I'm _more_ than happy to obey the original decree that I should
> put back the get_unaligned() calls; just ignoring the stated reasons.
> Let's not argue Linus out of it :)

I do not argue. I just stated why nobody took care of it. 

Cite from old mail's:
> Yes.  Enable the alignment abort handler.  In later kernels, its a
> fundamental requirement that the alignment abort handler is enabled
> before you'll even get to see the jffs2 or MTD options.

>> Checking this before the unaligned access would be faster <SNIP>
> It's handled by the alignment abort handler already.

-- 
Thomas
________________________________________________________________________
Steve Ballmer quotes the statistic that IT pros spend 70 percent of their 
time managing existing systems. That couldn’t have anything to do with 
the fact that 99 percent of these systems run Windows, could it?
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

