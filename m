Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUD2WUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUD2WUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbUD2WUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:20:42 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:14734 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264997AbUD2WUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:20:39 -0400
In-Reply-To: <40917DBA.1080308@techsource.com>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40911C01.80609@techsource.com> <20040429213246.GA15988@valve.mbsi.ca> <40917DBA.1080308@techsource.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6DB1DC9C-9A2B-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Thu, 29 Apr 2004 18:20:32 -0400
To: Timothy Miller <miller@techsource.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 29, 2004, at 6:12 PM, Timothy Miller wrote:
>
> Marc Boucher wrote:
>> Giuliano Colla wrote:
>>> Can you honestly tell apart the two cases, if you don't make a it a 
>>> case of
>>> "religion war"?
>> On Thu, Apr 29, 2004 at 11:15:13AM -0400, Timothy Miller answered:
>>> Firmware downloaded into a piece of hardware can't corrupt the 
>>> kernel in the
>>> host.
>>>
>>> (Unless it's a bus master which writes to random memory, which might 
>>> be
>>> possible, but there is hardware you can buy to watch PCI 
>>> transactions.)
>> and unless it's a card with binary-only, proprietary BIOS code called 
>> at
>> runtime by the kernel, for example by the vesafb.c video driver,
>> which despite this has a MODULE_LICENSE("GPL").
>> Could someone explain why such execution of evil proprietary 
>> binary-only
>> code on the host CPU should not also "taint" the kernel? ;-)
>
> That's a good question, but the BIOS code you're talking about is not 
> part of the kernel.  Sure, it's possible that it might still corrupt 
> the kernel, but it's not being loaded into it as a module.  The 
> developer of the BIOS code never intended for their code to be run by 
> the Linux kernel.

The proprietary modem code for the HSF driver is not part of the 
kernel, nor did its original developers ever intend for it to be run by 
the Linux kernel.

Whether proprietary binary-only code is dynamically loaded through the 
module subsystem or physically by someone installing a card is a 
technicality with little relevance.

>
> Is it still dangerous?  Yes.  Is it a violation of the GPL?  No.
>
> Also, developers of modules which thunk to BIOS code are aware of the 
> potential problems and are typically willing to take responsibility 
> for investigating bugs in their own code.  (Bugs in the BIOS means 
> you're screwed and need to get new hardware.)  Developers of 
> proprietary drivers are notoriously unhelpful when it comes to fixing 
> bugs in their code.
>

Linuxant is also more than willing to take responsibility for fixing 
potential bugs in its drivers: it's a big part of our purpose and 
business.

Marc

