Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVK2QRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVK2QRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVK2QRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:17:11 -0500
Received: from cantor.suse.de ([195.135.220.2]:40380 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751395AbVK2QRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:17:10 -0500
Date: Tue, 29 Nov 2005 17:17:00 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Enabling RDPMC in user space by default
Message-ID: <20051129161700.GK19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <17292.31749.278879.822369@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17292.31749.278879.822369@alkaid.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PMC0 stops being a cycle counter as soon as any real driver
> (not the NMI watchdog) takes over the hardware, such as oprofile,
> perfmon2, or perfctr. So user-space cannot rely on the semantics

They're wrong then. oprofile shouldn't disable the NMI
watchdog. If it does it's broken and needs to be fixed.

> Disabling user-space RDTSC (setting CR4.TSD) seems evil and pointless.
> At least some users of it (the perfctr library and I hope eventually
> also perfmon2) do use it in an SMP-safe manner (through special
> user/kernel protocols).

How do you handle P state changes? I don't think it can be safely
used in user space.

-Andi
