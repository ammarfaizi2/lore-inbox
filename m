Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbUK3ABD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUK3ABD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUK3ABD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:01:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:48835 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261869AbUK3AA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:00:59 -0500
Date: Tue, 30 Nov 2004 01:10:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Domen Puncer <domen@coderock.org>, janitor@sternwelten.at,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: ds1620: replace schedule_timeout() with 	msleep()
In-Reply-To: <20041129224240.D5614@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0411300110010.3432@dragon.hygekrogen.localhost>
References: <E1C2cAP-0007Rx-JK@sputnik> <Pine.LNX.4.61.0411281835430.3389@dragon.hygekrogen.localhost>
 <20041129140929.GC7889@nd47.coderock.org> <Pine.LNX.4.61.0411292336320.3389@dragon.hygekrogen.localhost>
 <20041129224240.D5614@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Russell King wrote:

> On Mon, Nov 29, 2004 at 11:37:48PM +0100, Jesper Juhl wrote:
> > On Mon, 29 Nov 2004, Domen Puncer wrote:
> > > It's right:
> > > schedule_timeout(2*HZ) sleeps for 2 seconds;
> > > msleep(2000) sleeps for 2000 miliseconds, and does not depend on what
> > > HZ is.
> >
> > It seems I didn't understand schedule_timeout() properly, thank you for 
> > the clarification.
> 
> As part-author of this driver, and actually of this particular bit
> of code, a 2 second delay is intented here.  The fan needs to be run
> at full power in order to start running, so the idea here is to give
> it full power for 2 seconds and then to restore the temperature trip
> points to the configured values.
> 
That makes sense - thanks.

-- 
Jesper

