Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbTIRMcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTIRMcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:32:21 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:1453 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261236AbTIRMcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:32:20 -0400
Subject: Re: netpoll/netconsole minor tweaks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030917112447.A24623@osdlab.pdx.osdl.net>
References: <20030917112447.A24623@osdlab.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Thu, 18 Sep 2003 13:30:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 19:24, Chris Wright wrote: 
>  		/* Give driver a chance to settle */
> -		jiff = jiffies + 2*HZ;
> +		jiff = jiffies + 4*HZ;
>  		while (time_before(jiffies, jiff))
<pedant>
>  			;
should be cpu_relax();
</pedant>


