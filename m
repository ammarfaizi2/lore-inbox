Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVAURsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVAURsk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVAURsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:48:40 -0500
Received: from gprs215-210.eurotel.cz ([160.218.215.210]:31131 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262433AbVAURsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:48:35 -0500
Date: Fri, 21 Jan 2005 18:48:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: hugang@soulinfo.com, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050121174812.GA19551@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <20050121022348.GA18166@hugang.soulinfo.com> <20050121103028.GF18373@elf.ucw.cz> <200501211442.55274.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501211442.55274.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, it is still too big to merge directly. Would it be possible to
> > get mod_printk_progress(), introduce *_for_each (but leave there old
> > implementations), introduce pagedir_free() (but leave old
> > implementation). Better collision code should already be there, that
> > should make patch smaller, too. Try not to move code around.
> 
> I have a suggestion.
> 
> hugang, you are currently replacing an array of pbes with a list of arrays
> of pbes contained within individual pages.

Looks good to me. You still want to be able to loop over pages (for
relocation etc), but code is going to get a lot cleaner.

Oh be warned that last pointer on the page is used to linking pages
together on-disk.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
