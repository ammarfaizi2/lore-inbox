Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUJRSKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUJRSKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUJRSKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:10:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:39367 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267254AbUJRSHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:07:17 -0400
Message-ID: <41740430.30604@osdl.org>
Date: Mon, 18 Oct 2004 10:58:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: bevand_m@epita.fr, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: NMI watchdog detected lockup
References: <4172F91D.8090109@osdl.org>	<ckv123$pcs$1@sea.gmane.org>	<4173F9A7.2090504@osdl.org> <20041018200017.0098710d.ak@suse.de>
In-Reply-To: <20041018200017.0098710d.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, 18 Oct 2004 10:13:11 -0700
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
> 
>>Marc Bevand wrote:
>>
>>>On 2004-10-17, Randy.Dunlap <rddunlap@osdl.org> wrote:
>>>| 
>>>|  I'm seeing this often during a kernel build on AIC79xx.
>>>|  I did one kernel build on SATA without seeing this.
>>>|  This is on a dual-Opteron IBM Workstation A with
>>>|  2 GB RAM, SATA, & SCSI.
>>>|  [...]
>>>|  NMI Watchdog detected LOCKUP on CPU0, registers:
>>>|  [...]
>>>
>>>You are not the first one to observe frequent watchdog timeout
>>>lockup on dual Opteron systems during intense I/O operations,
>>>see this thread:
>>>
>>>  http://thread.gmane.org/gmane.linux.ide/1933
>>>
>>>Note: this does *not* seem to be SATA-related.
>>
>>Hi,
>>
>>Zwane suspected NMI spikes and advised me to disable nmi_watchdog
>>(nmi_watchdog=0).  After doing that, a kernel build completes
>>successfully, although with many messages like these:
>>
>>Uhhuh. NMI received for unknown reason 21.
> 
> 
> Something on your system creates bogus NMI interrupts. What chipset
> are you using exactly?
> 
> Sometimes chipsets can be programmed to raise NMIs when an PCI bus
> error occurs. 
> 
> 21 is the normal state (PIT timer running, but no errors logged) 
> 
> If you have an AMD 8131 it could be in theory erratum 54, but then
> normally one of the error bits in reason should be set.

Yes, it's an AMD-8111 / 8131 / 8151 / K8-northbridge machine.

-- 
~Randy
