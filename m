Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbSKQRxG>; Sun, 17 Nov 2002 12:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267533AbSKQRxG>; Sun, 17 Nov 2002 12:53:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267534AbSKQRxD>; Sun, 17 Nov 2002 12:53:03 -0500
Date: Sun, 17 Nov 2002 10:00:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARAM 2/4
In-Reply-To: <20021115222725.258EC2C129@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211170953140.4425-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Nov 2002, Rusty Russell wrote:
> MODULE_PARAM is misleading and wrong.

Why is MODULE_PARAM() misleading and wrong? I think it's a lot more 
descriptive, and these things are "modules" whether they are actually 
compiled in or not. 

The MM layer is just "another module". Granted, you can't compile it out 
of the kernel, but it has a specific set of things it does, and is clearly 
not the same thing as the scheduler, which is it's own "module".

The fact that PARAM was already used as a name should have been a big hint 
that the name is not specific or descriptive enough.

Also, can we please stop shouting? I'd much rather see

	module_param(debug, int, 0600)

than 

	PARAM(debug, int, 0600)

(see, for similarities, "module_init()", "module_exit()" etc: you don't 
need to shout to make a point, and "module_xxx()" is already the accepted 
practice for something that works both for compiled-in and modular 
objects).

		Linus



