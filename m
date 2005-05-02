Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVEBVQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVEBVQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVEBVQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:16:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14566 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261779AbVEBVQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:16:52 -0400
Date: Mon, 2 May 2005 23:13:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       paulus@samba.org, schwidefsky@de.ibm.com, mahuja@us.ibm.com,
       donf@us.ibm.com, mpm@selenic.com, benh@kernel.crashing.org
Subject: Re: [RFC][PATCH (2/4)] new timeofday arch specific hooks (v A4)
Message-ID: <20050502211334.GA2390@openzaurus.ucw.cz>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com> <1114814811.28231.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114814811.28231.4.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ppc64 and s390. It applies on top of my linux-2.6.12-rc2_timeofday-
> core_A4 patch and with this patch applied, you can test the new time of
> day subsystem. 
....
> device_power_down(PMSG_SUSPEND);
>  
> +	timeofday_suspend_hook();
>  	/* serialize with the timer interrupt */

You should not add hooks like this. Just add your own [sys]_device.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

