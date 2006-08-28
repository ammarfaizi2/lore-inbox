Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWH1RZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWH1RZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWH1RZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:25:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:29837 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750785AbWH1RZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:25:52 -0400
Message-ID: <44F326CA.9040206@zytor.com>
Date: Mon, 28 Aug 2006 10:24:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
References: <20060827084417.918992193@goop.org> <200608271757.18621.ak@suse.de> <44F1D464.5020304@goop.org> <200608272019.15067.ak@suse.de>
In-Reply-To: <200608272019.15067.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Sunday 27 August 2006 19:20, Jeremy Fitzhardinge wrote:
>> Andi Kleen wrote:
>>>> +1:	movw GS(%esp), %gs
>>>>     
>>> movl is recommended in 32bit mode
>>>   
>> arch/i386/kernel/entry.S: Assembler messages:
>> arch/i386/kernel/entry.S:334: Error: suffix or operands invalid for `mov'
> 
> Looks like a gas bug to me.
> 

Not so much a bug as a misfeature.  They changed the meaning of "movw" 
and "movl" on segment registers between versions.

Either way, just "mov" should work.

	-hpa

