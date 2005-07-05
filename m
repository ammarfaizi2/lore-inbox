Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVGELdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVGELdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 07:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVGELdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 07:33:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7559 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261803AbVGELXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 07:23:14 -0400
Subject: Re: [PATCH] Avoid to use kmalloc in usb/core/message.c
From: Arjan van de Ven <arjan@infradead.org>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Masatake YAMATO <jet@gyve.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507051236.37288.duncan.sands@math.u-psud.fr>
References: <20050705.191221.92572119.jet@gyve.org>
	 <200507051236.37288.duncan.sands@math.u-psud.fr>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 13:22:46 +0200
Message-Id: <1120562571.3180.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Tue, 2005-07-05 at 12:36 +0200, Duncan Sands wrote:
> > I wonder why the invocations of kmalloc are needed in these functions.
> 
> Because some architectures can't do DMA to/from the stack.

doing dma to/from kmalloc also isn't too nice... should be using
dma_alloc_*() API I guess


