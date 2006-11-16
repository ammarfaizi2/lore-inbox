Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424263AbWKPQUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424263AbWKPQUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424264AbWKPQUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:20:39 -0500
Received: from toxygen.net ([213.146.59.4]:60178 "EHLO toxygen.net")
	by vger.kernel.org with ESMTP id S1424263AbWKPQUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:20:38 -0500
Message-ID: <455C8FB4.8000200@toxygen.net>
Date: Thu, 16 Nov 2006 17:20:04 +0100
From: Wojtek Kaniewski <wojtekka@toxygen.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH take 2] Atmel MACB ethernet driver
References: <20061109145117.577e3c61@cad-250-152.norway.atmel.com>
In-Reply-To: <20061109145117.577e3c61@cad-250-152.norway.atmel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haavard Skinnemoen wrote:
> Driver for the Atmel MACB on-chip ethernet module.
> 
> Tested on AVR32/AT32AP7000/ATSTK1000. I've heard rumours that it works
> with AT91SAM9260 as well, and it may be possible to share some code with
> the at91_ether driver for AT91RM9200.

It seems to work with AT91SAM9260, but unfortunately not without
problems. I occasionally get TX underrun errors, mostly while
transferring some large files. The same thing happens with driver
provided by TimeSys in their AT91SAM9260-enabled Linux distribution
recommended by Atmel (both drivers share the codebase). Is there
anything I can check by myself (without an ICE) to see what's wrong?
Some printk() in macb_tx() maybe?

Regards,
Wojtek
