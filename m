Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWD0Rjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWD0Rjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWD0Rjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:39:36 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:8373 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S965047AbWD0Rjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:39:35 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken Brush <kbrush@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <1145911526.14804.71.camel@moss-spartans.epoch.ncsc.mil>
	 <17485.55676.177514.848509@cse.unsw.edu.au>
	 <1145984831.21399.74.camel@moss-spartans.epoch.ncsc.mil>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
	 <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 27 Apr 2006 13:43:53 -0400
Message-Id: <1146159833.5238.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 16:06 -0700, Ken Brush wrote:
> On 4/26/06, Neil Brown <neilb@suse.de> wrote:
> >
> > I feel we have reached the stage where the questions/comments being
> > made are actually directly relevant to AppArmor.  I'm afraid I cannot
> > proceed any further now because I am not a security expert.
> >
> > I would like to summarise what I think are the key points that you
> > have raised, and hope that someone who has a deeper understanding of
> > these things might answer them, or point to answers.
> >
> > 1/ Does AppArmor's primary mechanism of confining an application to a
> >   superset of it's expected behaviour actually achieve its secondary
> >   gaol of protecting data?
> >
> >   Possibly it would be better to ask "When does ..."  as I think it is
> >   easy to imagine application/profile pairs that clearly cannot allow
> >   harm, and application/profile pairs that clearly could allow harm.
> 
> Depends on the data. A properly constrained Apache webserver would be
> prevented from accessing data it shouldn't.

No, it wouldn't.  The question itself is flawed - it presumes that AA
does confine the application to its expected behavior.  But with
incomplete mediation and ambiguous identifiers, there is no such
guarantee.  No profile will meet the "clearly cannot allow harm"
definition, because not all operations are controlled by it and of the
operations that are controlled, the actual objects are not clearly
identified, so harm is still possible.

> > 2/ What advantages does AppArmor provide over techniques involving
> >    virtualisation or gaol mechanisms?  Are these advantages worth
> >    while?
> 
> If you just wish to run every application in a chrooted jail. Would
> you still need a MAC solution?

If your goal is purely isolation, then virtualization may fit your
needs.  If you want to support controlled sharing of data while still
ensuring that certain confidentiality and integrity goals are met, then
you want a MAC mechanism.  But AA really isn't a MAC mechanism, despite
what its documentation may say.

-- 
Stephen Smalley
National Security Agency

