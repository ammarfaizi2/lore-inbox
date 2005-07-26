Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVGZVIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVGZVIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGZVDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:03:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63207 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261867AbVGZVBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:01:08 -0400
Date: Tue, 26 Jul 2005 23:00:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [warning: ugly, FYI] battery charging support for sharp sl-5500
Message-ID: <20050726210055.GA23224@elf.ucw.cz>
References: <20050725054642.GA6651@elf.ucw.cz> <1122304018.7942.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122304018.7942.61.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have similar problems with the corgi battery driver which is probably
> even more of a mess than this. My conclusion is the whole lot needs
> rewriting in a nice fashion before it can be included in mainline. My
> work so far on the corgi code is here:
> 
> http://www.rpsys.net/openzaurus/patches/corgi_power-r24.patch

+void corgikbd_setled_charge(int led_set)
+{
+	if (led_set) 
+		GPSR0 = GPIO_bit(CORGI_GPIO_LED_ORANGE);
+	else
+		GPCR0 = GPIO_bit(CORGI_GPIO_LED_ORANGE);
+}

Ugh... GPSR0 / GPCR0 looks _very_ similar :-(. I thought I am seeing
an error.
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
