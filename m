Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVC1PUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVC1PUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVC1PUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:20:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:13843 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261851AbVC1PUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:20:44 -0500
Date: 28 Mar 2005 17:20:43 +0200
Date: Mon, 28 Mar 2005 17:20:43 +0200
From: Andi Kleen <ak@muc.de>
To: folkert@vanheusden.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050328152043.GA26121@muc.de>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de> <424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de> <20050327185500.GP943@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327185500.GP943@vanheusden.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 08:55:03PM +0200, folkert@vanheusden.com wrote:
> > > pool.  The consensus was that the FIPS testing should be moved to userspace.
> > Consensus from whom? And who says the FIPS testing is useful anyways?
> > I think you just need to trust the random generator, it is like
> > you need to trust any other piece of hardware in your machine. Or do you 
> > check regularly if you mov instruction still works? @)
> 
> For joe-user imho it's better to do a check from a cronjob once a day. But for
> high demand security, maybe make it pluggable? Like that a user can plug-in some
> module which does the testing? Then you can have several kinds of tests
> depending on your needs.

In my old 2.4 patch there was a sysctl to turn off the kernel reseeding.
If you turn it off you can do it in user space. That might be
an option for the clinical paranoid. 

BTW what do you do when the FIPS test fails? I dont see a good fallback
path for this case.

-Andi

