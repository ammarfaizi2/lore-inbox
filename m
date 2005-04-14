Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVDNIuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVDNIuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVDNIuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:50:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33513 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261474AbVDNIuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:50:14 -0400
Subject: Re: encrypted swap (was Re: [PATCH encrypted swsusp 1/3] core
	functionality)
From: Arjan van de Ven <arjan@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andy Isaacson <adi@hexapodia.org>, Pavel Machek <pavel@ucw.cz>,
       Andreas Steinmetz <ast@domdv.de>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050414083801.GA13540@gondor.apana.org.au>
References: <20050413233904.GA31174@gondor.apana.org.au>
	 <20050414083119.GB24892@hexapodia.org>
	 <20050414083801.GA13540@gondor.apana.org.au>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 10:49:51 +0200
Message-Id: <1113468592.6293.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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


> 
> >  * the key is automatically regenerated every 2 hours (or whatever); as
> >    pages encrypted under the old key age out, it can be freed eventually
> 
> This'll require changes to dmcrypt but it's doable.

but it's not useful since linux actually generally keeps the pages also
in swap even when they're back in memory (so that if there's memory
pressure again they can just be swapped out cheap again), this leads to
very very long lived swap pages


