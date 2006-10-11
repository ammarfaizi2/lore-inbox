Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161555AbWJKWLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161555AbWJKWLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJKWLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:11:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25305 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161555AbWJKWLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:11:48 -0400
Subject: Re: [patch 48/67] Fix VIDIOC_ENUMSTD bug
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@suse.de>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org,
       Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <452D6703.7070900@linuxtv.org>
References: <10090.1160603175@lwn.net>  <452D6703.7070900@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 11 Oct 2006 19:10:49 -0300
Message-Id: <1160604649.20624.4.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2006-10-11 às 17:49 -0400, Michael Krufky escreveu:
> Jonathan Corbet wrote:
> >> So any application which passes in index=0 gets EINVAL right off the bat
> >> - and, in fact, this is what happens to mplayer.  So I think the
> >> following patch is called for, and maybe even appropriate for a 2.6.18.x
> >> stable release.
> > 
> > The fix is worth having, though I guess I'm no longer 100% sure it's
> > necessary for -stable, since I don't think anything in-tree other than
> > vivi uses this interface in 2.6.18.
True. No real reason to fix into stable. On the other hand, it won't
hurt -stable to have this fix.

> > If you are going to include it,
> > though, it makes sense to put in Sascha's fix too - both are needed to
> > make the new v4l2 ioctl() interface operate as advertised.

> This is fine with me...  I have added cc to Mauro, he might want to add
> his sign-off as well.
By applying patch 48 into -stable, for sure Sascha fix is required.

> 
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

Cheers, 
Mauro.

