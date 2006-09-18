Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWIRLoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWIRLoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 07:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWIRLoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 07:44:38 -0400
Received: from stanford.columbia.tresys.com ([209.60.7.66]:26458 "EHLO
	twoface.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S964777AbWIRLoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 07:44:37 -0400
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
	3/4: introduce new capabilities
From: Joshua Brindle <method@gentoo.org>
To: David Madore <david.madore@ens.fr>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <20060917211602.GA6215@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr>
	 <20060910134257.GC12086@clipper.ens.fr>
	 <1157905393.23085.5.camel@localhost.localdomain>
	 <450451DB.5040104@gentoo.org> <20060917181422.GC2225@elf.ucw.cz>
	 <450DB274.1010404@gentoo.org>  <20060917211602.GA6215@clipper.ens.fr>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 07:46:06 -0400
Message-Id: <1158579966.8680.24.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 23:16 +0200, David Madore wrote:
> On Sun, Sep 17, 2006 at 04:39:16PM -0400, Joshua Brindle wrote:
> > The benefits of this are so minuscule and the cost is so high if you are 
> > ever to use it that it simply won't happen..
> 
> I'm withdrawing that patch anyway, in favor of a LSM-style approach,
> the "cuppabilities" module (cf. the patch I posted a couple of hours
> ago with that word in the title, and I'll be posting a new version in
> a day or so, or cf. <URL:
> http://www.madore.org/~david/linux/cuppabilities/
>  >).  In this case, the relative cost will be lower since the
> security_ops->inode_permission() hook is called no matter what.
> 

You misunderstand. I don't mean the performance cost is high, I mean the
cost of an application to actually be able to run without open() (what I
was saying before, static built, no glibc, no conf files, no name
lookups, etc). I never see this being used in the real world because of
the extreme limitations.

And that is just practical stuff, there are still problems with
embedding policy into binaries all over the system in an entirely
non-analyzable way, and this extends to all capabilities, not just the
open() one.

> But I agree that the value of restricting open() is very dubious and
> it was intended mostly as a demonstration.  So if there is strong
> opposition to this sort of thing, I'll remove it.
> 
> Happy hacking,
> 

