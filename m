Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTE2CLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 22:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTE2CLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 22:11:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17932 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261858AbTE2CLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 22:11:50 -0400
Date: Wed, 28 May 2003 19:23:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@au1.ibm.com>
cc: davem@redhat.com, <rth@twiddle.net>, <rmk@arm.linux.org.uk>,
       <bjorn@axis.com>, <jes@trained-monkey.org>, <ralf@gnu.org>,
       <matthew@wil.cx>, <gniibe@rr.iij4u.or.jp>, <jdike@karaya.com>,
       <uclinux-v850@lsi.nec.co.jp>, <davidm@hpl.hp.com>, <anton@samba.org>,
       <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Proposed patch to kernel.h
In-Reply-To: <16085.27084.581954.762132@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0305281921580.20971-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 May 2003, Paul Mackerras wrote:
>
> On second thoughts, it would be cleaner to move BUG_ON() into each
> architecture's bug.h alongside BUG() and PAGE_BUG(), rather than using
> an ifdef in kernel.h as my previous patch did.

Wouldn't it make sense to do the same thing to "WARN_ON()" then? It sounds 
entirely appropriate to use the same kind of conditional trap instructions 
for that too.. (The only difference being a bit somewhere that says that 
the "WARN_ON()" kind of trap handler should resume after the fault).

		Linus

