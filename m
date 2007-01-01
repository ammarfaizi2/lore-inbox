Return-Path: <linux-kernel-owner+w=401wt.eu-S1751632AbXAAIba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbXAAIba (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755178AbXAAIba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:31:30 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48016 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbXAAIb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:31:29 -0500
X-Originating-Ip: 74.109.98.100
Date: Mon, 1 Jan 2007 03:26:02 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: Muli Ben-Yehuda <muli@il.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
In-Reply-To: <66cc662565c489fa9e604073ced64889@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0701010322320.2935@localhost.localdomain>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
 <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
 <66cc662565c489fa9e604073ced64889@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007, Segher Boessenkool wrote:

> > > In this case, the second form
> > > should be used when the macro needs to return a value (and you can't
> > > use an inline function for whatever reason), whereas the first form
> > > should be used at all other times.
> >
> > that's a fair point, although it's certainly not the coding style
> > that's in play now.  for example,
> >
> >   #define setcc(cc) ({ \
> >     partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
> >     partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
>
> This _does_ return a value though, bad example.

sigh ... you're right.  here's a thought.  my original patch
submission simply added an explanation for allowing the ({ }) notation
for defining a multi-line macro, without getting into recommending an
actual coding style.  at a minimum, something like that should be
added to the style document.

if someone wants to extend that explanation recommending *when* each
of those two styles should be used, feel free.  but a simple
decription of alternatives should *at least* be added, no?

rday
