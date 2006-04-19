Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWDSWdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWDSWdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWDSWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:33:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:27840 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751290AbWDSWdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:33:00 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	<1145470463.3085.86.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 20 Apr 2006 00:32:43 +0200
In-Reply-To: <1145470463.3085.86.camel@laptopd505.fenrus.org>
Message-ID: <p73mzeh2o38.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> 
> you must have a good defense against that argument, so I'm curious to
> hear what it is

[I'm not from the apparmor people but my understanding is]

Usually they claimed name spaces as the reason it couldn't work.

In practice AFAIK basically nobody uses name spaces for
anything.  AppArmor just forbids mounts/CLONE_NEWNS for the confined
applications and there is no way a new name space can be created so
the problem doesn't exist.

I suppose if name space based user space takes over the world
there is a problem but I have yet to see any signs of plan9 like userland
taking over the world (e.g. they're certainly not used for anything in 
the distributions I'm familiar with).  

Some people claim it will be used in the future in a particular application
that most people I know don't want to have anything to do with,
but right now that application uses an own file system that is also unlikely
to work with selinux or anything so it won't change anything for that.

I'm not aware of any other proposed application.

Also name spaces can be still used of course, just not with 
apparmor limited applications.

So it's an interesting theoretical discussion, but in practice
it's a non issue.

Anyways, I guess the bigger issue is with hard links anyways
(Chris gave a long list of other ways to get aliases in path names
earlier). Discussing those might be much more fruitful.

That said I'm personally not too fond of path named filtering
either (it always seemed ugly to me), but I haven't seen anybody
proposing anything better so far that wasn't insanely complex
and basically impossible to administer.

-Andi
