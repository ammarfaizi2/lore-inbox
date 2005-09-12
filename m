Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVILKHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVILKHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVILKHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:07:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750701AbVILKHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:07:37 -0400
Date: Mon, 12 Sep 2005 03:03:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, vojtech@suse.cz,
       dwmw2@infradead.org, netdev@vger.kernel.org, benjamin_kong@ali.com.tw,
       dagb@cs.uit.no, jgarzik@pobox.com, davidm@snapgear.com,
       twoller@crystal.cirrus.com, alan@redhat.com, mm@caldera.de,
       scott@spiteful.org, jsimmons@transvirtual.com
Subject: Re: pm_register should die
Message-Id: <20050912030306.42a73f62.akpm@osdl.org>
In-Reply-To: <20050912095532.GA27763@elf.ucw.cz>
References: <20050912093456.GA29205@elf.ucw.cz>
	<20050912024145.3c4298ec.akpm@osdl.org>
	<20050912095323.GD27583@elf.ucw.cz>
	<20050912095532.GA27763@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > > +#ifdef CONFIG_OLD_PM
> > > >   	if (pm_send_all(PM_SUSPEND, (void *)3)) {
> > > 
> > > Can we not do this without ifdefs?
> > > 
> > > #define pm_send_all(foo, bar) 0
> > 
> > Okay, we probably can, but the ifdefs make very nice/easy markers
> > "this is going away". I'd prefer to actually delete all the code
> > inside those ifdefs...
> > 
> > I agree this patch can be improved... I hope I can get people to fix
> > those 13 occurences and be able to just drop everything in #ifdef
> > _OLD_PM.
> 
> There's another reason: they are ifdef-ed out so that you don't see
> "obsolete function called" warning. Breaking the function and hiding
> the warning at same time would seem like a wrong thing to do. If
> someone does pm_send_all in his code, we want him to see the warning.
> 

Fair enough.

