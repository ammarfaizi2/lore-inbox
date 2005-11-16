Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVKPTGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVKPTGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVKPTGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:06:04 -0500
Received: from kanga.kvack.org ([66.96.29.28]:46211 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751491AbVKPTGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:06:03 -0500
Date: Wed, 16 Nov 2005 14:03:34 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Oliver Neukum <oliver@neukum.org>, jmerkey <jmerkey@utah-nac.org>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051116190334.GC982@kvack.org>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org> <200511161710.05526.ak@suse.de> <20051116184508.GP5735@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116184508.GP5735@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 07:45:08PM +0100, Adrian Bunk wrote:
> The problem is similar no matter whether you have 4k or 8k stacks, but 
> with 4k stacks you have the additional benefits of order 0 allocations 
> and less memory usage.

We could implement a stack guard page for the transition period, so that 
any stack overflows would end up generating a fault.  That's easy enough 
to do by using vmalloc().

		-ben
