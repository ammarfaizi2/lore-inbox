Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWH1QZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWH1QZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWH1QZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:25:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9665 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751177AbWH1QZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:25:51 -0400
Date: Mon, 28 Aug 2006 18:25:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Auke Kok <auke-jan.h.kok@intel.com>, jakub@redhat.com, davem@redhat.com
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john.ronciak@intel.com, jesse.brandeburg@intel.com
Subject: Re: e1000 driver contains private copy of GPL... and modified one, too
Message-ID: <20060828162539.GC30105@elf.ucw.cz>
References: <20060827082534.GA2397@elf.ucw.cz> <44F30B25.2030906@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F30B25.2030906@intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Okay, so modifications are not major: different address of free
> >software foundation, completely different formatting, some characters
> >added, and some characters removed. It no longer contains Linus'
> >clarifications.
> >
> >--- LICENSE     2006-07-21 05:42:27.000000000 +0200
> >+++ ../../../COPYING    2006-07-21 05:42:27.000000000 +0200
> >@@ -1,128 +1,141 @@

> >Now... I believe nothing evil is going on, but having two slightly
> >different copies of GPL in one source seems wrong, can we get rid of
> >e1000 one?
> 
> I'll ask around here and see if this doesn't make people cringe. Meanwhile 
> Pavel should examine sound/oss/COPYING and arch/sparc/lib/COPYING.LIB too :)

Hehe, okay, going after them.

sparc64 lib:  this is actually LGPL, but I'm not sure what it applies
to. If specific files are under LGPL, I guess they should say that in
headers... Plus, not *all* files seems like LGPLed to me:

atomic32.c: * Based on asm-parisc/atomic.h Copyright (C) 2000 Philipp Rumpf

...I do not think atomic.h from parisc was LGPL. Dave?

oss/COPYING... I guess we can just remove that one. I do not think we
have maintainer for OSS. Should I submit deleting patch for Andrew, or
Andrew, can you just rm sound/oss/COPYING?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
