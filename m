Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTE2SUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTE2SUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:20:46 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:37903 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262483AbTE2SUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:20:45 -0400
Date: Thu, 29 May 2003 15:34:24 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030529183424.GE24054@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	chas williams <chas@cmf.nrl.navy.mil>, davem@redhat.com,
	linux-kernel@vger.kernel.org
References: <20030529162125.GU24054@conectiva.com.br> <200305291810.h4TIAdsG024042@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305291810.h4TIAdsG024042@ginger.cmf.nrl.navy.mil>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 29, 2003 at 02:08:59PM -0400, chas williams escreveu:
> In message <20030529162125.GU24054@conectiva.com.br>,Arnaldo Carvalho de Melo w
> rites:
> >> @@ -1067,46 +1044,39 @@
> >>  	 */
> >>  
> >>  	/* 4.3 pci bus controller-specific initialization */
> >> -	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0)
> >> -	{
> >> +	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0) {
> >>  		hprintk("can't read GEN_CNTL_0\n");
> >
> >Humm, shouldn't we release the irq here? What about using gotos for exception
> >handing?
> 
> what irq?  the irq is grabbed in he_init_irq.  if he_start() fails, we 
> call he_stop() and it frees the irq.

OK sir, sorry for the noise on this one :-)
