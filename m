Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266241AbUGOQs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUGOQs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 12:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUGOQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 12:48:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33718 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266241AbUGOQsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 12:48:25 -0400
Message-ID: <40F6B547.7050800@pobox.com>
Date: Thu, 15 Jul 2004 12:48:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: netdev@oss.sgi.com, irda-users@lists.sourceforge.net, jt@hpl.hp.com,
       the_nihilant@autistici.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
References: <m34qo96x8m.fsf@averell.firstfloor.org>
In-Reply-To: <m34qo96x8m.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> http://bugme.osdl.org/show_bug.cgi?id=3077
> 
> Some IRDA chipsets currently don't work on x86-64, because
> they're dependent on CONFIG_ISA and x86-64 doesn't set this.
> CONFIG_ISA means real ISA slots, and I doubt these chips
> come on real ISA cards, so I just removed the bogus 
> dependency.

Honestly, the issue and patch need more thought, IMO.

Regardless of theory, CONFIG_ISA is currently also used to indicate 
legacy ISA devices that are today integrated into southbridges.

And with legacy ISA devices still around, I don't see a whole lot of 
value in differentiating between "I have ISA slots" and "I have ISA 
devices".

	Jeff


