Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVBSPoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVBSPoE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 10:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVBSPoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 10:44:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25014 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261729AbVBSPn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 10:43:59 -0500
Subject: Re: [2.6 patch] drivers/net/smc-mca.c: cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050219152300.GF1850@alpha.home.local>
References: <20050219083431.GN4337@stusta.de> <4216FBCB.8040807@pobox.com>
	 <1108804140.6304.67.camel@laptopd505.fenrus.org>
	 <20050219152300.GF1850@alpha.home.local>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 16:43:50 +0100
Message-Id: <1108827830.6304.120.camel@laptopd505.fenrus.org>
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


> > > This comment is applicable to similar changes, also.  Use 'const' 
> > > whenever possible.
> > 
> > does that even have meaning in C? In C++ it does, but afaik in C it
> > doesn't.
> 
> Yes it does. Often the variables declared this way will go into the text
> section which is marked read-only.

true. Doesn't mean too much for the kernel right now (in kernel space
not a lot of memory is really read only) though.

>  I've used this technique in a few very
> small programs to reduce their size (I could strip off both their bss and
> data sections to save space). Also, I believe that the compiler is able
> to optimize code using consts, but this is pure speculation, I've not
> verified it.

Afaik that's the main difference between C and C++; in C you can still
change "const" variables... in C++ thats illegal (at least that's what I
remember and google seems to support somewhat ;)


