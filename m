Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWJWUhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWJWUhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWJWUhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:37:19 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:61574 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1750928AbWJWUhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:37:18 -0400
Message-ID: <453D27F8.8020509@qumranet.com>
Date: Mon, 23 Oct 2006 22:37:12 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/13] KVM: vcpu execution loop
References: <453CC390.9080508@qumranet.com> <200610232141.45802.arnd@arndb.de> <453D230D.7070403@qumranet.com> <200610232229.41934.arnd@arndb.de>
In-Reply-To: <200610232229.41934.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 20:37:17.0723 (UTC) FILETIME=[07E70EB0:01C6F6E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Monday 23 October 2006 22:16, Avi Kivity wrote:
>   
>>> This looks like you should simply put it into a .S file.
>>>
>>>  
>>>       
>> Then I lose all the offsetof constants down the line.  Sure, I could do
>> the asm-offsets dance but it seems to me like needless obfuscation.
>>     
>
> Ok, I see.
>
> How if you pass &vcpu->regs and &vcpu->cr2 to the functions instead of 
> kvm_vcpu?
>
>   

I could do that, but I feel that's more brittle.  I might need more (or 
other) fields later on.  It will also cost me more  pushes on the stack 
(no real performance or space impact, just C64-era frugality).


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

