Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbSJAPP6>; Tue, 1 Oct 2002 11:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSJAPP6>; Tue, 1 Oct 2002 11:15:58 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:59779 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261705AbSJAPP4>;
	Tue, 1 Oct 2002 11:15:56 -0400
Date: Tue, 1 Oct 2002 16:24:28 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Art Haas <ahaas@neosoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmalloc.c patch for 2.4.20-pre8-ac3
Message-ID: <20021001152428.GB126@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Art Haas <ahaas@neosoft.com>, linux-kernel@vger.kernel.org
References: <20021001004432.GA4230@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001004432.GA4230@debian>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 07:44:32PM -0500, Art Haas wrote:

 > --- linux-2.4.20-pre8-ac3/mm/vmalloc.c.ac3	2002-09-30 18:27:42.000000000 -0500
 > +++ linux-2.4.20-pre8-ac3/mm/vmalloc.c	2002-09-30 13:59:30.000000000 -0500
 > @@ -179,7 +179,7 @@
 >  
 >  	size += PAGE_SIZE;
 >  	if (!size) {
 > -		kfree (addr);
 > +		kfree (area);
 >  		return NULL;
 >  	}

Ick, that's my bad. Fix is correct, though davem suggested testing
for -PAGE_SIZE before we do the kmalloc would be cleaner.
I tend to agree, but didn't get around to doing it.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
