Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUG0U0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUG0U0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266607AbUG0U0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:26:21 -0400
Received: from mail1.slu.se ([130.238.96.11]:7354 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S266605AbUG0UYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:24:18 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16646.47585.814327.628319@robur.slu.se>
Date: Tue, 27 Jul 2004 22:24:01 +0200
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0407271710070.3787-100000@silmu.st.jyu.fi>
References: <16646.14381.740376.204381@robur.slu.se>
	<Pine.LNX.4.44.0407271710070.3787-100000@silmu.st.jyu.fi>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pasi Sjoholm writes:

 > Yeah, when the ksoftirqd is taking all the cpu it will be like that, but 
 > when the kernel is behaving normally the starving diff is between 0->1sec.

 Well ksoftirqd makes your kernel load just visible which is good and 
 ksofirqd gets accounted for this when softirq's get deferred to it.
 It may look like goes from 0 to 100% but thats probably not the case.
 The problem is we can starve userland at high loads. As said we were
 trying some way to cure this I may have some old patch if you like to try.

 Cheers.
						--ro
 
