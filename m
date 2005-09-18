Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVIRRV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVIRRV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVIRRV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:21:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:46773 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932126AbVIRRV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:21:27 -0400
Subject: Re: p = kmalloc(sizeof(*p), )
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Al Viro <viro@ftp.linux.org.uk>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200509181925.25112.vda@ilport.com.ua>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	 <1127041474.8932.4.camel@localhost.localdomain>
	 <20050918143907.GK19626@ftp.linux.org.uk>
	 <200509181925.25112.vda@ilport.com.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Sep 2005 18:47:10 +0100
Message-Id: <1127065630.8932.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-18 at 19:25 +0300, Denis Vlasenko wrote:
> > #define new_object(foo, gfp) (foo *)kmalloc(sizeof(foo), (gfp))
> > 
> > then you can
> > 
> > 	x = new_object(struct frob, GFP_KERNEL)
> 
> This will emit a warning if x is not a struct frob*,
> which plain kmalloc doesn't do.

In the programs where I use it a lot (eg AberMUD5) I also in debugging
mode pass in __FILE__ and __LINE__ which can be most handy.
