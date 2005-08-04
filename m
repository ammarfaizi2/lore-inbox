Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVHDNgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVHDNgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVHDNgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:36:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50894 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262529AbVHDNfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:35:54 -0400
Subject: Re: [PATCH] IPMI driver update part 1, add per-channel IPMB
	addresses
From: Arjan van de Ven <arjan@infradead.org>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42F216F7.6070604@acm.org>
References: <42F14AC9.2060109@acm.org>
	 <20050803225954.27aa6ffd.akpm@osdl.org>  <42F216F7.6070604@acm.org>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 15:35:09 +0200
Message-Id: <1123162509.3318.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Be aware that this function will use more stack space than it needs to: gcc
> >will create a separate stack slot for all the above locals.
> >
> >Hence it would be better to declare them all at the start of the function. 
> >Faster, too - less dcache footprint.
> >
> >Maybe not as nice from a purist point of view, but it does allow you to
> >lose those braces in the switch statement...
> >  
> >
> Hmm, I assumed that gcc would optimize and allocate the stack as it 
> needed it without waste.  Ok, easy enough to fix.

latest gcc does the right thing; older gcc don't though.


