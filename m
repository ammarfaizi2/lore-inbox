Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSJaQp1>; Thu, 31 Oct 2002 11:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSJaQnU>; Thu, 31 Oct 2002 11:43:20 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:10170 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S262805AbSJaQmR> convert rfc822-to-8bit; Thu, 31 Oct 2002 11:42:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: The ACL debate (was: Re: What's left over.)
Date: Thu, 31 Oct 2002 10:47:07 -0600
User-Agent: KMail/1.4.1
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036061965.2425.20.camel@aurora.localdomain>
In-Reply-To: <1036061965.2425.20.camel@aurora.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210311047.07774.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 04:59 am, Trever L. Adams wrote:
> 5) Only root can change group ownership of a file

not quite - the owner of the file may change the group ownership to
any other group that the owner is a member.

It does require root to change a file group to a group the owner is
not a member of.

>Why ACLs are bad:

ACLs alone are not enough. ACLs alone allow a user to grant
access to any other user/group. For situations that require a fence
between users (ie. accounting/parts inventory) only a mandatory
access control (MAC) would be able to prevent such improper
data sharing. It is also a problem in government use. At least on
large, shared resource systems.

Putting users in disjoint group memberships accomplishes this.
Providing ACLs can allow improper sharing since that is a descretionary
permission.

Mitigating factors:

Adding MAC restores facility control, and still allows the user
some flexibility to create ad-hoc groups within an administratively
defined population group.

The normal UNIX solution is to have multiple systems, each dedicated
to a relatively small population where any user is authorized to access
data on that system (this is where limited groups come in), but owners
of the data may provide a more restricted access.

Having dedicated resources corresponds to the MAC access control.
Having owner/group/world access controls (and/or ACLs) provides
the owner with a descretionary access control for the administratively
controled population of users.

A large resource usually has to be shared (wind tunnel simulations,
finite element analysis of different structures, large inventory
management...). And sharing doesn't necessarily involve sharing
data.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
