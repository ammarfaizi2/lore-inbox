Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUFPJGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUFPJGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 05:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUFPJGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 05:06:20 -0400
Received: from denner-dude.demon.co.uk ([80.176.227.19]:31473 "EHLO
	denner.demon.co.uk") by vger.kernel.org with ESMTP id S266223AbUFPJGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 05:06:11 -0400
Message-ID: <40D00D86.4020001@denner.demon.co.uk>
Date: Wed, 16 Jun 2004 10:06:14 +0100
From: Matthew Denner <matt@denner.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 45 minute boot time with 2.6.4/2.6.6-mm5 kernel on 1.7GHz laptop
References: <40CEFC9E.2030508@denner.demon.co.uk>	<16590.65369.579162.568380@alkaid.it.uu.se>	<40CF43E3.3080504@denner.demon.co.uk> <16591.29411.71049.949613@alkaid.it.uu.se>
In-Reply-To: <16591.29411.71049.949613@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.2 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> And here we see a, possibly the, problem.
> The BIOS gives us usable memory up to 0x3f7cffff, but the
> corresponding MTTR stops short at 0x3effffff, which leaves
> the 8MB in [0x3f000000,0x3f7cffff] usable but uncached.
> 
> Any access to that range will be sloooow.
> 
> This is unfortunately not an uncommon BIOS error. You may want to
> check for BIOS updates, or file a bug report with the HW vendor.
> 
> Booting with "mem=1008M" appended to the kernel's options
> should fix the performance issue.

Mikael, thanks for all your help, this fixed the problem for me.  It now 
boots in less than a minute.

Matt
