Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbTLSBBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 20:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTLSBBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 20:01:44 -0500
Received: from palrel10.hp.com ([156.153.255.245]:27821 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265421AbTLSBBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 20:01:43 -0500
Date: Thu, 18 Dec 2003 17:01:42 -0800
To: Martin Diehl <lists@mdiehl.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0
Message-ID: <20031219010142.GA1907@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031218231650.GA828@bougret.hpl.hp.com> <Pine.LNX.4.44.0312190113030.30804-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312190113030.30804-100000@notebook.home.mdiehl.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 01:31:01AM +0100, Martin Diehl wrote:
> 
> I have converted dongle drivers on disk here. So far I was holding back 
> basically due to:
> * 2.6.0 freeze
> * neither hardware nor testers to do even basic validation
> * wait for tx-lock and rawmode fixes to get applied first so we would 
>   hopefully get some more feedback and trust in the infrastructure.

	Yep. Hopefully this will change as more user migrate to 2.6.X.

> If you would like to accept it now I'd sent patches this weekend.

	I'm flying tommorow, and when I'm away, I never read my e-mail.

> > 	o IrCOMM disconnect race condition Oops ; todo
> 
> After some user provided helpful information off-list I found out it gets 
> triggered when the app doesn't close the ircomm-fd before exiting.
> Just do "cat /dev/ircomm0" and kill -9 the cat to see.
> 
> Below my current experimental patch. It works for me and I've got an user
> confirmation meanwhile. It's definedly an improvement and I do think it is 
> as safe as we can get without reworking the whole ircomm-locking...

	Yes, that is more or less what I had suggested.
	Note that I'm unhappy about (self->flags & ASYNC_INITIALIZED),
either it goes under spinlock or use test_bit().

> Martin

	Jean
