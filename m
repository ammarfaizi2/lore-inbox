Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272385AbTHIOH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272378AbTHIOGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:06:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55172 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272366AbTHIOFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:05:43 -0400
Message-ID: <3F34FF9E.8080005@pobox.com>
Date: Sat, 09 Aug 2003 10:05:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
References: <200308081941.h78JfDKa029002@harpo.it.uu.se>
In-Reply-To: <200308081941.h78JfDKa029002@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Fri, 08 Aug 2003 09:15:03 -0400, Jeff Garzik wrote:
> 
>>>If you change NCAPINTS you also have to change the hardcoded
>>>struct offset X86_VENDOR_ID in arch/i386/kernel/head.S. Otherwise
>>>nasty stuff happen at boot since boot_cpu_data gets broken.
>>
>>
>>hmmm, reality doesn't seem to bear that out...  I made the same change 
>>to 2.6, without touching head.S, and life continues without "nasty 
>>stuff" AFAICS.
>>
>>Do both 2.4 and 2.6 need this change?  And, why didn't 2.6 break?
> 
> 
> 2.4.21-rc1 with NCAPINTS==6 hangs at boot in the local
> APIC timer calibration step; before that it detected a
> 0MHz bus clock and the local APIC NMI watchdog was stuck.
> Correcting head.S:X86_VENDOR_ID fixes these problems.
> 
> Without correcting head.S:X86_VENDOR_ID, head.S will store
> the vendor id partly in the capabilities array. This breaks
> both the capabilities and the vendor id. I can't say why 2.6
> works, but obviously the CPU setup code has changed since 2.4.
> 
> BTW, the patch below should be applied to 2.6.


Thanks for the patch, and for explaining.

	Jeff



