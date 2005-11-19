Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVKSBWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVKSBWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVKSBWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:22:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52948
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932182AbVKSBWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:22:51 -0500
Date: Fri, 18 Nov 2005 17:22:30 -0800 (PST)
Message-Id: <20051118.172230.126076770.davem@davemloft.net>
To: Markus.Lidel@shadowconnect.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <437E7ADB.5080200@shadowconnect.com>
References: <437B254E.9040909@shadowconnect.com>
	<20051116.111843.23450955.davem@davemloft.net>
	<437E7ADB.5080200@shadowconnect.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Date: Sat, 19 Nov 2005 02:07:39 +0100

> Here's the output of lspci:
> 
> 0003:01:03.0 Memory controller: Adaptec (formerly DPT) Domino RAID Engine 
> (rev 02)
>          Subsystem: Adaptec (formerly DPT) Domino RAID Engine
>          Flags: bus master, medium devsel, latency 32, IRQ 0082efe0
>          BIST result: 00
>          Memory at 000001c980100000 (32-bit, non-prefetchable) [size=64K]
>          Memory at 000001c988000000 (32-bit, prefetchable) [size=128M]
> 
> 0003:01:04.0 I2O: Adaptec (formerly DPT) SmartRAID V Controller (rev 03)
>          Subsystem: Adaptec (formerly DPT) SmartRAID V Controller
>          Flags: bus master, medium devsel, latency 1, IRQ 0082ef80
>          BIST result: 00
>          Memory at 000001c990000000 (32-bit, non-prefetchable) [size=2M]
>          I/O ports at 0000000002010400 [size=256]
>          Expansion ROM at 0000000080000000 [disabled] [size=32K]
> 
> As it looks it's equal to the "Intel" based cards...
> 
> Don't think it will work then, right?

No, it won't.

Ho hum, I guess keep it a config option for now until we find a
way to auto-detect this reliably.
