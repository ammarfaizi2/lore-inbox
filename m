Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVCWNxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVCWNxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVCWNxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:53:17 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:12229 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262499AbVCWNvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:51:22 -0500
Message-ID: <42417457.9020008@acm.org>
Date: Wed, 23 Mar 2005 07:51:19 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Pawe__ Sikora <pluto@pld-linux.org>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH][alpha] "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko]
 undefined!
References: <200503152335.48995.pluto@pld-linux.org> <20050322130657.7502418d.akpm@osdl.org> <424093C8.400@pobox.com> <20050323113858.A4941@jurassic.park.msu.ru>
In-Reply-To: <20050323113858.A4941@jurassic.park.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not the right fix.  I know of IPMI hardware on ppc and xscale 
systems.  There should be nothing general in the driver that limits it 
to x86/ia64.

pm_power_off is defined in linux/pm.h.  Shouldn't it be available 
everywhere?

-Corey

Ivan Kokshaysky wrote:

>On Tue, Mar 22, 2005 at 04:53:12PM -0500, Jeff Garzik wrote:
>  
>
>>Although I suppose its possible that some alpha machines have SMI 
>>hardware, I don't think I've ever seen ACPI or IPMI on any alpha.
>>    
>>
>
>Yes, this stuff doesn't exist. I think it would be correct to add
>the following to drivers/char/ipmi/Kconfig, like it's done for ACPI:
>
>menu "IPMI"
>+	depends on IA64 || X86
>
>config IPMI_HANDLER
>       tristate 'IPMI top-level message handler'
>+	depends on IA64 || X86
>
>
>Ivan.
>  
>

