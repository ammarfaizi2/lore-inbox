Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWHVNpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWHVNpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHVNpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:45:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33975 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932252AbWHVNpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:45:53 -0400
Subject: Re: [PATCH] paravirt.h
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <1156254965.27114.17.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 22 Aug 2006 15:45:22 +0200
Message-Id: <1156254322.2976.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 14:56 +0100, Alan Cox wrote:
> Ar Iau, 2006-08-10 am 11:06 -0700, ysgrifennodd Jeremy Fitzhardinge:
> > Rusty Russell wrote:
> > > +EXPORT_SYMBOL_GPL(paravirt_ops);
> > >   
> > This should probably be EXPORT_SYMBOL(), otherwise pretty much every 
> > driver module will need to be GPL...
> 
> It would be nice not to export it at all or to protect it, paravirt_ops
> is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
> is properly protected, its an unpleasantly large security target if not.
> 
> It would be a lot safer if we could have the struct paravirt_ops in
> protected read-only const memory space, set it up in the core kernel
> early on in boot when we play "guess todays hypervisor" and then make
> sure it stays in read only (even to kernel) space.

this would need a "const after boot" section; which is really not hard
to make and probably useful for a lot more things.... todo++


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

