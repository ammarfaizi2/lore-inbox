Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUGDSbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUGDSbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbUGDSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 14:31:35 -0400
Received: from gprs214-240.eurotel.cz ([160.218.214.240]:23945 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265074AbUGDSb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 14:31:26 -0400
Date: Sun, 4 Jul 2004 20:27:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
Message-ID: <20040704182755.GA7540@elf.ucw.cz>
References: <40E25328.8020102@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E25328.8020102@colorfullife.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Attached is an update for the patch that adds support for the gigabit 
> ethernet nic in the nForce 250 Gb chipset.
> 
> There were two changes from the previous patch:
> - clear the PHY_HALF flag if the nic is in half duplex.
> - remove the setflags / setlen helper functions: the ring entries are 
> visible to the hardware, I don't like the read/modify/write cycles.
> 
> It passes my own tests with 100 MBit half duplex, 100 MB full duplex and 
> 1 GBit full duplex.

...

> --- 2.6/drivers/net/forcedeth.c	2004-06-30 07:27:50.330753976 +0200
> +++ build-2.6/drivers/net/forcedeth.c	2004-06-30 07:27:25.579516736 +0200
> @@ -10,8 +10,11 @@
>   * trademarks of NVIDIA Corporation in the United States and other
>   * countries.
>   *
> - * Copyright (C) 2003 Manfred Spraul
> + * Copyright (C) 2003,4 Manfred Spraul
>   * Copyright (C) 2004 Andrew de Quincey (wol support)
> + * Copyright (C) 2004 Carl-Daniel Hailfinger (invalid MAC handling, insane
> + *		IRQ rate fixes, bigendian fixes, cleanups, verification)
> + * Copyright (c) 2004 NVIDIA Corporation

NVidia has copyright on driver created by reverse engeneering their
hardware? Funny ;-). If NVIDIA really cooperates, perhaps its time to
make the name more friendly to them?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
