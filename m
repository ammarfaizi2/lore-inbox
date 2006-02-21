Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWBUUWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWBUUWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBUUWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:22:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35538
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932265AbWBUUWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:22:13 -0500
Date: Tue, 21 Feb 2006 12:19:48 -0800 (PST)
Message-Id: <20060221.121948.60060362.davem@davemloft.net>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: softlockup interaction with slow consoles
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200602212105.38075.ak@suse.de>
References: <p73mzgk4y9u.fsf@verdi.suse.de>
	<20060221.120143.15763934.davem@davemloft.net>
	<200602212105.38075.ak@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: Tue, 21 Feb 2006 21:05:37 +0100

> The classic way is to just use touch_nmi_watchdog() somewhere
> in the loop that does work. That touches the softwatchdog too
> these days.

"jiffies" aren't advancing, since interrupts are disabled by
release_console_sem(), so that doesn't work.

I tried that already :-)
