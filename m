Return-Path: <linux-kernel-owner+w=401wt.eu-S1751535AbXAVPmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXAVPmx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbXAVPmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:42:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48725 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbXAVPmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:42:53 -0500
X-Originating-Ip: 74.109.98.130
Date: Mon, 22 Jan 2007 10:41:58 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Mike Galbraith <efault@gmx.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nicholas Miell <nmiell@comcast.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
In-Reply-To: <1169479123.15483.42.camel@Homer.simpson.net>
Message-ID: <Pine.LNX.4.64.0701221039160.21545@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
  <1169401892.2999.1.camel@entropy>  <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6>
  <45B495F9.4@yahoo.com.au>  <Pine.LNX.4.64.0701220556580.22914@CPE00045a9c397f-CM001225dbafb6>
 <1169479123.15483.42.camel@Homer.simpson.net>
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

On Mon, 22 Jan 2007, Mike Galbraith wrote:

> On Mon, 2007-01-22 at 06:02 -0500, Robert P. J. Day wrote:
> > On Mon, 22 Jan 2007, Nick Piggin wrote:
> >
> > > Robert P. J. Day wrote:
> > >
> > > > by adding (temporarily) the definitions of TRUE and FALSE to
> > > > types.h, you should then (theoretically) be able to delete over
> > > > 100 instances of those same macros being *defined* throughout the
> > > > source tree. you're not going to be deleting the hundreds and
> > > > hundreds of *uses* of TRUE and FALSE (not yet, anyway) but, at the
> > > > very least, by adding two lines to types.h, you can delete all
> > > > those redundant *definitions* and make sure that nothing breaks.
> > > > (it shouldn't, of course, but it's always nice to be sure.)
> > >
> > > Doesn't seem very worthwhile, and it legitimises this definition
> > > we're trying to get rid of.
> >
> > hmmmmmmmm ... apparently, you totally missed my use of the important
> > word "temporarily":
> >
> >   $ grep -r "temporary hack" . | wc -l
> >   16
>
> That's a pretty good argument _against_ adding another one :)  I
> wonder how old those "temporary hacks" are (the ones you missed as
> well).
>
> To make TRUE/FALSE go away, you or someone will have to visit them
> all, which will take time.  Why add an intermediate step where you
> or others can end up getting interrupted (indefinitely), leaving the
> "temporary" definition lying around for folks to use?

as opposed to the 100+ *other* definitions currently cluttering up the
tree, which this patch would allow to be deleted *immediately*.

forget it.  i can see this argument is going nowhere and that, six
months from now, some poor sucker is going to post, asking, "hey, you
know all these TRUE/FALSE things?  wouldn't it be great if we could,
you know, clean those up?  whaddya say?"

and groundhog day will begin all over again ...

rday
