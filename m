Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263860AbUDZOMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbUDZOMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUDZOEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:04:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4841 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263868AbUDZNqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:46:37 -0400
Date: Mon, 26 Apr 2004 15:46:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 234976@bugs.debian.org,
       Roland Stigge <stigge@antcom.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040426134636.GB6285@atrey.karlin.mff.cuni.cz>
References: <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426121145.GA7610@gondor.apana.org.au> <opr62cbzp9ruvnp2@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr62cbzp9ruvnp2@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>come up with a more nuanced test? Better still, though, we should just  
> >>get
> >>proper AGP support for suspending and resuming in.
> >
> >It's got nothing to do with AGP.  This is a flaw in the swsusp code.
> >It can be triggered by anything that plays with page attributes.
> 
> Not so much a flaw in the suspend code as something that needs to be dealt  
> with: it's not a bug for pages to have protection, and its not a bug for  
> us to need it temporarily removed in order to do the copyback. We just  
> need the support in the drivers to achieve that. When we have it (as we do  
> in some cases in 2.4), all is well.

No, Herbert is right here. This *is* swsusp fault. Swsusp assumes 4MB
tables which is not guaranteed even on PSE machines. 
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
