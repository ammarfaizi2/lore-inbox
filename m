Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUFVV1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUFVV1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUFVV1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:27:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:1451 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265163AbUFVV0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:26:38 -0400
Subject: Re: [PATCH][2.6.7-mm1] perfctr ppc32 update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16600.39256.669322.177553@alkaid.it.uu.se>
References: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
	 <1087928274.1881.4.camel@gaston>
	 <16600.37372.473221.988885@alkaid.it.uu.se>
	 <1087935661.1855.10.camel@gaston>
	 <16600.39256.669322.177553@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1087939194.1839.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 16:19:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So what you're saying is that PLL_CFG may not reflect the true
> relationship between the TB frequency and the core frequency?

Right.

> That shouldn't be a problem as long as there's _some_ in-kernel
> interface for finding that out. If querying OF isn't the correct
> approach, then what is?

What do you need exactly ? The TB one or the core one ? the core
I suppose ? Well, we should probably define an ppc_get_cpu_core_frequency
or something like that that uses the cpufreq callback like the pmac code
when cpufreq is enabled or default to the old parsing when not. Look at
the pmac code. You may also want to install a cpufreq notifier callback
to be informed of core frequency changes.

Ben.

