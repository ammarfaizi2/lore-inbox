Return-Path: <linux-kernel-owner+w=401wt.eu-S1755205AbXAAObT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbXAAObT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 09:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbXAAObT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 09:31:19 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:47888 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbXAAObS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 09:31:18 -0500
X-Originating-Ip: 74.109.98.100
Date: Mon, 1 Jan 2007 09:25:46 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Christoph Hellwig <hch@infradead.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
In-Reply-To: <20070101142020.GA16425@infradead.org>
Message-ID: <Pine.LNX.4.64.0701010921460.7166@localhost.localdomain>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
 <20070101142020.GA16425@infradead.org>
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

On Mon, 1 Jan 2007, Christoph Hellwig wrote:

> On Sun, Dec 31, 2006 at 02:32:25PM -0500, Robert P. J. Day wrote:
> > + (a) Enclose those statements in a do - while block:
> > +
> > +	#define macrofun(a, b, c) 		\
> > +		do {				\
> > +			if (a == 5)		\
> > +				do_this(b, c);	\
> > +		} while (0)
>
> nitpick, please don't add an indentaion level for the do {.  Do this
> should look like:
>
> 	#define macrofun(a, b, c) 	\
> 	do {				\
> 		if (a == 5)		\
> 			do_this(b, c);	\
> 	} while (0)

the former is the way it's presented in CodingStyle currently, it
wasn't my personal opinion on the subject.  i was just reproducing
what was already there.

> > + (b) Use the gcc extension that a compound statement enclosed in
> > +     parentheses represents an expression:
> > +
> > +	#define macrofun(a, b, c) ({		\
> >  		if (a == 5)			\
> >  			do_this(b, c);		\
> > -	} while (0)
> > +	})
>
> I'd rather document to not use this - it makes the code far less
> redable.  And it's a non-standard extension, something we only
> use if it provides us a benefit which it doesn't here.

it might be a bit late to put a cork in *that* bottle:

  $ grep -r "#define.*({" *

rday
