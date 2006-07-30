Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWG3Qya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWG3Qya (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWG3Qya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:54:30 -0400
Received: from khc.piap.pl ([195.187.100.11]:41197 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750924AbWG3Qy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:54:29 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nikita Danilov <nikita@clusterfs.com>, Joe Perches <joe@perches.com>,
       Martin Waitz <tali@admingilde.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
References: <200607301830.01659.jesper.juhl@gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 30 Jul 2006 18:54:27 +0200
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com> (Jesper Juhl's message of "Sun, 30 Jul 2006 18:30:01 +0200")
Message-ID: <m3ac6rkp8c.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jesper Juhl <jesper.juhl@gmail.com> writes:

> This is a series of patches that try to be an initial step towards making
> the kernel build -Wshadow clean.

I'm not sure such patches improve situation.

> It'll help us keep our namespaces separate.

Nope, it's exactly opposite - now we have separate namespaces and
-Wshadow reduces that separation.

Currently you don't have to worry about the universe when you write
a piece of code, and more importantly the universe doesn't have to
worry about each function and each private variable. I'm not sure
changing that is a good idea.
-- 
Krzysztof Halasa
