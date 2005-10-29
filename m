Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVJ3Mjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVJ3Mjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVJ3Mjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:39:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16775 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932155AbVJ3Mjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:39:53 -0500
Date: Sat, 29 Oct 2005 21:08:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <richard@openedhand.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <gregkh@suse.de>
Subject: Re: [RFC] The driver model, I2C and gpio provision on Sharp SL-C1000 (Akita)
Message-ID: <20051029190819.GB657@openzaurus.ucw.cz>
References: <1130493129.8414.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130493129.8414.70.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This code is the final link is getting akita working but I'm not sure
> its the right approach. I'm posting this in the hope someone might see a
> better way to achieve this driver's objectives. I'd like to get akita
> support into mainline and this is the only barrier.

Well, what you describe is not too nice, but I do not see nicer solutions :-(.

> I2C drivers appear relatively late in the boot procedure and changing
> that isn't practical. I therefore ended up writing akita-ioexp which

It seems that making i2c init early is only sane choice. I realize PC people
will hate it... but apart from that, why is it impractical?

> There is a fundamental problem with the lack of a proper gpio interface
> in Linux. Every driver does something different with them (be it pxa
> specific gpios, SCOOP gpios, those on a IO expander, those on a video
> chip (w100fb springs to mind) to name just the Zaurus specific ones.

Yup. GPIOs are not problem on i386, so noone solved this one :-(.


				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

