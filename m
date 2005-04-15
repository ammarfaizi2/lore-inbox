Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVDOSRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVDOSRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVDOSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:17:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54433 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261906AbVDOSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:16:22 -0400
Subject: Re: Adaptec 2010S i2o + x86_64 doesn't work
From: Arjan van de Ven <arjan@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <426003AB.3060904@shadowconnect.com>
References: <20050413160352.GA12841@xs4all.net>
	 <1113576775.11116.17.camel@localhost.localdomain>
	 <1113581722.14421.15.camel@zahadum.xs4all.nl>
	 <1113587286.11114.30.camel@localhost.localdomain>
	 <426003AB.3060904@shadowconnect.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 20:16:11 +0200
Message-Id: <1113588972.6694.78.camel@laptopd505.fenrus.org>
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

On Fri, 2005-04-15 at 20:10 +0200, Markus Lidel wrote:
> Hello,
> 
> Alan Cox wrote:
> > On Gwe, 2005-04-15 at 17:15, Miquel van Smoorenburg wrote:
> >>However, I removed 2 GB from the box as Alan sugggested and now the box
> >>comes up just fine with a 64-bit 2.6.11.6 kernel! I've put the 4GB back,
> >>and booted with the kernel "mem=2048" command line option - that also
> >>works, the i2o_block driver sees the adaptec controller just fine.
> >>And I just booted it with "mem=3840M" and that works too.
> >>So the problem appears to be 4 GB memory in 64 bit mode, on this box.
> 
> OK, i never tried it with 4 GB so it really could be a problem...
> 
> > Or the driver is incorrectly handling 64/32bit DMA limit masks which
> > would be my first guess here, and would explain why it works on AMD
> > Athlon64 boxes.
> 
> Hmmm, i only set DMA_32BIT_MASK and don't do anything special on 64-bit 
> systems... Is there anything else to do for correct DMA mapping?


are you sure the HW isn't 31 bit by accident ? 

