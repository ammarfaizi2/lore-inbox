Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWBVP3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWBVP3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWBVP3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:29:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14984 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751344AbWBVP3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:29:17 -0500
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andrey Savochkin <saw@sawoct.com>, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mrmacman_g4@mac.com, Linus Torvalds <torvalds@osdl.org>,
       frankeh@watson.ibm.com, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: Which of the virtualization approaches is more
 suitable for kernel?
References: <43F9E411.1060305@sw.ru>
	<20060220161247.GE18841@MAIL.13thfloor.at> <43FB3937.408@sw.ru>
	<20060221235024.GD20204@MAIL.13thfloor.at>
	<43FC3853.9030508@openvz.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 22 Feb 2006 08:26:25 -0700
In-Reply-To: <43FC3853.9030508@openvz.org> (Kir Kolyshkin's message of "Wed,
 22 Feb 2006 13:09:23 +0300")
Message-ID: <m1zmkjjty6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kir Kolyshkin <kir@openvz.org> writes:

> Please stop seeding, hmm, falseness. OpenVZ patches you mention are against
> 2.6.8 kernel, thus they contain tons of backported mainstream bugfixes and
> driver updates; so, most of this size is not virtualization, but general
> security/stability/drivers stuff. And yes, that size also indirectly tells how
> much work we do to keep our users happy.

I think Herbert was trying to add some balance to the equation.

> Back to the topic. If you (or somebody else) wants to see the real size of
> things, take a look at broken-out patch set, available from
> http://download.openvz.org/kernel/broken-out/. Here (2.6.15-025stab014.1 kernel)
> we see that it all boils down to:

Thanks.  This is the first indication I have seen that you even have broken-out 
patches.  Why those aren't in your source rpms is beyond me.  Everything
seems to have been posted in a 2-3 day window at the end of January and the
beginning of February.  Is this something you are now providing?

Shakes head.  You have a patch in broken-out that is 817K.  Do you really
maintain it this way as one giant patch?

> Virtualization stuff:                    diff-vemix-20060120-core   817K
> Resource management (User Beancounters): diff-ubc-20060120          377K
> Two-level disk quota:                    diff-vzdq-20051219-2       154K

As for the size of my code, sure parts of it are big I haven't really
measured.  Primarily this is because I'm not afraid of doing the heavy
lifting necessary for a clean long term maintainable solution.

Now while all of this is interesting.  It really is beside the point
because neither the current vserver nor the current openvz code are
ready for mainstream kernel inclusion.  Please let's not get side
tracked playing whose patch is bigger.

Eric
