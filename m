Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVAPPrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVAPPrC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVAPPrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:47:02 -0500
Received: from canuck.infradead.org ([205.233.218.70]:63249 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261523AbVAPPqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:46:51 -0500
Subject: Re: Testing optimize-for-size suitability?
From: Arjan van de Ven <arjan@infradead.org>
To: Steve Snyder <swsnyder@insightbb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501161040.12907.swsnyder@insightbb.com>
References: <200501161040.12907.swsnyder@insightbb.com>
Content-Type: text/plain
Date: Sun, 16 Jan 2005 16:46:43 +0100
Message-Id: <1105890403.8734.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 10:40 -0500, Steve Snyder wrote:
> Is there a benchmark or set of benchmarks that would allow me to test the 
> suitability of the CONFIG_CC_OPTIMIZE_FOR_SIZE kernel config option?
> 
> It seems to me that the benefit of this option is very dependant on the 
> amount of CPU cache installed, with the compiler code generation being a 
> secondary factor.  The use, or not, of CONFIG_CC_OPTIMIZE_FOR_SIZE is 
> basically an act of faith without knowing how it impacts my particular 
> environment.
> 
> I've got a Pentium4 CPU with 512KB of L2 cache, and I'm using GCC v3.3.3.  
> How can I determine whether or not CONFIG_CC_OPTIMIZE_FOR_SIZE should be 
> used for my system?

it also saves 400 kb of memory that can be used by the pagecache now...
that doesn't show in a microbenchmark but it's a quite sizable gain if
you remember that a disk seek is 10msec..that is a LOT of cpu cycles..

