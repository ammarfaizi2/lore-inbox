Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVGLIR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVGLIR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVGLIR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:17:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46731 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261253AbVGLIR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:17:57 -0400
Subject: Re: tg3 fails with x86_64 (but works with i386)
From: Arjan van de Ven <arjan@infradead.org>
To: Frank Steiner <fsteiner-mail1@bio.ifi.lmu.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, davem@redhat.com,
       jgarzik@pobox.com
In-Reply-To: <42D379D6.5080705@bio.ifi.lmu.de>
References: <42D22059.8000607@bio.ifi.lmu.de>
	 <42D379D6.5080705@bio.ifi.lmu.de>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 10:17:45 +0200
Message-Id: <1121156266.3171.14.camel@laptopd505.fenrus.org>
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

On Tue, 2005-07-12 at 10:05 +0200, Frank Steiner wrote:
> Frank Steiner wrote
> 
> > Hi,
> > 
> > I've two 3com 3C996B-T network cards (lspci says it's
> > a Broadcom BCM5701 chip) in Asus A8V boards with an
> > AMD64 4000+ cpu. Booting a x86_64 version of the
> > 2.6.12.2 kernel, the tg3 module complains
> > 
> >    tg3.c: v3.31 (June 8, 2005)
> >    tg3_test_dma() Write the buffer failed -19
> >    tg3: DMA engine test failed, aborting.
> 
> 
> I could solve this: The A8V boards have (like all 64bit boards I guess?)
> an option for memory remapping around the memory hole at 3.5GB. When
> this remapping is activated, the tg3 driver fails with the error message
> above. If the remapping is deactivated, the driver and the card work fine
> (but linux can only work with 3.7 of the 4GB). But I need to have the
> remapping deactivated anyway, because the fglrx driver won't work
> either otherwise.


you were using a binary kernel module but didn't mention it in your
report? tsk tsk...



