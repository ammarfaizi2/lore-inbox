Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTE2RXA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTE2RXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:23:00 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:47886 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262426AbTE2RW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:22:59 -0400
Date: Thu, 29 May 2003 14:36:37 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030529173637.GZ24054@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	chas williams <chas@cmf.nrl.navy.mil>, davem@redhat.com,
	linux-kernel@vger.kernel.org
References: <20030529170621.GX24054@conectiva.com.br> <200305291713.h4THDssG023347@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305291713.h4THDssG023347@ginger.cmf.nrl.navy.mil>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 29, 2003 at 01:12:13PM -0400, chas williams escreveu:
> In message <20030529170621.GX24054@conectiva.com.br>,Arnaldo Carvalho de Melo w
> rites:
> >no, no, I was talking just about the need for HE_SPIN_LOCK wrapper, not the
> >locking, i.e. couldn't it be just:
> >
> >spin_lock_irqsave(&dev->global_lock, flags)
> >
> >used so that it is clear that it is a irqsave variation, etc?
> 
> i suppose i could change it all back.  at one point, he_spin_lock()
> was 'optmized' away on non smp machines (since a single cpu doesnt
> tickle the particular h/w problem). 
> 
> i didnt want a ton of #ifdef CONFIG_SMP in the driver.

Sure thing, but hey, spin_lock_irqsave and friends take care of how to behave
when in up or smp, i.e. its how all the other drivers use spinlocks 8)

- Arnaldo
