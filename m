Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWJ3DHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWJ3DHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbWJ3DHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:07:10 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:26234 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030454AbWJ3DHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:07:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=JICkDQ4jmRxjt8ER9zCg/OU6YADZK5JWCGx86Tu2TzfQb9TgZd3vOpSWa6Pk9dSdjwdm7hpJZNVZmtTuhwHipH/MUoK4rIMqcibsuf364KLPFeAi/VLYLdpzxhH0cCvrarxPOJ1ZX4vWOn0wjyYBiE65Trgn6OW2cmeaJMtjNWw=  ;
From: David Brownell <david-b@pacbell.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 3/6] [RFC] Add MMC Password Protection (lock/unlock) support V5
Date: Sun, 29 Oct 2006 19:06:50 -0700
User-Agent: KMail/1.7.1
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>, linux-kernel@vger.kernel.org,
       linux-omap-open-source@linux.omap.com, Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
References: <20061020164914.012378000@localhost.localdomain> <20061020165135.162482000@localhost.localdomain> <45447914.7070101@drzeus.cx>
In-Reply-To: <45447914.7070101@drzeus.cx>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610291806.56131.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 1:49 am, Pierre Ossman wrote:

> > +	data_buf = kmalloc(data_size, GFP_KERNEL);
> >   
> 
> For something that can be at most 34 bytes, a kmalloc seems excessive.
> Put it on the stack. Just remember to have checks so we do not overflow.

It does seem excessive, but stack-allocated buffers are not guaranteed
to be DMA-safe.  See Documentation/DMA-mapping.txt right in the first
major section "What memory is DMA'able?"...


