Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVEONMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVEONMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 09:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVEONMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 09:12:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18068 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261595AbVEONMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 09:12:40 -0400
Subject: Re: [-mm patch] i386: enable REGPARM by default
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050515130008.GA72644@muc.de>
References: <20050515115712.GQ16549@stusta.de> <m1acmwadbp.fsf@muc.de>
	 <20050515123729.GT16549@stusta.de>  <20050515130008.GA72644@muc.de>
Content-Type: text/plain
Date: Sun, 15 May 2005 15:12:32 +0200
Message-Id: <1116162752.6270.23.camel@laptopd505.fenrus.org>
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


> 
> Yes, this means you cannot have binary compatible kernels compiled
> with different compilers. Which might be a bad thing. 

you already have that anyway!
There are several kernel data structures that have padding in them
ifdef'd on older gcc versions just to work around bugs; gcc2 -> gcc3 as
a result has a major different abi anyway so I don't think your argument
holds.. (and in 2.6, the gcc version is part of the VERMAGIC so the
exact compiler is enforced anyway)


