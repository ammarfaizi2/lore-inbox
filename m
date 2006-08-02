Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWHBFhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWHBFhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWHBFhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:37:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:430 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751254AbWHBFhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:37:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 18/33] x86_64: Kill temp_boot_pmds II
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<p73psfk1dnh.fsf_-_@verdi.suse.de>
	<m18xm7yjh7.fsf@ebiederm.dsl.xmission.com>
	<200608020507.02604.ak@suse.de>
Date: Tue, 01 Aug 2006 23:35:38 -0600
In-Reply-To: <200608020507.02604.ak@suse.de> (Andi Kleen's message of "Wed, 2
	Aug 2006 05:07:02 +0200")
Message-ID: <m1k65rvgwl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> It is probably patch 17:
>> "x86_64: Separate normal memory map initialization from the hotplug case"
>
> Ok that messes things up. Actually I think i prefered the previous
> code - it was not that bad as you make it. The two variants. 
> are really doing mostly the same. So best you drop that.

All of my complaints are real.  But yes I do think a reasonable
case can be made for merging them.  In several of the worst cases
simply calling memset before initializing the page is probably
sufficient to remove a test later on.

As that code sits right now you need way too much global context
to understand what is going on.  It is the kind of code that cause
obviously correct patches to fail, and I'm clever enough to know
clever code is very dangerous. :)

So before I get back to that I will probably look and see if there
is some more heavy lifting I can do to make that code less of a land mine.

>> I don't see any other patches that touch arch/x86_64/mm/init.c
>> before that.  At least not in 2.6.18-rc3, which is the base of
>> my patchset.
>
> I got three patches that touch mm/init.c in my patchkit
> (ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/)
>
> BTW I didn't merge any further patches currently, but might
> after the next round when the current comments are addressed.

Ok. I will take a look.

Having any patches merged on a simple request for comments was a bit of a surprise :)

Eric
