Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTE2Qx1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTE2QxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:53:17 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:26126 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262378AbTE2Qwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:52:50 -0400
Date: Thu, 29 May 2003 14:06:22 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030529170621.GX24054@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	chas williams <chas@cmf.nrl.navy.mil>, davem@redhat.com,
	linux-kernel@vger.kernel.org
References: <20030529162125.GU24054@conectiva.com.br> <200305291632.h4TGWwsG022510@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305291632.h4TGWwsG022510@ginger.cmf.nrl.navy.mil>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 29, 2003 at 12:31:17PM -0400, chas williams escreveu:
> In message <20030529162125.GU24054@conectiva.com.br>,Arnaldo Carvalho de Melo w
> rites:
> >> @@ -189,7 +187,7 @@
> >>  #define HE_SPIN_LOCK(dev, flags)	spin_lock_irqsave(&(dev)->global_lock, 
> >flags)
> >>  #define HE_SPIN_UNLOCK(dev, flags)	spin_unlock_irqrestore(&(dev)->global_l
> >ock, flags)
> >
> >Is the above really needed?
> 
> well, according to the programmer's guide:

no, no, I was talking just about the need for HE_SPIN_LOCK wrapper, not the
locking, i.e. couldn't it be just:

spin_lock_irqsave(&dev->global_lock, flags)

used so that it is clear that it is a irqsave variation, etc?

- Arnaldo
