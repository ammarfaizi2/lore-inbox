Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbTGJBux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268736AbTGJBux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:50:53 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:65157 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S268711AbTGJBuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:50:52 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16140.51447.73888.717087@wombat.chubb.wattle.id.au>
Date: Thu, 10 Jul 2003 12:01:27 +1000
To: Daniel Phillips <phillips@arcor.de>
Cc: Jamie Lokier <jamie@shareable.org>,
       Davide Libenzi <davidel@xmailserver.org>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307100059.57398.phillips@arcor.de>
References: <20030703023714.55d13934.akpm@osdl.org>
	<200307082027.13857.phillips@arcor.de>
	<20030709222426.GA24923@mail.jlokier.co.uk>
	<200307100059.57398.phillips@arcor.de>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Phillips <phillips@arcor.de> writes:


Daniel> I like your idea of allowing normal users to set SCHED_RR, but
Daniel> automatically placing some bound on cpu usage.  It's
Daniel> guaranteed not to break any existing programs.

I suspect that what's really wanted here is not SCHED_RR but
guaranteed rate-of-forward progress.  A dynamic-window-constrained
scheduler (that guarantees not that you'll run until you sleep, but
that in any (settable) time period you'll get the opportunity to run
for at least (a smaller settable period)) is closer to what's wanted.

See http://www.cs.bu.edu/fac/richwest/dwcs.html

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
