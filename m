Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWBGGbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWBGGbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 01:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWBGGbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 01:31:05 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:48541 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932067AbWBGGbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 01:31:04 -0500
Message-ID: <43E83E8A.1040704@vilain.net>
Date: Tue, 07 Feb 2006 19:30:34 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Mon, 6 Feb 2006, Eric W. Biederman wrote:
> 
> 
>>We are never going to form a consensus if all of the people doing 
>>implementations don't talk.
> 
> 
> Speaking of which - it would be interesting to get Kirill's
> comments on Eric's patchset ;)
> 
> Once we know what's good and bad about both patchsets, we'll
> be a lot closer to knowing what exactly should go upstream.

Let's compare approaches of patchsets before the patchsets themselves.

It seems to be, should we:

   A) make a general form of virtualising PIDs, and hope this assists
      later virtualisation efforts (Eric's patch)

   B) make a general form of containers/jails/vservers/vpses, and layer
      PID virtualisation on top of it somewhere (as in openvz, vserver)

I can't think of any real use cases where you would specifically want A)
without B).

Also, the problem space in B) is now very well explored.  To start with
A) would mean to throw away 4+ years of experience at this approach
(just counting vserver and variants - not FreeBSD Jail, etc).  Trying to
re-base B) atop a massive refactoring and new patch like A) would incur
a lot of work; however fitting it into B) is natural and solved
conceptually and in practice, with the only drawback I see being that
the use cases mentioned above wouldn't suffer from the side-effects of
B).

Perhaps I'm wrong there, but that's my gut feeling.

Sam.
