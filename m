Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUB2AlU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 19:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbUB2AlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 19:41:20 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21714 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261958AbUB2AlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 19:41:18 -0500
Subject: Re: [patch] new version, u64 cast avoidance
From: Albert Cahalan <albert@users.sf.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Jakub Jelinek <jakub@redhat.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <1078012762.905.13.camel@gaston>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
	 <1077920213.2233.44.camel@cube>
	 <20040228104252.GG31589@devserv.devel.redhat.com>
	 <1077979564.2233.70.camel@cube>  <1078012722.905.11.camel@gaston>
	 <1078012762.905.13.camel@gaston>
Content-Type: text/plain
Organization: 
Message-Id: <1078006870.2233.94.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Feb 2004 17:21:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 18:59, Benjamin Herrenschmidt wrote:
> On Sun, 2004-02-29 at 10:58, Benjamin Herrenschmidt wrote:
> > >  asm-ppc64/types.h   |   14 ++++++++++++--
> > 
> > Please, do not mess with ppc64 at this point, I'm not sure
> > I like the approach anyway, I can live with some warnings
> > in printk...
> 
> I meant some casts of course ;)

If only those were casts under arch/ppc64, sure.
All 32-bit ports and x86-64 are being affected.
Besides being ugly and verbose, the current situation
isn't type-safe.

I'd be interested to hear why you don't like the
approach, and interested to hear your alternatives.
For example:

a. my solution, as given
b. move u64 and friends to include/linux/*.h
c. you promise to never complain about warnings
d. printk("Ugly: " U64_FMT "\n", some_u64_value);
e. you patch gcc to modify format strings :-)
f. ...

In other words, how do you propose to eliminate
the casts?


