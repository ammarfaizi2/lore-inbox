Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVA1Rz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVA1Rz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVA1Ryc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:54:32 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:35498 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261512AbVA1Rwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:52:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order memory allocations on suspend
Date: Fri, 28 Jan 2005 18:52:43 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>, hugang@soulinfo.com,
       Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200501281454.23167.rjw@sisk.pl> <20050128150756.1d6976cb@phoebee>
In-Reply-To: <20050128150756.1d6976cb@phoebee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281852.43689.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 28 of January 2005 15:07, Martin Zwickel wrote:
> > @@ -373,15 +377,22 @@
> >  
> >  static int write_pagedir(void)
> >  {
> > -	unsigned long addr = (unsigned long)pagedir_nosave;
> >  	int error = 0;
> > -	int n = SUSPEND_PD_PAGES(nr_copy_pages);
> > -	int i;
> > +	unsigned n = 0;
> > +	struct pbe * pbe;
> > +
> > +	printk( "Writing pagedir ...");
> > 
> > +
> > +	pr_debug("\b\b\bdone (%u pages)\n", n);
> 
> Just cosmetic:
> Why do you use pr_debug here instead of printk like you did above?

By mistake. :-)  Thanks!  

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
