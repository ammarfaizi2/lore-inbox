Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWERSPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWERSPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWERSPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:15:53 -0400
Received: from fmr19.intel.com ([134.134.136.18]:64701 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932113AbWERSPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:15:52 -0400
Message-ID: <446CB9C4.6060606@linux.intel.com>
Date: Thu, 18 May 2006 11:15:32 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Konrad Rzeszutek <konradr@us.ibm.com>, linux-kernel@vger.kernel.org,
       konradr@redhat.com
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the
 e820 table.
References: <200605172153.35878.konradr@us.ibm.com> <446C70A8.5050909@linux.intel.com> <20060518155642.GC7617@andromeda.dapyr.net> <446CA4D3.80105@linux.intel.com> <446CB791.5030304@vc.cvut.cz>
In-Reply-To: <446CB791.5030304@vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Arjan van de Ven wrote:
>> Konrad Rzeszutek wrote:
>>
>>> That is definitely a problem - and the "sanity-check" can definitly bail
>>> out on those BIOSes and not crash Linux. The other side of the coin 
>>> is that BIOSes that do implement the MCFG/E820 correctly are penalized:
>>
>> I hereby contest that it's implemented correctly if it's not marked 
>> reserved...
> 
> PCI Firmware Specification 3.0 
> (http://www.pcisig.com/members/downloads/specifications/conventional/pcifw_r3.0.pdf), 
> page 42, notes for table 4-2, paragraph 2 says that firmware must report 
> MCFG as reserved region.  Last sentence of same paragraph says that 
> resources may be optionally marked reserved by E820 or EFIGetMemoryMap, 

resources == BARs, MCFG is a whole different beast

> but must be always reported as motherboard resources through ACPI  (for 
> exact citation please see document itself, it is not freely available so 
> I'm not going to copy-paste text from it without written permission from 
> pcisig...).
> 
> So it seems to me that BIOS not reporting MMCONFIG as reserved through 
> E820 is compliant, and what matters is that MMCONFIG must be reported as 
> ACPI motherboard resource.

I think that's not the right interpretation; resources==BARs in this context.
I'll find a way to get that document and recheck to make sure...
