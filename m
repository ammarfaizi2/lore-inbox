Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVFII1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVFII1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVFII1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:27:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:47810 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262332AbVFII1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:27:12 -0400
Date: Thu, 9 Jun 2005 10:27:10 +0200
From: Karsten Keil <kkeil@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Adam Belay <abelay@novell.com>, greg@kroah.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050609082710.GA9847@pingi3.kke.suse.de>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Adam Belay <abelay@novell.com>, greg@kroah.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de> <20050607205800.GB8300@neo.rr.com> <1118190373.6850.85.camel@gaston> <1118196980.3245.68.camel@localhost.localdomain> <20050608122320.GC1898@elf.ucw.cz> <1118271605.6850.137.camel@gaston> <20050609000402.GA2694@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609000402.GA2694@elf.ucw.cz>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 09, 2005 at 02:04:02AM +0200, Pavel Machek wrote:
...
> 
> > > You passed invalid argument; I see no reason why you should paper over
> > > it and risk continuing. This happens during system suspend; it is
> > > quite possible that user will not see your printk when machine powers
> > > off just after that; and remember that it will not be in syslog after
> > > resume.
> > 
> > Crap. I don't think a BUG() makes any useful help neither in this place,
> > and when I locally turn PMSG_FREEZE to something sane I suddenly blow up
> > in there (and I wonder in how many other places).
> 
> At least you can see & report that error... That would not be a case
> for simple printk.
> 

Yes, but BUG() should not used for that, IMHO BUG() should be used only for
critical situation, in which you cannot do anything and here is danger to
lost data, I don't think this is the case here, but the BUG() will crash the
machine and so you might be loose data, which is not nice to do, for only to
request a report. Yes printk only is ignored by many people, but here are
always some, who will report it.

-- 
Karsten Keil
SuSE Labs
ISDN development
