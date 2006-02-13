Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWBMJAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWBMJAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWBMJAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:00:51 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:24924 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751656AbWBMJAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:00:50 -0500
Message-ID: <43F04B28.9090300@sw.ru>
Date: Mon, 13 Feb 2006 12:02:32 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1wtg2w41c.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1wtg2w41c.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Actually I can't say your patch is cleaner somehow.
>>It is very big and most of the changes are trivial, which creates an illusion
>>that it is straightforward and clean.
> 
> 
> It is hard to make a comparison.  Your patch posted to the mail list
> was incomplete, and I could only find a giant patch for OpenVZ.
this is wrong. it lacked only alpha get_xpid().
sure, we didn't do that dirty games with /proc you did, so maybe this is 
why you have such a feeling.

> Beyond that if your patch introduced a type change for internal pids
> and used that generate compile errors when someone did not use the
> appropriate type, I would be a lot happier and the code would
> be a lot more maintainable.  I.e. It would not take an audit of
> the kernel source to find the issues an allyesconfig build would find
> them for you.
it is not a problem at all and can be done.

> I don't think my current implementation actually causes enough compile
> errors, but I need think closely about it before I go much farther.
> 
> Maintainable code is a delicate balancing act between things that
> trip you up when you get it wrong, and not being so cumbersome you
> get in the programmers way

> The advantages I see with my approach.
> - I have hierarchical pids so nesting is possible.
Once again, our approach doesn't prohibit hierarchical pids.
But in addition to yours it allows to select whether weak or strong 
isolation is required.

> - The state after migration is not suboptimal.
sorry?

> - I cause compiler errors which makes maintenance easier.
it is not a question to the approach itself, you see? so not an argument.

> - Other kernel developers gut feel is that (container, pid) is the proper
>   representation.  
>   I actually flip flop on the issue of if I want the internal representation
>   to be (container, pid) or a magic kpid that combines the into one integer.
>   I know I don't want the kpid to be user space visible though.
> 
> So far you have not addressed the issues of maintaining code in the
> kernel tree.  
Uhhh... I see that you have no real arguments. Nice.

Kirill

