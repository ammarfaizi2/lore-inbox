Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271317AbTHHNPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271341AbTHHNPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:15:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22183 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271317AbTHHNPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:15:15 -0400
Message-ID: <3F33A257.7050101@pobox.com>
Date: Fri, 08 Aug 2003 09:15:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
References: <200308081119.h78BJWQ5015656@harpo.it.uu.se>
In-Reply-To: <200308081119.h78BJWQ5015656@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Thu, 7 Aug 2003 22:54:30 -0400, Jeff Garzik wrote:
> 
>>(hopefully destined for 2.4.23-pre1)
>>
>>#
>>#	include/asm-i386/msr.h	1.8     -> 1.9    
>>#	include/asm-i386/cpufeature.h	1.5     -> 1.6    
>>#	arch/i386/kernel/setup.c	1.70    -> 1.71   
>>#
> 
> ...
> 
>>-#define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
>>+#define NCAPINTS	6	/* Currently we have 6 32-bit words worth of info */
> 
> 
> If you change NCAPINTS you also have to change the hardcoded
> struct offset X86_VENDOR_ID in arch/i386/kernel/head.S. Otherwise
> nasty stuff happen at boot since boot_cpu_data gets broken.


hmmm, reality doesn't seem to bear that out...  I made the same change 
to 2.6, without touching head.S, and life continues without "nasty 
stuff" AFAICS.

Do both 2.4 and 2.6 need this change?  And, why didn't 2.6 break?

	Jeff



