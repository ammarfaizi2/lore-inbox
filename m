Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWFHC3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWFHC3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWFHC3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:29:40 -0400
Received: from xenotime.net ([66.160.160.81]:53194 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932488AbWFHC3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:29:39 -0400
Date: Wed, 7 Jun 2006 19:32:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, jamagallon@ono.com, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
Subject: Re: [PATCH] ignore smp_locks section warnings from init/exit code
Message-Id: <20060607193225.989add4c.rdunlap@xenotime.net>
In-Reply-To: <20060608021149.GA5567@ccure.user-mode-linux.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608003153.36f59e6a@werewolf.auna.net>
	<20060607154054.cf4f2512.akpm@osdl.org>
	<20060607162326.3d2cc76b.rdunlap@xenotime.net>
	<20060608021149.GA5567@ccure.user-mode-linux.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 22:11:49 -0400 Jeff Dike wrote:

> On Wed, Jun 07, 2006 at 04:23:26PM -0700, Randy.Dunlap wrote:
> > I currently only see this in an __exit section.
> > Here is a patch that fixes it for me.
> 
> Cool, something equivalent makes the UML link a lot quieter.  I had to
> add ".plt" and ".bss".  I'm guessing mine are false positives as well,
> but have no idea how to check that.
> 
> I also think that adding these two sections would be UML-specific, but
> that probably shouldn't hurt other arches.

I could look, but:

> make ARCH=um allmodconfig
/var/linsrc/linux-2617-rc6mm1/arch/um/Makefile:113: *** missing separator.  Stop.

is that known/fixed?

---
~Randy
