Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUAEUos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUAEUor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:44:47 -0500
Received: from ool-43524450.dyn.optonline.net ([67.82.68.80]:16081 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id S265467AbUAEUoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:44:44 -0500
Date: Mon, 5 Jan 2004 15:44:37 -0500
Message-Id: <200401052044.i05Kib6J019930@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: Brian Macy <bmacy@macykids.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and Starfire NIC
In-Reply-To: <3FF1AC4D.9040002@macykids.net>
User-Agent: tin/1.6.2-20030910 ("Pabbay") (UNIX) (Linux/2.4.23 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Tue, 30 Dec 2003 08:48:13 -0800, Brian Macy <bmacy@macykids.net> wrote:
> When switching to 2.6.0 my Starfire NIC fails to function with an 
> entertaining message:
> Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02018101.
> Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02010001.

This says that the card's RX ring is empty. That could be because the 
driver fails to allocate any descriptors, though that's not very likely. 
Or it might be a bug...

Does it happen every time you try, or only sometimes?

> I don't know if this is related but in 2.4 I get PCI bus congestion for 
> the starfire adapter:
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 80 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 96 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 112 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 128 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 144 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 160 bytes

Unrelated. These messages only tell you that the latency on your PCI bus 
is slightly higher than expected, and the driver is compensating for it.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
