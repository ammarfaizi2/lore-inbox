Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVFMLOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVFMLOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFMLOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 07:14:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261471AbVFMLOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 07:14:47 -0400
Date: Mon, 13 Jun 2005 07:14:22 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       bert hubert <bert.hubert@netherlabs.nl>,
       Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       jnf <jnf@innocence-lost.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
Message-ID: <20050613111422.GT22349@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1118444314.4823.81.camel@localhost.localdomain> <1118616499.9949.103.camel@localhost.localdomain> <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org> <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg> <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org> <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl> <1118655702.2840.24.camel@localhost.localdomain> <20050613110556.GA26039@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613110556.GA26039@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 12:05:56PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 13, 2005 at 10:41:41AM +0100, David Woodhouse wrote:
> > On Mon, 2005-06-13 at 11:16 +0200, bert hubert wrote:
> > > So, please, consider merging the patches.. ppoll is something else, I never
> > > heard about it, but pselect is widely known.
> > 
> > It just seemed silly to implement pselect() without doing ppoll() at the
> > same time.
> 
> Yes, it kinda makes sense.  Question to Uli: would you put ppoll() into
> glibc as GNU extension?  If not adding the syscall is rather poinless
> unfortunately.

And if ppoll is added, the question is also what it's prototype should look like
(i.e. have the suboptimal int timeout argument as poll(2), where you can
only wait for less than a month or infinitely, or use const struct timespec *
like pselect, or struct timeval * like select).

	Jakub
