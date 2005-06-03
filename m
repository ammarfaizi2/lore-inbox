Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVFCRkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVFCRkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFCRkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:40:00 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:15079 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261417AbVFCRj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:39:57 -0400
Date: Fri, 3 Jun 2005 10:39:40 -0700
From: Tony Lindgren <tony@atomide.com>
To: Christian Hesse <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050603173940.GA18025@atomide.com>
References: <20050602013641.GL21597@atomide.com> <200506022203.27734.mail@earthworm.de> <20050602203225.GH21363@atomide.com> <200506030808.12903.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506030808.12903.mail@earthworm.de>
User-Agent: mutt-ng 1.5.9i (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Hesse <mail@earthworm.de> [050602 23:09]:
> 
> The problems occured with enabled CONFIG_DYN_TICK_USE_APIC. As I recompiled 
> the kernel the following is without the option. Everything looks good so far 
> (except resume...), so I am not shure what caused the bad behavior.

OK, that's good to know.

> BTW, I can enable CONFIG_DYN_TICK_USE_APIC without CONFIG_X86_UP_APIC, is this 
> intended?

You're right, it should not be allowed. I'll make that a command
line option too for the next version.

> Software suspend still does not work, it hangs on resume. Any ideas what could 
> be the cause? I've applied these patches on top of 2.6.12-rc5:
> 
> 2.6.12-rc4-ck1
> software suspend 2.1.8.10
> reiser from 2.6.12-rc5-mm1
> ieee802.11 stack and ipw2100 1.1.0
> hostap 0.3.7
> shfs 0.35
> fbsplash 0.9.2-r2
> dyn-tick

I don't think it's the dyn-tick patch that causes it. Does the
resume work properly without the dyn-tick patch?

Tony
