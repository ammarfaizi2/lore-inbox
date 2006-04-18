Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWDRQvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWDRQvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWDRQvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:51:07 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:37539 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751108AbWDRQvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:51:05 -0400
To: Christoph Hellwig <hch@infradead.org>
cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-reply-to: Your message of Tue, 18 Apr 2006 12:58:19 BST.
             <20060418115819.GB8591@infradead.org> 
Date: Tue, 18 Apr 2006 09:50:41 -0700
Message-Id: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Apr 2006 12:58:19 BST, Christoph Hellwig wrote:
> On Mon, Apr 17, 2006 at 06:44:51PM -0700, Gerrit Huizenga wrote:
> > 
> > On Mon, 17 Apr 2006 23:55:25 BST, Christoph Hellwig wrote:
> > > On Mon, Apr 17, 2006 at 03:15:29PM -0700, Gerrit Huizenga wrote:
> > > > configure correctly that most of them disable it.  In theory, LSM +
> > > > something like AppArmour provides a much simpler security model for
> > > 
> > > apparmor falls into the findamentally broken category above, so it's
> > > totally uninteresting except as marketing candy for the big red company.
> > 
> > Is there a pointer to why it is fundamentally broken?  I haven't seen
> > such comments before but it may be that I've been hanging out on the
> > wrong lists or spending too much time inhaling air at 30,000 feet.
> 
> It's doing access control on pathnames, which can't work in unix enviroments.
> It's following the default permit behaviour which causes pain in anything
> security-related (compare [1]).
> 
> 
> [1] http://www.ranum.com/security/computer_security/editorials/dumb/

Interesting but I'm not impressed by the article.  I think Stephen's
reference has a bit more meat to it.  According to this article my
laptop should set so I have a white list of apps (which would be
really really long, ergo why make a list?  I run much more than
5 apps on a day to day basis).  Even on a general purpose machine
that is shared by many users will have a large number of apps.  When
your white list is a large percentage of the apps that are on the
machine, these two approaches start to converge.  In the end it always
comes down to "how much security are you prepared to endure, given
that security almost always limits user capability".

Based on what this article says, it sounds like MACs and ACLs would be
required because without them they permit you to share data with people
that may not need that data, people should only have access to the
limited set of applications and data that they need, and the machine
should be tightened down to the point where the security approaches
absolute security.

While that might fit in with "perfect" security, most people aren't
interested in that level of perfection.  "Default permit" was so popular
because it caught the obvious exploits without overly limiting people's
ability to use a machine.  It is still pretty commonly used today.
Also, any security protection has a whole range of protections, from
firewalls, limiting which packages are installed, accounts/passwords,
validation of users, etc.  Does everyone have to have "perfect" security
or are there places where a "less than perfect, easy to use, good enough"
security policy?  I believe there is room for both based on the end
users' needs and desires.  But that is just my opinion.

gerrit
