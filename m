Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWGMT4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWGMT4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWGMT4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:56:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64482 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030333AbWGMT4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:56:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<44B3D435.8090706@sw.ru> <m1k66jebut.fsf@ebiederm.dsl.xmission.com>
	<44B4D970.90007@sw.ru> <m164i2ae3m.fsf@ebiederm.dsl.xmission.com>
	<44B67C4B.7050009@fr.ibm.com>
	<m1irm11i2q.fsf@ebiederm.dsl.xmission.com>
	<1152815491.7650.62.camel@localhost.localdomain>
Date: Thu, 13 Jul 2006 12:54:30 -0600
In-Reply-To: <1152815491.7650.62.camel@localhost.localdomain> (Dave Hansen's
	message of "Thu, 13 Jul 2006 11:31:31 -0700")
Message-ID: <m11wsp1gk9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Thu, 2006-07-13 at 12:21 -0600, Eric W. Biederman wrote:
>> We need a formula for doing incremental development that will allow us to
>> make headway while not seeing the entire picture all at once.  The scope
>> is just too large.
>
> Definitely.  We need a low-risk development environment where we can put
> test-fit pieces together, but also not worry too much of we have to rip
> pieces out, or completely change them.

It probably makes sense to talk about this up in Ottowa.

> I'm not sure we *need* to rewrite things for review-ability later.  I
> think some of us have gotten pretty good at keeping our development in
> reviewable bits as we go along.

Well the rewrite of the history may simply be an ordering change.

It isn't so much the reviewability of a single piece but the reviewability
of the whole that I am worried about.  I have had one occasion lately
where I made a small simple sane change but I discovered that there
was one little hack I had to get rid of to make everything work.

To remove that hack required me to refactor another piece of code and
was more work than the original change.  That refactoring then had to happen
first, when the code was merged with the rest of the kernel.

So while we should try to keep our pieces as sane as possible we should
assume we have to rewrite history from our sandbox when we push the code
upstream.

Eric
