Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266740AbUHCQwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266740AbUHCQwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 12:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUHCQwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 12:52:10 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27075 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266731AbUHCQwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 12:52:06 -0400
Date: Tue, 3 Aug 2004 18:50:26 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com, brad@brad-x.com, shemminger@osdl.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe RLT-8139 related)
Message-ID: <20040803185026.A10580@electric-eye.fr.zoreil.com>
References: <20040803003515.A29885@electric-eye.fr.zoreil.com> <Pine.LNX.4.44.0408031523220.32102-100000@silmu.st.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0408031523220.32102-100000@silmu.st.jyu.fi>; from ptsjohol@cc.jyu.fi on Tue, Aug 03, 2004 at 03:32:15PM +0300
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Sjoholm <ptsjohol@cc.jyu.fi> :
[...]
> The first log file is with both patchs applied and the second one with one 
> little change to rx8139_rx() to show if it even goes to through 
> 
> "        while (netif_running(dev) && received < budget
>                && (RTL_R8 (ChipCmd) & RxBufEmpty) == 0) {"-section.
> 
> This was the change which I made.. so you can see in the second log file 
> that there won't be any of these messages after the driver has crashed. 

If you remove the "if (received > 0) {" test in r8139-10.patch and keep
both patches applied, I assume you are back to a crash within 15min (instead
of within 2min as suggested by the log), right ?

--
Ueimor
