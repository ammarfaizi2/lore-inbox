Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVAQSXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVAQSXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVAQSUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:20:38 -0500
Received: from smtp1.sloane.cz ([62.240.161.228]:52437 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262837AbVAQSSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:18:44 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-dvb@linuxtv.org
Subject: Satelco driver stopped development - new developer wanted
Date: Mon, 17 Jan 2005 19:17:47 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501171917.48109.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

people which developed original driver stopped supporting it. Will you please 
maintain it?

Original driver is here:
http://instinct-wp8.no-ip.org/pluto/

Michal

----
Re: 2.6.10 and your driver for Pluto

From:
Dany Salman <salmandany@yahoo.fr>

To: 
cijoml@volny.cz


Datum: 
Dnes 17:02:47


Hi,

Here is what I think of your trouble :

> Hi,
> 
> I simply fixed compilation via:
> +#include <linux/version.h>
> 
> - eth= skb->mac.ethernet;
> +#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,8)
> + eth = skb->mac.ethernet;
> +#else
> + eth = eth_hdr(skb);
> +#endif
> 
> But after inserting module I get:
> 
> PCI: Setting latency timer of device 0000:03:00.0 to
> 64
> Pluto 2 MacAddress : 00:d0:16:01:5c:0c
> Pluto Card Revision (Maj,Min) : (2,15)

This part works fine, the driver even manages to find
your Macaddress and the card revision...

> driver_initialize: unable to allocate dma !

However, it cannot allocate dma for an unknown
reason... You should try to compile it on a previous
kernel version (it has been succesfully tested until
2.6.6 and then its development stopped). Maybe it is
due to your intel chipset. I only can advise you to
run a previous kernel to check if it works.

By the way, I am not developping this driver any more 
so if the linuxtv guys don't release and support it,
I'm afraid there is no issue for your trouble...

Cheers,

Dany Salman
----
