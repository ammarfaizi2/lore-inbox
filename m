Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVBNUIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVBNUIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVBNUI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:08:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:11676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261553AbVBNUGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:06:51 -0500
Message-ID: <42110279.9060808@osdl.org>
Date: Mon, 14 Feb 2005 11:56:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: steve@perfectpc.co.nz
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 parport_pc: Ignoring new-style parameters in presence
 of obsolete ones
References: <Pine.LNX.4.60.0502141322120.2596@kieu>
In-Reply-To: <Pine.LNX.4.60.0502141322120.2596@kieu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steve@perfectpc.co.nz wrote:
> 
> Hi,
> 
> When I run
> 
> modprobe parport_pc io=0x378 irq=7
> 
> and found parport_pc: Ignoring new-style parameters in presence of 
> obsolete ones
> in dmesg output and of course my paralel port does not use irq.
> 
> Have no way to tell parport_pc to use IRQ? With 2.6.8 the above command 
> is fine.
> Search the parport.txt in the Documentation dir and found nothing changes.
> 
> Please help me to set IRQ for my parport. Thanks.

This was fixed about 7 weeks ago AFAIK.
See this patch:
http://linux.bkbits.net:8080/linux-2.5/cset@41d83429hQNe4oGG8g1CyWe0jdp79g?nav=index.html|src/|src/drivers|src/drivers/parport|related/drivers/parport/parport_pc.c

so using 2.6.11-rc[1,2,3,4] should fix it for you.
If not, please report the exact kernel log messages.

-- 
~Randy
