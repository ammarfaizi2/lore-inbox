Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWDXVE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWDXVE2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWDXVE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:04:28 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:41453 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751279AbWDXVE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:04:27 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060424070324.GA14720@thunk.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <20060424070324.GA14720@thunk.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 24 Apr 2006 17:07:56 -0400
Message-Id: <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 03:03 -0400, Theodore Ts'o wrote:
> I have to agree with Neil here.  I spent over 10 years doing network
> security as my day job, including chairing the IP Security working
> group and being a member of the IETF Security Area Directorate, before
> switching over to Linux as the thing that would pay the bills, and I
> can state quite authoratatively that perfect security which is never
> used because it's too hard to install, maintain, and configure, isn't
> worth much compared to imperfect security which is easy enough such
> that users always use it by default.

Seems like a strawman.  We aren't claiming that SELinux is perfect, and
there is plenty of work ongoing on SELinux usability.  But a
fundamentally unsound mechanism is more dangerous than one that is never
enabled; at least in the latter case, one knows where one stands.  It is
the illusory sense of security that accompanies path-based access
control that is dangerous.  You don't have to be an SELinux advocate to
see the problems with a path-based kernel access control mechanism.

> The goal of protecting against broken, buggy applications is a worthy
> one.  If people can show that for a large set of stack overruns, or
> other types of buggy applications, it is possible to evade AppArmor by
> doing something clever, then AppArmor would need to be fixed or it's
> not worth doing.  But if it can prevent a large class of buggy
> applications from allowing an atttacker to escalate that bugginess
> into a system penetration, then it has added value.

Does it have any hope of stopping an attacker who has designed his
attack with full knowledge of AppArmor's design and implementation (no
security through obscurity)?

> In the security world, there is a huge tradition of the best being the
> enemy of the good --- and the best being so painful to use that people
> don't want to use it, or the moment it gets in the way (either because
> of performance reasons or their application does something that
> requires painful configuration of the SELinux policy files), they
> deconfigure it.  At which point the "best" becomes useless.
> 
> You may or may not agree with the philosophical architecture question,
> but that doesn't necessarily make it "broken by design".  Choice is
> good; if AppArmor forces SELinux to become less painful to use and
> configure, then that in the long run will be a good thing.

The problems with path-based mechanisms are technical in nature, not
just philosophical.

-- 
Stephen Smalley
National Security Agency

