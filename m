Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWBMU6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWBMU6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWBMU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:58:55 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7135
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964867AbWBMU6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:58:53 -0500
Date: Mon, 13 Feb 2006 12:57:58 -0800 (PST)
Message-Id: <20060213.125758.42483359.davem@davemloft.net>
To: mingo@elte.hu
Cc: heiko.carstens@de.ibm.com, hare@suse.de, linux-kernel@vger.kernel.org
Subject: Re: calibrate_migration_costs takes ages on s390
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060213105421.GB17173@elte.hu>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com>
	<20060213.023430.126649129.davem@davemloft.net>
	<20060213105421.GB17173@elte.hu>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 13 Feb 2006 11:54:21 +0100

> Do things get better if you fill out include/asm-sparc64/system.h's 
> sched_cacheflush() function, to flush the L2 cache? That should at least 
> make the cache state more or less reproducable across runs.

Yes, I tried to implement that, and it makes the migration cost
calculation take 4 to 5 times longer, so I'm leaving it unimplemented.
