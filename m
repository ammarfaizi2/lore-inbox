Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUJDJdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUJDJdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 05:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUJDJdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 05:33:46 -0400
Received: from gprs214-21.eurotel.cz ([160.218.214.21]:59521 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267864AbUJDJdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 05:33:44 -0400
Date: Mon, 4 Oct 2004 11:33:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] -mm swsusp: copy_page is harmfull
Message-ID: <20041004093330.GA7614@elf.ucw.cz>
References: <200409292014.i8TKEhov023334@hera.kernel.org> <1096847414.23142.42.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096847414.23142.42.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	[PATCH] -mm swsusp: copy_page is harmfull
> > 	
> > 	From: Pavel Machek <pavel@ucw.cz>
> > 	
> > 	This is my fault from long time ago: copy_page can't be used for copying
> > 	task struct, therefore we can't use it in swsusp.
> 
> Hi !
> 
> Just curious, but why ?

Nigel already provided right explanation.

> It would be useful to have this in platform code, I don't see why I couldn't
> use copy_page() on ppc and I suspect it will be more efficient than memcpy
> since it has specific optimisations due to the fact that we are known to be
> fully aligned and the size of the copy is a constant aligned power of 2.

Hmm but does it matter? Is that operation really that slow on ppc?
This whole copy takes maybe second on x86, other operations are way
slower...
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
