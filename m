Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270671AbTG0FOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 01:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270672AbTG0FOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 01:14:09 -0400
Received: from [200.199.201.158] ([200.199.201.158]:9089 "EHLO
	smtp2.brturbo.com") by vger.kernel.org with ESMTP id S270671AbTG0FOG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 01:14:06 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: Rahul Karnik <rahul@genebrew.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sat, 26 Jul 2003 23:26:49 -0300
User-Agent: KMail/1.5.9
Cc: lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
References: <200307262309.20074.adq_dvb@lidskialf.net> <3F235B73.70701@genebrew.com>
In-Reply-To: <3F235B73.70701@genebrew.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200307262326.49638.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>From nvnet.c:

   /* 
     * Mac address is loaded at boot time into h/w reg, but it's loaded 
backwards
     * we get the address, save it, and reverse it. The saved value is loaded
     * back into address at close time.
     */

PRINTK(DEBUG_INIT, "nvnet_init - get mac address\n");
    priv->hwapi->pfnGetNodeAddress(priv->hwapi->pADCX, priv-
>original_mac_addr);

But I don't think the only thing missing is the MAC address. You could try to 
manually set it in the source itself and see if anything works.

Marcelo Penna Guerra

On Sunday 27 July 2003 01:56, Rahul Karnik wrote:
> Andrew de Quincey wrote:
> > Small patch for the latest nvidia nforce 1.0-261 nvnet drivers with
> > kernel 2.5.
>
> Further nvnet musings (cc:ing Jeff as net driver maintainer and
> knowledgeable person).
>
> As I reported here a few days earlier, I tried using the AMD8111 driver
> with my NForce2 ethernet a few days ago, with the result that no MAC
> address was being assigned to the card. I suspect that the MAC address
> is being assigned by the Nvidia driver. Does that make sense?
>
> If so, then using the option in the BIOS to manually set the MAC address
> might make the AMD driver work. Unfortunately, I have no idea what I
> should set it to without stomping on the MAC address for other devices.
>
> Any ideas? I hate to rely on a binary only module for something as
> "simple" as a 10/100 ethernet card.
>
> Thanks,
> Rahul
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
