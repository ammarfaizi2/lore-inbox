Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270334AbTGMSwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 14:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbTGMSwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 14:52:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:31364 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270334AbTGMSwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 14:52:35 -0400
Date: Sun, 13 Jul 2003 12:00:51 -0700
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Three drivers/i2c/ patches
Message-ID: <20030713190051.GA15094@kroah.com>
References: <3F107F0F.40701@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F107F0F.40701@portrix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 11:35:11PM +0200, Jan Dittmer wrote:
> Hi Greg,
> 
> these are 2 patches to the drivers/i2c subdirectory.
> 
> The first patch removes a warning from i2c-algo-bit.c, which I get 
> regularly with my tv cards. It's more an info than a failure and 
> spamming the logs at a rate of about 1/min. It indicates a send failure 
> on the i2c bus or a miss of the ACK. Technically I think, it should 
> resend the message, shouldn't it?

Can you just change this to dev_dbg() for people to still see it if they
want to?

> The second patch removes the cli/sti usage from i2c-elektor. It's only 
> used to protect pcf_pending from changing. I replaced it (hopefully 
> correct) with a spinlock.

Like Christoph said, this isn't correct.

> The third patch is actually a resend and converts w83781d to use milli 
> Celsius instead of centi Celsius.

Sorry for not getting to this previously, I have applied it and will
send it on later this evening.

thanks,

greg k-h
