Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWJRK74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWJRK74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWJRK7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:59:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2783 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030197AbWJRK7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:59:54 -0400
Subject: Re: [PATCH] Undeprecate the sysctl system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1wt6y70kg.fsf@ebiederm.dsl.xmission.com>
References: <453519EE.76E4.0078.0@novell.com>
	 <20061017091901.7193312a.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	 <1161123096.5014.0.camel@localhost.localdomain>
	 <20061017150016.8dbad3c5.akpm@osdl.org>
	 <Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
	 <m1wt6y70kg.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 12:02:10 +0100
Message-Id: <1161169330.9363.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 21:41 -0600, ysgrifennodd Eric W. Biederman:
> > Signed-off-by: Cal Peake <cp@absolutedigital.net>
> 
> NAK on the grounds that it does not fix the related wording in sysctl.h

Just post a patch to fix the wording

> As for the rest of this I disagree with this direction as it is not
> fixing the status quo, just attempting to maintain it.

Good. That is how you manage system call interfaces.

> The status quo is that we don't properly maintain sysctl.h and we arbitrarily
> change the numbers.

Not the core basic ones that are those people care about

> It is wrong to maintain the status quo.  Who is volunteering to step
> up to the plate and maintain this thing?

For the existing values as is that matter anyone can do it, because it
just means not making a change.

Its very simple: sysctl was a neat BSD syscall that turned out to be
less ideal than using the fs for it. We added it, we supported it, we
get to keep it. We just stick notes in the docs saying "please use /proc
instead".

Alan

