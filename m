Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWFLK5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWFLK5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWFLK5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:57:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49551 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751846AbWFLK5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:57:18 -0400
Date: Mon, 12 Jun 2006 12:56:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060612105621.GA10887@elte.hu>
References: <20060608112306.GA4234@elte.hu> <1149840563.3619.46.camel@imp.csi.cam.ac.uk> <20060610075954.GA30119@elte.hu> <Pine.LNX.4.64.0606100916050.25777@hermes-1.csi.cam.ac.uk> <20060611053154.GA8581@elte.hu> <Pine.LNX.4.64.0606110739310.3726@hermes-1.csi.cam.ac.uk> <20060612083117.GA29026@elte.hu> <1150102041.24273.15.camel@imp.csi.cam.ac.uk> <20060612094011.GA32640@elte.hu> <1150107897.24273.25.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150107897.24273.25.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> > below i've attached a cleaned up version of my NTFS annotations so far. 
> > I think they are pretty straightforward and nonintrusive - for 
> > !CONFIG_LOCKDEP they add zero changes to ntfs.ko. Most of the linecount 
> > of the patch comes from comments - so i think we might even consider 
> > this a "document locking rules" patch :-)
> 
> Thanks, looks great!  Can I leave it to you to keep it as part of the 
> lock validator patches so it gets into -mm with them and later makes 
> it into the stock kernel with them?

sure!

> If you want, feel free to add:
> 
> Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
> 
> To the patch...

thanks - added.

If anyone wants to try the NTFS related lock-validator fixes, they are 
included in the combo patch:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc6-mm2.patch

which goes ontop of 2.6.17-rc6-mm2.

	Ingo
