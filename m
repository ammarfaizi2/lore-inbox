Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWIKIFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWIKIFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIKIFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:05:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11155 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751197AbWIKIFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:05:17 -0400
Date: Mon, 11 Sep 2006 10:04:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: swsusp problem
Message-ID: <20060911080458.GB1898@elf.ucw.cz>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org> <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org> <20060910194955.GA1841@elf.ucw.cz> <200609102054.34350.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609102054.34350.dtor@insightbb.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >What kind of machine is that? What cpu? Really 486?
> > > 
> > > yes, it's viglen dossier 486 based laptop .
> > 
> > Forget it, this thing does not support 4MB pages, and swsusp currently
> > needs them. (We'll need to fix that, but not now -- fix is port of
> > page-table handling code from x86-64).
> > 
> > It should die with
> > 
> >         if (!cpu_has_pse) {
> >                 printk(KERN_ERR "PSE is required for swsusp.\n");
> >                 return -EPERM;
> >         }
> > 
> > ...can you investigate why it does not?
> > 
> 
> Probably because of this:

Oops, aha, really? I thought only pentium+ supported 4MB tables?

Does it also support cr4? Anyway, someone interested in history needs
to play with this one ;-).

> > > flags : fpu vme pse
>                     ^^^

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
