Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWDXHDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWDXHDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWDXHDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:03:53 -0400
Received: from thunk.org ([69.25.196.29]:34021 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750967AbWDXHDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:03:51 -0400
Date: Mon, 24 Apr 2006 03:03:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Neil Brown <neilb@suse.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060424070324.GA14720@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Neil Brown <neilb@suse.de>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	Chris Wright <chrisw@sous-sol.org>,
	James Morris <jmorris@namei.org>,
	Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17484.20906.122444.964025@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:18:50PM +1000, Neil Brown wrote:
> Think about the name of this system for a minute.  "AppArmor".
> i.e. it is Armour for an Application.  It protects the application.
> It doesn't (as far as I can tell: I'm not an expert and don't work on
> this thing) claim to protect files.  It protects applications.
...
> While the protection against subversion cannot be complete, it can be
> sufficient to dramatically reduce the chances of privilege
> escalation.   There are lots of wrong things you can get an
> application to do once you find an exploitable bug.  Many of these
> will lead to a crash.  AppArmor will not try to protect against these
> (I suspect).  There are substantially fewer that lead to privilege
> escalation.   AppArmor focusses its effort in terms of profile design
> on exactly these sorts of unplanned behaviours.
> 
> So I think you still haven't given convincing evidence that AppArmor
> is broken by design.

I have to agree with Neil here.  I spent over 10 years doing network
security as my day job, including chairing the IP Security working
group and being a member of the IETF Security Area Directorate, before
switching over to Linux as the thing that would pay the bills, and I
can state quite authoratatively that perfect security which is never
used because it's too hard to install, maintain, and configure, isn't
worth much compared to imperfect security which is easy enough such
that users always use it by default.

The goal of protecting against broken, buggy applications is a worthy
one.  If people can show that for a large set of stack overruns, or
other types of buggy applications, it is possible to evade AppArmor by
doing something clever, then AppArmor would need to be fixed or it's
not worth doing.  But if it can prevent a large class of buggy
applications from allowing an atttacker to escalate that bugginess
into a system penetration, then it has added value.

In the security world, there is a huge tradition of the best being the
enemy of the good --- and the best being so painful to use that people
don't want to use it, or the moment it gets in the way (either because
of performance reasons or their application does something that
requires painful configuration of the SELinux policy files), they
deconfigure it.  At which point the "best" becomes useless.

You may or may not agree with the philosophical architecture question,
but that doesn't necessarily make it "broken by design".  Choice is
good; if AppArmor forces SELinux to become less painful to use and
configure, then that in the long run will be a good thing.

						- Ted
