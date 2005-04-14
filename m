Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVDNGvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVDNGvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 02:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDNGvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 02:51:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40121 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261438AbVDNGvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 02:51:47 -0400
Date: Thu, 14 Apr 2005 08:51:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andreas Steinmetz <ast@domdv.de>,
       rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414065124.GA1357@elf.ucw.cz>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au> <20050413232431.GF27197@elf.ucw.cz> <20050413233904.GA31174@gondor.apana.org.au> <20050413234602.GA10210@elf.ucw.cz> <20050414003506.GQ25554@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414003506.GQ25554@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > The ssh keys are *encrypted* in the swap when dmcrypt is used.
> > > > > When the swap runs over dmcrypt all writes including those from
> > > > > swsusp are encrypted.
> > > > 
> > > > Andreas is right. They are encrypted in swap, but they should not be
> > > > there at all. And they are encrypted by key that is still available
> > > > after resume. Bad.
> > > 
> > > The dmcrypt swap can only be unlocked by the user with a passphrase,
> > > which is analogous to how you unlock your ssh private key stored
> > > on the disk using a passphrase.
> > 
> > Once more:
> > 
> > Andreas' implementation destroys the key during resume.
> 
> This solution is all wrong.
> 
> If you want security of the suspend image while "suspended", encrypt
> with dm-crypt. If you want security of the swap image after resume,
> zero out the portion of swap used. If you want both, do both.

I want security of the swap image, and "just zeroing" is hard to do in
failed suspend case, see previous discussion.

Andreas, do you think you could write nice, long, FAQ entries so that
we don't have to go through this discussion over and over?

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
