Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSKXWZ2>; Sun, 24 Nov 2002 17:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSKXWZX>; Sun, 24 Nov 2002 17:25:23 -0500
Received: from dp.samba.org ([66.70.73.150]:29611 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261733AbSKXWZU>;
	Sun, 24 Nov 2002 17:25:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/4 Module Parameter Support 
In-reply-to: Your message of "Tue, 19 Nov 2002 01:36:47 CDT."
             <3DD9DBFF.5000009@pobox.com> 
Date: Mon, 25 Nov 2002 08:57:00 +1100
Message-Id: <20021124223234.611262C0D9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD9DBFF.5000009@pobox.com> you write:
> Question for the crowd:
> 
> Should linux/module.h include moduleparam.h, since drivers are used to 
> include'ing module.h to get all their MODULE_xxx desires fulfilled?

Hmm, they already need linux/init.h for module_init() and
module_exit().  Of course the backwards compat MODULE_PARM must not
require an extra include (and it doesn't, does it?).

I guess this leads to the bigger "what are the rules for new header
files?" question, which I'm not prepared to try to answer.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
