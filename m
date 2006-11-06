Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWKFKhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWKFKhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWKFKhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:37:20 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51893 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750807AbWKFKhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:37:18 -0500
Date: Mon, 6 Nov 2006 13:37:24 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061106103724.GA4535@2ka.mipt.ru>
References: <20061103163012.GA84707@cave.trolltruffles.com> <20061105204741.GA1847@elf.ucw.cz> <20061106101329.GA16817@2ka.mipt.ru> <20061106101633.GE2978@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061106101633.GE2978@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 06 Nov 2006 13:37:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 11:16:33AM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> On Mon 2006-11-06 13:13:29, Evgeniy Polyakov wrote:
> > On Sun, Nov 05, 2006 at 09:47:41PM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> > > It has been show in this thread that kevent is too different to kqueue
> > > as is... but what are the advantages of kevent? Perhaps we should use
> > > kqueue on Linux, too (even if it means one more rewrite for you...?)
> > 
> > Should we use *BSD VMM system when we have superiour Linux one?
> 
> Very different question; VMM system is not something that has userland
> API.

So what? We still create new things, which work better than old ones
even if it requires 'to reinvent the wheel'.

It was shown too many times already why kqueue api can not be used in
Linux.

Btw, if you want someone to rewrite something, you can start with mmaped
based malloc for example. Why don't you want to do it - although API is
the same, but underlying logic is different.

> Can you explain why kevent is better than kqueue?

According to my tests kevent is noticebly faster.
It is already too big flag that old system should not be used.
And half of my previous mail to you shows why kevent is better/different
from kqueue.

-- 
	Evgeniy Polyakov
