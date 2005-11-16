Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVKQOm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVKQOm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVKQOm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:42:27 -0500
Received: from cantor2.suse.de ([195.135.220.15]:17562 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750959AbVKQOm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:42:26 -0500
From: Andi Kleen <ak@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Wed, 16 Nov 2005 20:08:50 +0100
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <20051116184508.GP5735@stusta.de> <20051116190334.GC982@kvack.org>
In-Reply-To: <20051116190334.GC982@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511162008.52046.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 20:03, Benjamin LaHaise wrote:
> On Wed, Nov 16, 2005 at 07:45:08PM +0100, Adrian Bunk wrote:
> > The problem is similar no matter whether you have 4k or 8k stacks, but 
> > with 4k stacks you have the additional benefits of order 0 allocations 
> > and less memory usage.
> 
> We could implement a stack guard page for the transition period, so that 
> any stack overflows would end up generating a fault.  That's easy enough 
> to do by using vmalloc()

And would add considerable overhead in TLB flushes and locking ...

-Andi
