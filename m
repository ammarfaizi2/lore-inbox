Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWGIWrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWGIWrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGIWrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:47:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65154 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932404AbWGIWre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:47:34 -0400
Date: Mon, 10 Jul 2006 00:47:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
Message-ID: <20060709224700.GA1707@elf.ucw.cz>
References: <20060708145541.GA2079@elf.ucw.cz> <1152380199.27368.9.camel@localhost.localdomain> <20060708104100.af5dcbd8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708104100.af5dcbd8.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ide2: I/O resource 0xF887E00E-0xF887E00E not free.
> > > ide2: ports already in use, skipping probe
> > > ide2: I/O resource 0xF887E01E-0xF887E01E not free.
> > > ide2: ports already in use, skipping probe
> > 
> > 
> > Looks like ioremap values not I/O ports. Probably the various IDE layer
> > changes from 2.6.17-mm.
> > 
> > My first guess would be the PCMCIA layer changes to use mmio ports are
> > not setting hwif->mmio (I think its ->mmio) to 2 and doing their own
> > resource management.
> > 
> 
> 5040cb8b7e61b7a03e8837920b9eb2c839bb1947 looks like a good one to try
> reverting.

2.6.18-rc1-mm1 works okay. Is that enough, or do you want me to try
reverting just this patch?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
