Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVIMMM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVIMMM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVIMMM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:12:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55987 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932624AbVIMMM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:12:58 -0400
Date: Tue, 13 Sep 2005 14:12:26 +0200
From: Pavel Machek <pavel@suse.cz>
To: David McCullough <davidm@snapgear.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>,
       vojtech@suse.cz, dwmw2@infradead.org, netdev@vger.kernel.org,
       benjamin_kong@ali.com.tw, dagb@cs.uit.no, jgarzik@pobox.com,
       twoller@crystal.cirrus.com, alan@redhat.com, mm@caldera.de,
       scott@spiteful.org, jsimmons@transvirtual.com
Subject: Re: pm_register should die
Message-ID: <20050913121226.GC2716@elf.ucw.cz>
References: <20050912093456.GA29205@elf.ucw.cz> <20050913000335.GA10418@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913000335.GA10418@beast>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > pm_register has been obsoleted by driver model, and it was deprecated
> > quite long time ago. There are only 13 users left.
> > 
> > Attached is a patch that makes pm_register config-option, so that we
> > don't get the warnings on sane systems. Pretty please, remove usage of
> > pm_register from your subsystem.
> > 
> > IRDA has no usefull MAINTAINER entry; it would be nice if that could
> > be fixed. Alan is best contact I could find for ad1848... does someone
> > care about that driver, anyway? nm256_audio is written by
> > anonymous. Wonderfull...
> > 
> > Okay, it seems to me only users that matter are mtdcore, 3c509 and
> > maybe h3600_ts_input. After those are fixed, it should be okay to just
> > config it out/remove pm_register completely.
> 
> Feel free to clean out pm_register usage in:
> 
> 	drivers/serial/68328serial.c
> 
> there's not much in there that cannot be added later if actually required,

I'd rather have someone who actually has that hardware to convert it
to driver model and test properly.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
