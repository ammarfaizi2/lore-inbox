Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUGOVA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUGOVA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUGOVA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:00:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266347AbUGOVAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:00:53 -0400
Message-ID: <40F6F076.2080001@pobox.com>
Date: Thu, 15 Jul 2004 17:00:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: netdev@oss.sgi.com, irda-users@lists.sourceforge.net, jt@hpl.hp.com,
       the_nihilant@autistici.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
References: <m34qo96x8m.fsf@averell.firstfloor.org> <40F6B547.7050800@pobox.com> <20040715205001.GA2527@muc.de>
In-Reply-To: <20040715205001.GA2527@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Jul 15, 2004 at 12:48:07PM -0400, Jeff Garzik wrote:
>>And with legacy ISA devices still around, I don't see a whole lot of 
>>value in differentiating between "I have ISA slots" and "I have ISA 
>>devices".
> 
> 
> There is great value. Basically most ISA drivers are not 64bit 
> clean (if they even still work on i386 which is also often doubtful
> in 2.6) and it is a great way for 64bit archs to get rid of a lot 
> of not working code.

I file that under "hiding bugs", since it will not be immediately 
obvious to a bug hunter or maintainer what the real problem is.

If a driver is broken on 64-bit, please add "&& !64BIT" to the Kconfig.

As you yourself just explained, your wish is to use CONFIG_ISA, but your 
intent is only coincedentally related to ISA.

	Jeff


