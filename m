Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTLCBVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264378AbTLCBVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:21:38 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:61458 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264460AbTLCBVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:21:35 -0500
Date: Wed, 3 Dec 2003 09:23:20 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: "Peter C. Norton" <spacey-linux-kernel@lenin.nu>
cc: Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 future
In-Reply-To: <20031202204656.GZ18176@lenin.nu>
Message-ID: <Pine.LNX.4.33.0312030846390.9365-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.6, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We seem to be getting a little of track here.

Sorry, this is probably not the right place for this discussion but I feel
strongly enough about it to pursue it anyway.

Being one of the people that have to face the dificulties that Peter has,
I think that a solution satisfactory to all needs to be worked out.

There seems to be two seperate problems here:

1) Whether to merge a huge unknown quality patch into the 2.4 stable
kernel.

The majority of people seem to feel it is not efficient use of Marcelos'
time and recommend a merge into 2.6.

That's fine with me if that's Marcelos' decision.


2) The supportability of using autofs v4 in RedHats' commercial product.

This issue can't be fixed by simply adding this patch to the kernel.

There is a userspace daemon which is also not included in the RedHat
product. RedHat have no reason to trust my code for their commercial
customers and their commercial customers need the sort of changes I am
trying to make.

So the real question is "what can I do to enable this to be used, without
customer penalty, in RedHats' commercial product".

I have a kernel module kit that allows the module to be used without
wiping out the original (and back out the change if needed). I think I can
turn this into an RPM if that would help.

I'm about to make 4.1.0 a release. It's not perfect but it is certainly an
improvement on previous autofs v4 versions. A src RPM will be produced as
well.

Anyone have any suggestions on how to solve this problem?


On Tue, 2 Dec 2003, Peter C. Norton wrote:

> On Tue, Dec 02, 2003 at 09:18:00PM +0100, Arjan van de Ven wrote:
> > On Tue, Dec 02, 2003 at 12:10:40PM -0800, Peter C. Norton wrote:
> > > On Tue, Dec 02, 2003 at 12:54:54AM +0100, Arjan van de Ven wrote:
> > > > On Mon, 2003-12-01 at 22:36, Peter C. Norton wrote:
> > > > `
> > > > > encouraging the distros to get behind autofs4 (hint hint, redhat,
> > > > > hint).
> > > >
> > > > I suspect you'll have a really hard time finding ANY distro that still
> > > > wants to actively develop new products on a 2.4 codebase.
> > >
> > > Perhaps, but some rather large customers of AS2.1, would like it if
> > > redhat could deliver the large outstanding automounting features for
> > > their (mainly sun) environments.  Since these environments resist
> > > change, upgrading a kernel to include a newer autofs4 is more likely
> > > than upgrading the whole system.
> >
> > and putting a feature into 2.4.23 is going to help/change that... how ?
>
> The autofs4 kernel code is already in the mainline kernel and in
> redhat's AS kernels.  However:
>
> 1) In the mainline its not complete (no direct mounts)
> 2) In redhats AS kernels its not supported or complete.  A newer version
>    seems to only make sense.
>
> Putting an upgrade to autofs4 in the mainline kernel once its proven
> would give users the option of having a much more feature-complete and
> un-broken automounter to use.  If its not hurting anything else then
> why leave broken code in the kernel?
>
> Please correct me if I'm making too big a leap, because I have a
> thought.  It seems that new hardware gets this sort of treatment - new
> drivers for a NIC, scsi, or FC card will be included in a stable
> series because with out it some subsystem of a computer "doesn't
> work" completely.  What makes this case different?
>
> -Peter
>
>

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

