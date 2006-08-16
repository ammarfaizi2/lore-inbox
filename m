Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWHPDoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWHPDoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWHPDoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:44:08 -0400
Received: from web36605.mail.mud.yahoo.com ([209.191.85.22]:49776 "HELO
	web36605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750889AbWHPDoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:44:06 -0400
Message-ID: <20060816034406.54724.qmail@web36605.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 15 Aug 2006 20:44:06 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] [PATCH] file posix capabilities
To: Albert Cahalan <acahalan@gmail.com>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       chrisw@sous-sol.org
In-Reply-To: <787b0d920608151943k3d39b5b4v26f85cfbc527514c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Albert Cahalan <acahalan@gmail.com> wrote:

> Casey Schaufler writes:
> > --- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> >> +    bprm->cap_effective = fscaps[0];
> >> +    bprm->cap_inheritable = fscaps[1];
> >> +    bprm->cap_permitted = fscaps[2];
> >
> > It does not appear that you're attempting
> > to maintain the POSIX exec semantics for
> > capability sets. (If you're doing it
> > elsewhere in the code, nevermind) I don't
> > know if this is intentional or not.
> 
> Stop right there. No such POSIX semantics exist.
> There is no POSIX standard for this.

Strictly speaking you are of course correct.
Please accept my appologies and pass them along
to the IEEE.

> Out in the
> wild there are numerous dangerously incompatible
> ideas about this concept:
> 
> a. SGI IRIX, and one draft of a failed POSIX
> proposal

There were 17 drafts. I believe the one you
refer to is the last, which was withdrawn
due to lack of participation.

> b. Linux (half done), and a very different draft

A very similar draft. The differences are not
so significant as to matter much.

> c. DG-UX, which actually had a workable system

Opinions vary!

> d. Solaris, which is workable and getting used

Ok.
 
> Something has changed though: people are actually
> using this type of thing on Solaris. Probably the
> sanest thing to do is to copy Solaris: equations,
> tools, set of bits, #define names, API, etc. Just
> let Sun be the standard, and semi-portable apps
> will be able to use the feature. Cross-platform
> admins will be very grateful for the consistency.

There are worse notions floating about.
I personally prefer the scheme used in
Irix (big surprise there) but I certainly
wouldn't obstruct a concerted effort to
go the Solaris route. 


Casey Schaufler
casey@schaufler-ca.com
