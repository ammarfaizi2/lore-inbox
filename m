Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWGMSJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWGMSJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWGMSJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:09:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49108 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030260AbWGMSJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:09:27 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<44B3D435.8090706@sw.ru> <m1k66jebut.fsf@ebiederm.dsl.xmission.com>
	<44B4D970.90007@sw.ru> <m164i2ae3m.fsf@ebiederm.dsl.xmission.com>
	<44B67C4B.7050009@fr.ibm.com>
Date: Thu, 13 Jul 2006 12:07:33 -0600
In-Reply-To: <44B67C4B.7050009@fr.ibm.com> (Cedric Le Goater's message of
	"Thu, 13 Jul 2006 19:00:59 +0200")
Message-ID: <m1r70p1iqi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> hmm, slightly, I would say much harder and these weird interactions are
> very hard to anticipate without some experience in the field. We could
> continue on arguing for ages without making any progress.

I have not been intending to argue but to point out short comings.

> let's apply that incremental development approach now. Let's work on simple
> namespaces which would make _some_ container scenarios possible and not
> all. IMHO, that would mean tying some namespaces together and find a way to
> unshare them safely as a whole. Get some experience on it and then work on
> unsharing some more independently for the benefit of more use case
> scenarios. I like the concept and I think it will be useful.

I think we have a different conception of where the problems lie.

The easy cases I see are everything as a unit, or everything as
separate pieces.  I do not see natural connection between namespaces
that will help us out.

> just being pragmatic, i like things to start working in simple cases before
> over optimizing them.

I agree we incremental development is good and what we need.

The hard part is that we can never undo any part of our user interface.
So we must have complete an sane semantics when we implement a namespace,
before it gets merged anywhere beyond a purely development tree.

Then in addition to that usually you find that the existing implementation
does not have a good 1-1 change and must be refactored and have the cruft
removed before you can start extending it.

Eric
