Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbSJaUWQ>; Thu, 31 Oct 2002 15:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSJaUWQ>; Thu, 31 Oct 2002 15:22:16 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:8548 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262799AbSJaUWP>; Thu, 31 Oct 2002 15:22:15 -0500
Subject: Re: The ACL debate (was: Re: What's left over.)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210311047.07774.pollard@admin.navo.hpc.mil>
References: <1036061965.2425.20.camel@aurora.localdomain>
	 <200210311047.07774.pollard@admin.navo.hpc.mil>
Content-Type: text/plain
Organization: 
Message-Id: <1036096120.1510.5.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 31 Oct 2002 15:28:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 11:47, Jesse Pollard wrote:
> On Thursday 31 October 2002 04:59 am, Trever L. Adams wrote:
> > 5) Only root can change group ownership of a file
> 
> not quite - the owner of the file may change the group ownership to
> any other group that the owner is a member.
> 
> It does require root to change a file group to a group the owner is
> not a member of.
> 

I guess my experience with playing with groups is lacking.  I had tried
this, but I guess I always tried with groups I wasn't a member of.  I
still believe this is bad form, but probably has historical and valid
reasons for it.

> >Why ACLs are bad:
> 
> ACLs alone are not enough. ACLs alone allow a user to grant
> access to any other user/group. For situations that require a fence
> between users (ie. accounting/parts inventory) only a mandatory
> access control (MAC) would be able to prevent such improper
> data sharing. It is also a problem in government use. At least on
> large, shared resource systems.
> 

I see your point here too.  I usually see things from a perspective of
companies not needing this.   I mean "a house divided..." and all that. 
But I guess companies would rather force unity than let the one person
screw them over.  Point to you on the debate for sure.  I know there
have been MAC implementations for Linux... is one in 2.5?

> Mitigating factors:
> 
> Adding MAC restores facility control, and still allows the user
> some flexibility to create ad-hoc groups within an administratively
> defined population group.
> 

Sounds very good.  I would think for those who know they are united,
that MAC or ACL should not auto-define the other.  Having both, on
option, is nice though.

> The normal UNIX solution is to have multiple systems, each dedicated
> to a relatively small population where any user is authorized to access
> data on that system (this is where limited groups come in), but owners
> of the data may provide a more restricted access.
> 

Hardware is getting more powerful, why segment it through such physical
means?


> A large resource usually has to be shared (wind tunnel simulations,
> finite element analysis of different structures, large inventory
> management...). And sharing doesn't necessarily involve sharing
> data.

Understood.  You had many good points.  I still don't see it as a user
space problem though.  These are all things that go in the kernel...
Yes, policy doesn't belong in the kernel, but the ability to create
policy and enforce it does (where user-space may not be the right place,
such as here).

I guess I agree with you, but I still think ACLs are necessary and
wanted, even if there needs to be additional functionality for those who
are totally paranoid (some corps, governments, etc.)

Trever Adams

P.S.  I removed Linus from direct in the email because he has said he is
going to add it already.

