Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVENOYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVENOYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 10:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVENOYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 10:24:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45955 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262665AbVENOYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 10:24:36 -0400
Subject: [Fwd: SMP Large Buffers]
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: matt@finaldraftbooks.com
Content-Type: text/plain
Date: Sat, 14 May 2005 16:24:32 +0200
Message-Id: <1116080673.6007.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

-------- Forwarded Message --------
> From: Matthew Singer <matt@finaldraftbooks.com>
> Reply-To: matt@finaldraftbooks.com
> To: 'linux-kernel-Mailing-list' <linux-kernel@vger.kernel.org>, linux-
> smp@vger.kernel.org
> Subject: SMP Large Buffers
> Date: Sat, 14 May 2005 10:06:34 -0400
> I'm working with a driver that needs dma buffers larger than 128K.  The
> system is a 2 processor SMP with 2 gig total ram.
> 
> Using GRUB, we set mem= to be 1984M, leaving 64M reserved.
> 
> doing  ioremap(0x7c000000, 0x4000000)
>        followed by an access to x7c000000 results in an OOPS.

well you have to access the result of the ioremap, not it's argument!


