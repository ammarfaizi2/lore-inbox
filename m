Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWBGLt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWBGLt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWBGLt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:49:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:23418 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965047AbWBGLtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:49:55 -0500
Message-ID: <43E889B6.5030002@sw.ru>
Date: Tue, 07 Feb 2006 14:51:18 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net>
In-Reply-To: <43E83E8A.1040704@vilain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> We are never going to form a consensus if all of the people doing 
>>> implementations don't talk.
>>
>> Speaking of which - it would be interesting to get Kirill's
>> comments on Eric's patchset ;)
I'll do comment.

>> Once we know what's good and bad about both patchsets, we'll
>> be a lot closer to knowing what exactly should go upstream.
I'm starting to think that nothing in upstream can be better for all of 
us :)

> Let's compare approaches of patchsets before the patchsets themselves.
> It seems to be, should we:
> 
>   A) make a general form of virtualising PIDs, and hope this assists
>      later virtualisation efforts (Eric's patch)
> 
>   B) make a general form of containers/jails/vservers/vpses, and layer
>      PID virtualisation on top of it somewhere (as in openvz, vserver)
 >
> I can't think of any real use cases where you would specifically want A)
> without B).
Exactly! All these patches for A) look weird for me without containers 
itself. A try to make half-solution which is bad.

> Also, the problem space in B) is now very well explored.  To start with
> A) would mean to throw away 4+ years of experience at this approach
> (just counting vserver and variants - not FreeBSD Jail, etc).  Trying to
> re-base B) atop a massive refactoring and new patch like A) would incur
> a lot of work; however fitting it into B) is natural and solved
> conceptually and in practice, with the only drawback I see being that
> the use cases mentioned above wouldn't suffer from the side-effects of
> B).
Have you saw my patches?
This is B) :) This is what we should start with IMHO.
Having a containers and isolation all these talks about A) will be much 
more precise.

Kirill

