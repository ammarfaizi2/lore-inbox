Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUB1AET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbUB1AET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:04:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:7641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263207AbUB1AES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:04:18 -0500
Date: Fri, 27 Feb 2004 16:06:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Message-Id: <20040227160613.17be31cb.akpm@osdl.org>
In-Reply-To: <1077924860.10076.49.camel@cog.beaverton.ibm.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<1077924860.10076.49.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> When running -mm3 (plus the one-line fix to the expanded-pci-config
> patch) to on an x440  w/ 4G enabled, the tg3 driver cannot find my
> network card. 
> 
> When booting I get:
> tg3.c:v2.7 (February 17, 2004)                
> tg3: Cannot map device registers, aborting.
> tg3: probe of 0000:01:04.0 failed with error -12
> 
> Otherwise the system seems to come up fine. 
> 
> Disabling CONFIG_ACPI (or CONFIG_X86_4G) makes the problem go away.

Beats me.  Maybe acpi is returning some monstrous reosurce length and we're
running out of kernel virtual space only with the 4g split?

'twould be appreciated if you could stick a few printk's in there and work
out what's happening please.  Check out the pci space base address and
length with and without ACPI?
