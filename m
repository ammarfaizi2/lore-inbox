Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTIIBkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 21:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTIIBkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 21:40:51 -0400
Received: from [212.28.208.94] ([212.28.208.94]:31505 "HELO www.dewire.com")
	by vger.kernel.org with SMTP id S263525AbTIIBkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 21:40:49 -0400
From: Robin Rosenberg <robin.rosenberg@dewire.com>
To: Timothy Miller <miller@techsource.com>,
       David Lang <david.lang@digitalinsight.com>
Subject: Re: Use of AI for process scheduling
Date: Tue, 9 Sep 2003 03:40:31 +0200
User-Agent: KMail/1.5.3
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309081651220.22562-100000@dlang.diginsite.com> <3F5D2007.5030500@techsource.com>
In-Reply-To: <3F5D2007.5030500@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309090340.31735.robin.rosenberg@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tisdag 09 september 2003 02:34 skrev Timothy Miller:
[...]
> The only time it really matters is when the scheduler decision time
> makes something which would APPEAR to be interactive in the compiled
> case appear to be non-interactive in the AI case.  But that is no
> different from using a slower CPU.  There are LOTS of things that will
> feel smoother on a faster CPU.
>
> So, if we can get a good interactive feel out of the AI case, then you
> will only get better results out of the compiled case.  Furthermore,
> good interactive results out of a fast CPU with the AI would imply good
> results out of a slower CPU in the compiled case.
>
> I do realize that the balance is shifted.  The proportion of scheduler
> computation to user computation is thrown off.  (Still, same as using a
> slower CPU.)  But I don't think it matters.  If the scheduler were 100
> times slower, it would still require far far less than timeslice
> granularity to compute!

Change the name. AI has a bad touch, as if things would happen
through magic. A neural is magic to me, but most other AI techniques
are quite predictable.

A rule-based system can be evaluated quite efficiently if the numer of 
rules are reasonable small. A PC can a million of "LIPS" (logical Inferences
per second so you can fit something useful. Say you can afford (on
average one percent of the CPU, that becomes 10000 inferences per
second available per second and with 50 switches pers second that is 2000
inferences per switch. I think can do useful rules with much fewer inferences.
The numbers are guestimates from memory and a few quick googles lookups.

The problem might be efficient collection of useful input to the rules. On the other
hand everything does not have to be recalculated every time the scheduler
makes a decision.

You can split the rules into 1) switching decision making rules 2) strategy selection rules
and 3) environment evaluation rules. The first category of course has to evaluated
every time, while the last set can be a slow process that looks at swapping and I/O
statistics over time withe a recation time on the order of a second. The second is
for simplifying the structure of the rules (might be redundant).

A benefit of a rule based scheduler could be as a good test bed for experimentation.
Changes could be implemented in "real time" (from a user perspective) I.e. you 
change the rule and the  scheduler immediately changes its behaviour. And the scheduler would
be more customizable to the end user or administrator. You could try out
rules for identifying interactive tasks, CPU hogs and tell the scheduler what
/you/ think is importan instead of the one-size-fits-all.

The idea is not bad unless someone proves it. On the other hand its useless
unless manifested in code.

-- robin

