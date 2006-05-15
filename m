Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWEORR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWEORR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWEORR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:17:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:17090 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964995AbWEORR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:17:26 -0400
Message-ID: <4468B7A0.2040309@pobox.com>
Date: Mon, 15 May 2006 13:17:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Brown, Len" <len.brown@intel.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH for 2.6.17] [3/5] i386/x86_64: Force pci=noacpi on HP
  XW9300
References: <CFF307C98FEABE47A452B27C06B85BB670FA6C@hdsmsx411.amr.corp.intel.com> <200605151905.42105.ak@suse.de>
In-Reply-To: <200605151905.42105.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 15 May 2006 18:47, Brown, Len wrote:
>>> The system has multiple PCI segments and we don't handle that properly
>>> yet in PCI and ACPI. Short term before this is fixed blacklist it to
>>> pci=noacpi.
>> I'm okay with the patch, but it makes me wonder...
>>
>> Is this the 1st/only system 
> 
> x86-
> 
> IA64/PA-RISC support subdomains successfully
> 
>> Linux has run on with multiple PCI segments? 
> 
> I think IBM summit somehow uses it too.
> 
> And there is a patch from Jeff Garzik I think to make the xw9300 subdomains 
> work (or rather implement subdomain support in arch/i386/pci/*), but it 
> breaks the Summit and possibly other non x86 systems. Greg 
> should know details about that.
> 
> As usual the systems usually boot even without this patch, but you can't 
> reach all PCI devices.
> 
>> What are your expectations for where "short-term" ends and "long-term"
>> begins?
> 
> I think Greg has Jeff's patch still queued somewhere, but it needs
> to be debugged to work everywhere. After that is done we can drop the blacklist 
> entry. Hopefully for 2.6.19?
> 
> For 2.6.17 I don't see any alternative to blacklisting.
> 
> -Andi
> 
> 


FWIW I also maintain this "PCI domain support for x86" stuff in a 
separate branch, which I keep up to date:

'pciseg' branch of
  git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

Haven't done anything substantive since the original implementation, 
just kept up with recent kernels.

The xw9300 continues to be my primary workstation (2x2 Opteron), but 
haven't found time to mess with PCI domains in a while.  The BIOS gives 
me the option to disable PCI domains, so I took the slack way out :)

	Jeff


