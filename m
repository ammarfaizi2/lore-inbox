Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTEZAbG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 20:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTEZAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 20:31:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17807 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263818AbTEZAbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 20:31:05 -0400
Message-ID: <3ED16351.7060904@pobox.com>
Date: Sun, 25 May 2003 20:44:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] xirc2ps_cs irq return fix
References: <200305252318.h4PNIPX4026812@hera.kernel.org>
In-Reply-To: <200305252318.h4PNIPX4026812@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
> --- a/drivers/net/pcmcia/xirc2ps_cs.c	Sun May 25 16:18:34 2003
> +++ b/drivers/net/pcmcia/xirc2ps_cs.c	Sun May 25 16:18:34 2003
>      if (!netif_device_present(dev))
> -	return IRQ_NONE;
> +	return IRQ_HANDLED;

As I mentioned in the thread, this piece of code is obviously wrong.

Think about how scalable this fix is??  Do you really want to crap up 
all pcmcia drivers with this silly -- and wrong -- check?

IIRC the pcmcia layer or new irqreturn_t was blamed for the problem. 
Come on.  Linux mantra is -against- papering over bugs.

	Jeff



