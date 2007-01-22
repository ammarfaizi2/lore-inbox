Return-Path: <linux-kernel-owner+w=401wt.eu-S1751927AbXAVPTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbXAVPTN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbXAVPTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:19:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:47682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751927AbXAVPTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:19:12 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
From: Mike Galbraith <efault@gmx.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nicholas Miell <nmiell@comcast.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
In-Reply-To: <Pine.LNX.4.64.0701220556580.22914@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
	 <1169401892.2999.1.camel@entropy>
	 <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6>
	 <45B495F9.4@yahoo.com.au>
	 <Pine.LNX.4.64.0701220556580.22914@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 16:18:43 +0100
Message-Id: <1169479123.15483.42.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-22 at 06:02 -0500, Robert P. J. Day wrote:
> On Mon, 22 Jan 2007, Nick Piggin wrote:
> 
> > Robert P. J. Day wrote:
> >
> > > by adding (temporarily) the definitions of TRUE and FALSE to
> > > types.h, you should then (theoretically) be able to delete over
> > > 100 instances of those same macros being *defined* throughout the
> > > source tree. you're not going to be deleting the hundreds and
> > > hundreds of *uses* of TRUE and FALSE (not yet, anyway) but, at the
> > > very least, by adding two lines to types.h, you can delete all
> > > those redundant *definitions* and make sure that nothing breaks.
> > > (it shouldn't, of course, but it's always nice to be sure.)
> >
> > Doesn't seem very worthwhile, and it legitimises this definition
> > we're trying to get rid of.
> 
> hmmmmmmmm ... apparently, you totally missed my use of the important
> word "temporarily":
> 
>   $ grep -r "temporary hack" . | wc -l
>   16

That's a pretty good argument _against_ adding another one :)  I wonder
how old those "temporary hacks" are (the ones you missed as well).

To make TRUE/FALSE go away, you or someone will have to visit them all,
which will take time.  Why add an intermediate step where you or others
can end up getting interrupted (indefinitely), leaving the "temporary"
definition lying around for folks to use?

	-Mike

