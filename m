Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270739AbTG0LHD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTG0LHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:07:03 -0400
Received: from lidskialf.net ([62.3.233.115]:44998 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270739AbTG0LHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:07:00 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Rahul Karnik <rahul@genebrew.com>,
       Marcelo Penna Guerra <eu@marcelopenna.org>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sun, 27 Jul 2003 12:22:13 +0100
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307262326.49638.eu@marcelopenna.org> <3F236A4A.2090302@genebrew.com>
In-Reply-To: <3F236A4A.2090302@genebrew.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271222.13649.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Tried shutting down the computer, and it was stuck during shutdown.
> Seems like the refcounting is not really working, or perhaps there are
> too many cycles happening. What happens if you do the following with a
> module:
>
> try_module_get
> MOD_INC_USE_COUNT
> MOD_DEC_USE_COUNT
> module_put

Thanks for pointing this out, they seem to have removed the module reference 
counting. But really, I don't care whether it can unload or not. I just need 
it to work. I'm not really interested in perfecting a quick hack to a 
proprietary driver.

> > But I don't think the only thing missing is the MAC address. You could
> > try to manually set it in the source itself and see if anything works.
>
> I'll just add it in BIOS and try with AMD8111. No desire to futz around
> with the nvnet source, where half of what is going on is a complete
> black box (priv->hwapi, "priv" is definitely *private*).

Ah, so THATS who they licensed it from. I didn't think nividia would go to the 
bother of designing their own ethernet hardware. I'll have a poke about and 
see if I can find anything out about the MAC address

