Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVF3Nq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVF3Nq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVF3Nq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:46:26 -0400
Received: from verein.lst.de ([213.95.11.210]:2513 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262608AbVF3NqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:46:20 -0400
Date: Thu, 30 Jun 2005 15:46:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Christoph Hellwig <hch@lst.de>, cotte@de.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xip cleanups
Message-ID: <20050630134614.GA14397@lst.de>
References: <20050628120159.GA1745@lst.de> <20050628124029.GB7460@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628124029.GB7460@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 02:40:29PM +0200, J?rn Engel wrote:
> I personally prefer the original code.  As a general rule, error
> handling code is indented further than regular good-case code.  That
> makes reading a *lot* faster and the compiler should be smart enough
> to generate identical code.

ok..  the cast removal is also wrong as Arnd pointed out, btw.

> > -		(mapping->host,tmp.b_blocknr*(PAGE_SIZE/512) ,&data);
> > +		(mapping->host,tmp.b_blocknr * (PAGE_SIZE/512), &data);
>                                ^
> You missed one.

feel free to add it :)

