Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTIKUrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbTIKUrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:47:05 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:56722 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261524AbTIKUrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:47:00 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bill davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <bjqk1p$t9r$1@gatekeeper.tmr.com>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	 <3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de>
	 <3F6087FC.7090508@pobox.com>  <bjqk1p$t9r$1@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063313075.3881.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 21:44:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 20:56, bill davidsen wrote:
> | When we know at compile time it's not needed, it should not be enabled.
> 
> Clearly that's right. This buys nothing on CPUs which don't have the
> problem, why have *any* overhead in size and speed? It's too bad that
> people have to read around all that code, they don't need to give it a
> home in their RAM and execute it as well.

We have always built kernels that contained the support for older chips.
A 586 kernel for example is minutely slowed by the fact it will run on
the Pentium Pro.

If someone wants to put in clear "this CPU only" stuff as well then
fine, but with my distributor hat on I defy you to benchmark the
difference in the real world between PIV and PIV with 100 bytes of extra
workaround code.

You could get that much code back by spending 10 minutes tidying some
random other piece of code you use, or shortening a couple of printk
messages.

 
