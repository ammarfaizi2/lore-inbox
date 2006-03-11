Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751998AbWCKHoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbWCKHoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWCKHoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:44:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751998AbWCKHoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:44:12 -0500
Date: Fri, 10 Mar 2006 23:41:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: garloff@suse.de, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
Message-Id: <20060310234155.685456cd.akpm@osdl.org>
In-Reply-To: <1142061816.3055.6.camel@laptopd505.fenrus.org>
References: <20060310155738.GL5766@tpkurt.garloff.de>
	<20060310145605.08bf2a67.akpm@osdl.org>
	<1142061816.3055.6.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Fri, 2006-03-10 at 14:56 -0800, Andrew Morton wrote:
> > Kurt Garloff <garloff@suse.de> wrote:
> > >
> > > Diffing in sysctl.c is tricky, using more context is recommended.
> > > suid_dumpable ended up in fs/ instead of kernel/ and the reason
> > > is likely a patch with too little context.
> > 
> > It's been in kernel/ since 2.6.13.  What will break if we move it?
> > 
> > This is security-related.  If we move it we risk unsecuring people's
> > machines...
> 
> only a very little bit since the default value is "secure", the option
> is to make it "insecure"...

OK, that's a good point.

> but yeah by this time we should just bite the bullet and rename the
> variable rather than move it about

That wouldn't help - we'll still break existing scripts.

crap.  I tend to think we leave it where it is - it's only a cosmetic
irritation, isn't it?
