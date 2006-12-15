Return-Path: <linux-kernel-owner+w=401wt.eu-S932186AbWLOAtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWLOAtB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWLOAtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:49:01 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:40299 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbWLOAs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:48:59 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 19:44:50 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
In-Reply-To: <20061214162605.b4b6f9f8.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0612141939500.27613@localhost.localdomain>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
 <20061214223850.GC25114@vasa.acc.umu.se> <4581D355.1000701@oracle.com>
 <Pine.LNX.4.64.0612141906270.27378@localhost.localdomain>
 <20061214162605.b4b6f9f8.randy.dunlap@oracle.com>
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

On Thu, 14 Dec 2006, Randy Dunlap wrote:

> On Thu, 14 Dec 2006 19:07:27 -0500 (EST) Robert P. J. Day wrote:
>
> > On Thu, 14 Dec 2006, Randy Dunlap wrote:
> >
> > > David Weinehall wrote:
> > > > On Thu, Dec 07, 2006 at 12:48:38AM -0800, Randy Dunlap wrote:
> > > >
> > > > [snip]
> > > >
> > > > > +but no space after unary operators:
> > > > > +		sizeof  ++  --  &  *  +  -  ~  !  defined
> > > >
> > > > Uhm, that doesn't compute...  If you don't put a space after sizeof,
> > > > the program won't compile.
> > > >
> > > > int c;
> > > > printf("%d", sizeofc);
> > >
> > > Uh, we prefer not to see "sizeof c".  IOW, we prefer to have the
> > > parentheses use all the time.  Maybe I need to say that better?
> >
> > here's a *really* rough first pass, i'm sure the end result would need
> > some hand tweaking:
>
> You can certainly send such (generated) patches to Andrew or other
> subsystem maintainers if you'd like, but I'm more interested in not
> adding more crud to the tree in the future.
>
> IOW, sure, we prefer sizeof(foo) to sizeof foo, but the latter isn't
> killing us.  If someone is there making other changes, it would be
> OK to change that also.

the advantage to standardizing what's there is that it makes it easier
to make subsequent changes.  as a perfect example, because there are
several variations to the use of "sizeof", trying to catch every
combination that might be replaceable by the use of ARRAY_SIZE() is
just that much harder since you'd have to (as i had to) use regular
expressions to check for every variant -- parentheses or no
parentheses?  space after the word or not?  internal spaces within the
parentheses?

all that variation makes global changes for more useful stuff a real
pain.

rday

