Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWISPyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWISPyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWISPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:54:43 -0400
Received: from web36607.mail.mud.yahoo.com ([209.191.85.24]:49504 "HELO
	web36607.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751512AbWISPym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:54:42 -0400
Message-ID: <20060919155441.27211.qmail@web36607.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 19 Sep 2006 08:54:41 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
To: Joshua Brindle <method@gentoo.org>
Cc: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <450F6D87.7090604@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Joshua Brindle <method@gentoo.org> wrote:

> Casey Schaufler wrote:
> > --- Joshua Brindle <method@gentoo.org> wrote:
> >   
> >>> The first system I took through evaluation
> >>> (that is, independent 3rd party analysis) stored
> >>> security attributes in a file while the second
> >>> and third systems attached the attributes
> >>> directly (XFS). The 1st evaluation required
> >>> 5 years, the 2nd 1 year. It is possible that
> >>> I just got a lot smarter with age, but I
> >>> ascribe a significant amount of the improvement
> >>> to the direct association of the attributes
> >>> to the file.
> >>>       
> >> Thats great but entirely irrelevant in this
> context.
> >> The patch and caps 
> >> in question are not attached to the file via some
> >> externally observable 
> >> property (eg., xattr) but instead are embedded in
> >> the source code so 
> >> that it can drop caps at certain points during
> the
> >> execution or before 
> >> executing another app, thus unanalyzable.
> >>     
> >
> > Oh that. Sure, we used capability bracketing
> > in the code, too. That makes it easy to
> > determine when a capability is active. What,
> > you don't think that it's possible to analyze
> > source code? Of course it is. Refer to the
> > evaluation reports if you don't believe me.
> >
> >   
> When I see an analysis of every line of source code
> on an average Linux 
> machine then I might believe you

Would an above average Unix system suffice?
How about MULTICS?

It's been done for:
    Irix and Trusted Irix
    Solaris and Trusted Solaris
    UNICOS
    HP/UX
    AIX
    SystemV
    Xenix

> (if you'll grant
> that no software can 
> ever be installed on it afterward without being
> analyzed)

Rubbish. No privileged software can be installed.
Software that runs as a user without capabilities
can be installed freely. It only requires analysis
if it violates policy, which on a system with
POSIX capabilities means running in possession
of capabilities. 

> but until then 
> I'll stick with a centralized policy.

OK. There is value in containment.

> I doubt many others will be 
> satisfied with that limitation.

It's been selling in the marketplace for
the past 20 years.

> Bracketing hardly makes it analyzable, how can you
> possibly know if the 
> bracketing happened?

Err, read the code?

> You *believe* it will and
> therefore you say that 
> the bracketed code is safe but in reality this is a
> discretionary 
> mechanism and you have zero assurance that there is
> any security whatsoever,

Ah, no. You don't seem to understand the concept.

> no thanks, I'll pass.

Probably just as well, all things considered.


Casey Schaufler
casey@schaufler-ca.com
