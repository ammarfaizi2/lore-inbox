Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUGJGYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUGJGYL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUGJGYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:24:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:64679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266158AbUGJGYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:24:08 -0400
Date: Fri, 9 Jul 2004 23:23:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jul 2004, Linus Torvalds wrote:
> 
> Problems arise when there is room for confusion, and that's when the 
> compiler should (and does) warn. If something is unambiguous, it's not 
> bad.

Btw, has anybody who is complaining about the 0/NULL fixing actually 
_looked_ at the code?

Every single time a 0 was replaced by a NULL it was an obvious
_improvement_ to the code. Not just "once". EVERY SINGLE TIME. It might be
irritating to see the patches, and there might be too many of them since
nothing has ever automatically noticed the bugs until now, but the fact
is, there is not even any gray areas here - if you look at any of the
patches being applied, they are ALL clearly making things more readable in
their local context.

I really don't see the point of complaining about the fixes. There's just
_no_ way to say that "0" is more readable than "NULL" in any of the cases.  
I dare you - show _one_ case where a 0/NULL patch was wrong or even
remotely debatable. I dare you.

		Linus
