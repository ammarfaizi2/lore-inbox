Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVILJxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVILJxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVILJxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:53:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21438 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751283AbVILJxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:53:47 -0400
Date: Mon, 12 Sep 2005 11:53:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@osdl.org,
       vojtech@suse.cz, dwmw2@infradead.org, netdev@vger.kernel.org,
       benjamin_kong@ali.com.tw, dagb@cs.uit.no, jgarzik@pobox.com,
       davidm@snapgear.com, twoller@crystal.cirrus.com, alan@redhat.com,
       mm@caldera.de, scott@spiteful.org, jsimmons@transvirtual.com
Subject: Re: pm_register should die
Message-ID: <20050912095323.GD27583@elf.ucw.cz>
References: <20050912093456.GA29205@elf.ucw.cz> <20050912024145.3c4298ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912024145.3c4298ec.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +#ifdef CONFIG_OLD_PM
> >   	if (pm_send_all(PM_SUSPEND, (void *)3)) {
> 
> Can we not do this without ifdefs?
> 
> #define pm_send_all(foo, bar) 0

Okay, we probably can, but the ifdefs make very nice/easy markers
"this is going away". I'd prefer to actually delete all the code
inside those ifdefs...

I agree this patch can be improved... I hope I can get people to fix
those 13 occurences and be able to just drop everything in #ifdef
_OLD_PM.

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
