Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbUK2WrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUK2WrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUK2WoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:44:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48394 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261858AbUK2Wms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:42:48 -0500
Date: Mon, 29 Nov 2004 22:42:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Domen Puncer <domen@coderock.org>, janitor@sternwelten.at,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: ds1620: replace schedule_timeout() with 	msleep()
Message-ID: <20041129224240.D5614@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Domen Puncer <domen@coderock.org>, janitor@sternwelten.at,
	linux-kernel@vger.kernel.org, akpm@digeo.com
References: <E1C2cAP-0007Rx-JK@sputnik> <Pine.LNX.4.61.0411281835430.3389@dragon.hygekrogen.localhost> <20041129140929.GC7889@nd47.coderock.org> <Pine.LNX.4.61.0411292336320.3389@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0411292336320.3389@dragon.hygekrogen.localhost>; from juhl-lkml@dif.dk on Mon, Nov 29, 2004 at 11:37:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 11:37:48PM +0100, Jesper Juhl wrote:
> On Mon, 29 Nov 2004, Domen Puncer wrote:
> > It's right:
> > schedule_timeout(2*HZ) sleeps for 2 seconds;
> > msleep(2000) sleeps for 2000 miliseconds, and does not depend on what
> > HZ is.
>
> It seems I didn't understand schedule_timeout() properly, thank you for 
> the clarification.

As part-author of this driver, and actually of this particular bit
of code, a 2 second delay is intented here.  The fan needs to be run
at full power in order to start running, so the idea here is to give
it full power for 2 seconds and then to restore the temperature trip
points to the configured values.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
