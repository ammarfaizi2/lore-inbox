Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWJLTIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWJLTIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWJLTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:08:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52692 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750995AbWJLTIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:08:52 -0400
Subject: Re: [PATCH] SPI: improve sysfs compiler complaint handling
From: Arjan van de Ven <arjan@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610121146.09229.david-b@pacbell.net>
References: <20061012014920.GA13000@havoc.gtf.org>
	 <200610121108.59727.david-b@pacbell.net>
	 <20061012112449.e9bb7e12.akpm@osdl.org>
	 <200610121146.09229.david-b@pacbell.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 21:08:46 +0200
Message-Id: <1160680127.3000.471.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > Who wrote all this stuff, and what were they thinking?
> 
> I suspect what they were thinking was the old "if you can't figure out
> how to handle the error, don't test for it" thing. 

the __must_check gcc feature was primarily designed to mark security
sensitive API's (such as copy_from_user) where you really do have to
check. Or cases where not checking/using is always a bug (realloc() in
userspace comes to mind).

It's OUR choice to mark the sysfs functions with this semantic, if we
don't want this strict warning we shouldn't use this attribute.

Based on many of the things that showed up so far, and Andrews comments,
I sort of get the feeling we DO want this behavior though...


