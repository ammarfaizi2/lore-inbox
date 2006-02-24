Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWBXXBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWBXXBR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWBXXBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:01:17 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:27285 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932635AbWBXXBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:01:16 -0500
Date: Sat, 25 Feb 2006 00:01:15 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrey Savochkin <saw@sawoct.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Stanislav Protassov <st@sw.ru>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Which of the virtualization approaches is more suitable for kernel?
Message-ID: <20060224230114.GA12575@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
	Rik van Riel <riel@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	devel@openvz.org, Andrey Savochkin <saw@sawoct.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Stanislav Protassov <st@sw.ru>, serue@us.ibm.com,
	frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
	mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
	Andrew Morton <akpm@osdl.org>
References: <43F9E411.1060305@sw.ru> <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 02:44:42PM -0700, Eric W. Biederman wrote:
> Kirill Korotaev <dev@sw.ru> writes:
> 
> > Linus, Andrew,
> >
> > We need your help on what virtualization approach you would accept
> > to mainstream (if any) and where we should go.
> >
> > If to drop VPID virtualization which caused many disputes, we
> > actually have the one virtualization solution, but 2 approaches for
> > it. Which one will go depends on the goals and your approval any
> > way.
> 
> My apologies for not replying sooner.
> 
> > From the looks of previous replies I think we have some valid
> > commonalities that we can focus on.
> 
> Largely we all agree that to applications things should look exactly
> as they do now. Currently we do not agree on management interfaces.
>
> We seem to have much more agreement on everything except pids, so
> discussing some of the other pieces looks worth while.
> 
> So I propose we the patches to solve the problem into three categories.
> - General cleanups that simplify or fix problems now, but have
>   a major advantage for our work.
> - The kernel internal implementation of the various namespaces
>   without an interface to create new ones.
> - The new interfaces for how we create and control containers/namespaces.

proposal accepted on my side

> This should allow the various approach to start sharing code, getting
> progressively closer to each other until we have an implementation we
> can agree is ready to go into Linus's kernel. Plus that will allow us
> to have our technical flame wars without totally stopping progress.
> 
> We can start on a broad front, looking at several different things.
> But I suggest the first thing we all look at is SYSVIPC. It is
> currently a clearly recognized namespace in the kernel so the scope is
> well defined. SYSVIPC is just complicated enough to have a non-trivial
> implementation while at the same time being simple enough that we can
> go through the code in exhausting detail. Getting the group dynamics
> working properly.

okay, sounds good ...

> Then we can as a group look at networking, pids, and the other pieces.
> 
> But I do think it is important that we take the problem in pieces
> because otherwise it is simply to large to review properly.

definitely

best,
Herbert

> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
