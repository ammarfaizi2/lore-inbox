Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVJQJar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVJQJar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVJQJar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:30:47 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56009 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932231AbVJQJaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:30:46 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4353705D.6060809@s5r6.in-berlin.de>
Date: Mon, 17 Oct 2005 11:35:25 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
References: <20051015185502.GA9940@plato.virtuousgeek.org>	<43515ADA.6050102@s5r6.in-berlin.de>	<20051015202944.GA10463@plato.virtuousgeek.org> <20051017005515.755decb6.akpm@osdl.org>
In-Reply-To: <20051017005515.755decb6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.196) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> 
>>diff -X linux-2.6.14-rc2/Documentation/dontdiff -Naur linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c
>>--- linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c	2005-09-19 20:00:41.000000000 -0700
>>+++ linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c	2005-10-15 12:55:08.000000000 -0700
[...]
>>+module_param(toshiba, bool, 0);
>>+MODULE_PARM_DESC(toshiba, "Toshiba Legacy-Free BIOS workaround (default=0).");
[...]
> It would be really really preferable if we could find some automatic way of
> doing this.

I agree.

>  Is it possible to use DMI matching, like
> arch/i386/kernel/acpi/sleep.c:acpisleep_dmi_table ?

Earlier forms of the patch do DMI matching:
http://marc.theaimsgroup.com/?l=linux1394-devel&m=110790513206094
http://www.janerob.com/rob/ts5100/tosh-1394.patch
[short-circuited by if (1) at the second URL]

Of course we don't have a complete picture of which models are affected 
though.
-- 
Stefan Richter
-=====-=-=-= =-=- =---=
http://arcgraph.de/sr/
