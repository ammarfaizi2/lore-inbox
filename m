Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUBPAnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUBPAnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:43:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:15519 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265263AbUBPAna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:43:30 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: earny@net4u.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <200402160129.32011.earny@net4u.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <200402160033.43438.earny@net4u.de> <1076889243.11392.130.camel@gaston>
	 <200402160129.32011.earny@net4u.de>
Content-Type: text/plain
Message-Id: <1076892102.6957.138.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 11:41:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yupp :-)
> 
> Direct hit.
> 
> Works immediatly. Ok, with some little cosmetic problems: Direct after boot 
> you can see for (less than?)  ~1/10 sec the kernel screen in normal 25/80 
> resolution. After that you see the Pinguin on the top with funny blinking 
> characters on the bottom, following with the normal boot messages. The 
> funny characters scrolls out  normaly... look like that a random screen 
> with resolution 25/80 are inserted when the fb are initialized...

The funny blinking characters are an fbcon bug. I would have to dive
deeper into the fbcon code to fully understand what's up... afaik,
it's supposed to "translate" the content of your VGA text buffer when
taking over, and that isn't working properly. As soon as I get an
x86 with a radeon for testing here, I'll be able to work on that.

Ben.


