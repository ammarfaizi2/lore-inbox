Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270354AbTHQQoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTHQQoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:44:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42953 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270354AbTHQQoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:44:00 -0400
Message-ID: <3F3FB0C4.3000004@pobox.com>
Date: Sun, 17 Aug 2003 12:43:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5 IrDA] vlsi driver update
References: <20030811210354.GD21178@bougret.hpl.hp.com>
In-Reply-To: <20030811210354.GD21178@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> ir2603_vlsi-05.diff :
> ~~~~~~~~~~~~~~~~~~~
> 		<Patch from Martin Diehl>
> * correct endianess conversion of hardware exposed fields
> * we need to check crc16 of rx frames in SIR-mode
>   (hardware does this in MIR/FIR modes). Use irda_calc_crc16.
> * get rid of BUG'gers - having them in interrupt path isn't fun.
> * don't return NET_XMIT_DROP when we drop (dev_kfree_skb_any)
>   frames. This value is meant to ask for retransmit so we would
>   corrupt the skb slab.
> * locking review, corrections and improvements: particularly focus 
>   on speed setting and start_xmit paths, but also reducing time
>   we are staying with interrupts disabled.
> * printk-cleanup: less/better syslog msgs, use IRDA_DEBUG and friends.
> * default qos_mtt_bits should be 1ms or longer (0x07), not exactly 1ms
> * rename IRENABLE_IREN -> IRENABLE_PHYANDCLOCK
> * few minor improvements 
> * compatibility stuff to preserve 2.4 backport path
> * it's a pci controller, so we should depend on CONFIG_PCI
> * DRIVER_VERSION 0.5

this patch needs splitting up

