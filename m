Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVC2MSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVC2MSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVC2MP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:15:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13735 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262238AbVC2MNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:13:49 -0500
Date: Tue, 29 Mar 2005 14:13:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329121332.GL3897@elf.ucw.cz>
References: <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <20050329102104.GB6496@elf.ucw.cz> <20050329103049.GB19541@gondor.apana.org.au> <1112093428.5243.88.camel@uganda> <20050329104627.GD19468@gondor.apana.org.au> <1112096525.5243.98.camel@uganda> <20050329113921.GA20174@gondor.apana.org.au> <1112098517.5243.102.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112098517.5243.102.camel@uganda>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > > Well if you can demonstrate that you're getting a higher rate of
> > > > throughput from your RNG by doing this in kernel space vs. doing
> > > > it in user space please let me know.
> > > 
> > > While raw bits reading from hw_random on the fastest 
> > > VIA boards can exceed 55mbits per second 
> > > [above quite was taken from VIA C3 Nehemiah analysis], 
> > > it is not evaluated in rngd and is not written 
> > > back to the /dev/random.
> > 
> > Well when you get 55mb/s from /dev/random please get back to me.
> 
> I cant, noone writes 55mbit into it, but HW RNG drivers could. :)

Exactly, on via machines, it might be good idea to hook /dev/random
directly to hardware random generator... that should give you
55mbit/sec.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
