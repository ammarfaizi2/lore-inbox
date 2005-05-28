Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVE1DSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVE1DSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVE1DSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:18:52 -0400
Received: from mail.dvmed.net ([216.237.124.58]:27618 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261639AbVE1DSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:18:35 -0400
Message-ID: <4297E307.30707@pobox.com>
Date: Fri, 27 May 2005 23:18:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Benc <jbenc@suse.cz>
CC: NetDev <netdev@oss.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       pavel@suse.cz
Subject: Re: [0/5] Improvements to the ieee80211 layer
References: <20050524150711.01632672@griffin.suse.cz>
In-Reply-To: <20050524150711.01632672@griffin.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Benc wrote:
> The ieee80211 layer, now present in -mm, lacks many important features
> (actually it's just a part of the ipw2100/ipw2200 driver; these cards do
> a lot of the processing in the hardware/firmware and thus the layer
> currently can not be used for simpler devices).

Agreed.


> This is the first series of patches that try to convert it to a generic
> IEEE 802.11 layer, usable for most of today's wireless cards.

Great!


> The long term plan is:
> - to implement a complete 802.11 stack in the kernel, making it easy to
>   write drivers for simple (cheap) devices
> - to implement all of Ad-Hoc, AP and monitor modes in the layer, so it
>   will be easy to support them in the drivers
> - to integrate Wireless Extensions to unify the kernel-userspace
>   interface of all the drivers
> 
> This means that drivers for "stupid" (simple, cheap) cards should be
> very short and easy to write, whereas drivers for "clever" cards will be
> longer (but still shorter than they are now).
> 
> We have a couple of cards for testing, and we gradually modify the
> drivers for ipw2100 and ipw2200 with the development of the layer. When
> the layer is mature enough for the "stupid" cards, we will rewrite the
> driver for Atheros-based cards to use this layer. We plan to send all
> the patches for these drivers to the netdev list. Of course, we are in
> close contact with Pavel Machek, who is pushing the ipw2100 driver
> upstream.

I'm interesting in writing a RealTek driver using ieee80211.  As the 
ieee80211 layer matures, I'll start publishing that code.

	Jeff



