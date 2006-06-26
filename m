Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWFZDBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWFZDBD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 23:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWFZDBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 23:01:03 -0400
Received: from mail.gmx.de ([213.165.64.21]:23508 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932461AbWFZDBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 23:01:02 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1151288602.7470.22.camel@Homer.TheSimpsons.net>
References: <1151142716.7797.10.camel@Homer.TheSimpsons.net>
	 <1151149317.7646.14.camel@Homer.TheSimpsons.net>
	 <20060624154037.GA2946@atjola.homenet>
	 <1151166193.8516.8.camel@Homer.TheSimpsons.net>
	 <20060624192523.GA3231@atjola.homenet>
	 <1151211993.8519.6.camel@Homer.TheSimpsons.net>
	 <20060625111238.GB8223@atjola.homenet>
	 <20060625142440.GD8223@atjola.homenet>
	 <1151257451.7858.45.camel@Homer.TheSimpsons.net>
	 <1151257397.4940.45.camel@laptopd505.fenrus.org>
	 <20060625184244.GA11921@atjola.homenet>
	 <1151288602.7470.22.camel@Homer.TheSimpsons.net>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 05:05:14 +0200
Message-Id: <1151291114.7611.8.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 04:23 +0200, Mike Galbraith wrote:

> Something is certainly still b0rken.  I still get three different
> answers to the question "what is my cpu usage" depending on
> configuration.  With stock UP kernel with no IO-APIC, interrupt load is
> all hi.  With your patch and IO-APIC, it's all si.  SMP shows a mix of
> both.

I didn't say that quite right.

The third case for my box is XT-PIC and your patch.  Previously, top
showed the 10% interrupt load of a flood ping as all hi.  Now it's both
hi and si when using XT-PIC, but it's no longer the 10% that agreed with
the profile, it's  10% hi, but with an added ~7% si.

	-Mike

