Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVB1O0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVB1O0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVB1OZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:25:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2789 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261639AbVB1OWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:22:34 -0500
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
From: Arjan van de Ven <arjan@infradead.org>
To: colbuse@ensisun.imag.fr
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1109599275.4223242b6b560@webmail.imag.fr>
References: <1109596437.422319158044b@webmail.imag.fr>
	 <20050228132849.B16460@flint.arm.linux.org.uk>
	 <1109599275.4223242b6b560@webmail.imag.fr>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 15:22:22 +0100
Message-Id: <1109600542.6298.100.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -               for(npar = 0 ; npar < NPAR ; npar++)
> +               for(npar = NPAR - 1; npar >= 0; npar--)
>                         par[npar] = 0;

if you really want to clean this up.. why not use memset() instead ?

