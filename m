Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272731AbTHKOv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272708AbTHKOuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:50:39 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:18887
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S272680AbTHKOte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:49:34 -0400
Date: Mon, 11 Aug 2003 10:49:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: davej@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: [PATCH] misc 3c505 bits
Message-ID: <20030811144933.GC32180@gtf.org>
References: <E19mCuP-0003dp-00@tetrachloride>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19mCuP-0003dp-00@tetrachloride>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 02:40:25PM +0100, davej@redhat.com wrote:
> - Remove unneeded breaks
> - Fix double spin_unlock_irqrestore problem
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/3c505.c linux-2.5/drivers/net/3c505.c
> --- bk-linus/drivers/net/3c505.c	2003-05-26 12:57:43.000000000 +0100
> +++ linux-2.5/drivers/net/3c505.c	2003-06-04 14:07:40.000000000 +0100
> @@ -449,18 +449,18 @@ static int send_pcb(struct net_device *d
>  		case ASF_PCB_ACK:
>  			adapter->send_pcb_semaphore = 0;
>  			return TRUE;
> -			break;
> +
>  		case ASF_PCB_NAK:
>  #ifdef ELP_DEBUG
>  			printk(KERN_DEBUG "%s: send_pcb got NAK\n", dev->name);
>  #endif
>  			goto abort;
> -			break;

Disagree:  borks message.  You receive an ACK, and print "got NAK".

	Jeff



