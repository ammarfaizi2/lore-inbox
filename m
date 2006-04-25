Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWDYImF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWDYImF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWDYImF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:42:05 -0400
Received: from hermes.drzeus.cx ([193.12.253.7]:52437 "EHLO mail.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751452AbWDYImD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:42:03 -0400
Message-ID: <444DE0E6.8090801@drzeus.cx>
Date: Tue, 25 Apr 2006 10:42:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?Jani-Matti_H=E4tinen?=" <jani-matti.hatinen@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Lock-up with modprobe sdhci after suspending to ram
References: <515ed10f0604240033i71781bfdp421ed244477fd200@mail.gmail.com> <444CC4A3.3040309@drzeus.cx> <200604251108.52515.jani-matti.hatinen@iki.fi>
In-Reply-To: <200604251108.52515.jani-matti.hatinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jani-Matti Hätinen wrote:
>
> Looks like some kind of routing problem. Even pings don't seem to get through 
> to mmc.drzeus.cx, or list.drzeus.cx. With http I get a timeout from 
> mmc.drzeus.cx. This is from IP 80.221.18.58
>   

Most of the domain is down right now (changing ISP). But the mail server
is up at hermes.drzeus.cx:

drzeus.cx.              86393   IN      MX      10 mail.drzeus.cx.
list.drzeus.cx.         86400   IN      MX      10 mail.drzeus.cx.
mail.drzeus.cx.         84586   IN      A       193.12.253.7
hermes.drzeus.cx.       83892   IN      A       193.12.253.7

> Unfortunately even text mode is completely speechless about it. The modprobe 
> goes through cleanly and I get the regular prompt (with a blinking cursor 
> even), but the machine's completely locked up.
>
>   

Have you tried pinging it? For some reason the keyboard tends to bail
out when there are outstanding MMC requests. I've only seen this with a
card in the slot though.

You could increase the log level sent to console and enable MMC_DEBUG.
If you can find more closely where it hangs I have a better chance of
finding it.

Rgds
Pierre

