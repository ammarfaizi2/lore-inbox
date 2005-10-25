Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVJYVnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVJYVnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVJYVnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:43:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932412AbVJYVnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:43:49 -0400
Date: Tue, 25 Oct 2005 14:43:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Darren Salt <linux@youmustbejoking.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <20051026011330.A7390@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.64.0510251438470.10477@g5.osdl.org>
References: <4DBF8B37C1%linux@youmustbejoking.demon.co.uk>
 <Pine.LNX.4.64.0510251338420.10477@g5.osdl.org> <20051026011330.A7390@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Oct 2005, Ivan Kokshaysky wrote:
> 
> Perhaps
> 	base &= ~(size - 1);
> will be OK?

Yes, already did that in my tree (except I did

	base &= -size;

which some people find strange).

> WRT 0x15e8 thing - include/sound/ad1848.h says:
> 
> /* IBM Thinkpad specific stuff */
> #define AD1848_THINKPAD_CTL_PORT1		0x15e8
> #define AD1848_THINKPAD_CTL_PORT2		0x15e9
> #define AD1848_THINKPAD_CS4248_ENABLE_BIT	0x02

Good catch. That explains the address.

		Linus
