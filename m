Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVC2PHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVC2PHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVC2PHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:07:49 -0500
Received: from colin2.muc.de ([193.149.48.15]:37389 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262305AbVC2PHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:07:24 -0500
Date: 29 Mar 2005 17:07:21 +0200
Date: Tue, 29 Mar 2005 17:07:21 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: folkert@vanheusden.com, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329150721.GB63268@muc.de>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de> <424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de> <20050327185500.GP943@vanheusden.com> <424900BC.8030109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424900BC.8030109@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 02:16:12AM -0500, Jeff Garzik wrote:
> folkert@vanheusden.com wrote:
> >>>pool.  The consensus was that the FIPS testing should be moved to 
> >>>userspace.
> >>
> >>Consensus from whom? And who says the FIPS testing is useful anyways?
> >>I think you just need to trust the random generator, it is like
> >>you need to trust any other piece of hardware in your machine. Or do you 
> >>check regularly if you mov instruction still works? @)
> >
> >
> >For joe-user imho it's better to do a check from a cronjob once a day. But 
> >for
> 
> That would not catch the hardware failures seen in the field, in the past.

I am sure that all hardware in the field has failed in the past
at some point - but that still does not mean we dont trust
hardware in Linux. There simply is no choice.

I think we have a case here of the perfect being the enemy of the good.

I just want a simple solution that works for near all users out of 
the box without needing resource eating and hard to configure daemons
of dubious value.

You are extrapolating from extremly unlikely events and think
it makes sense to handle them - which I think is wrong.

The cronjob once a day or once an hour setup should catch
the hardware failures anyways, and for shorter time amounts
the random buffer in the kernel can handle bad input.

-Andi (who should probably just resubmit the patch)
