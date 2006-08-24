Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWHXLIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWHXLIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHXLIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:08:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:34197 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751114AbWHXLIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:08:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent:from;
        b=HqBUWHPmu+1Wxow4Crrjk/Pf9qW2tzj4k+jlzR0HlpiKYPf49CaDLCY0THIn63YR7ibooqBVscJDYVIeABFcPGhCPGqmUSdQGV//EY/u1cfVNnuV493kfAoV0Dhm8fC4YeEdvI1Hw1GfPOZ0947CoN5doAi0RDKjgdtdC2KAaRU=
Date: Thu, 24 Aug 2006 13:08:55 +0200
To: "Denis Vlasenko" <vda.linux@googlemail.com>
Subject: Re: Specify devices manually in exotic environment
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
References: <op.teo9mqjlepq0rv@localhost> <200608231313.37976.vda.linux@googlemail.com> <op.teq4xxc2epq0rv@localhost> <200608241108.52379.vda.linux@googlemail.com>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tesbw5xzepq0rv@localhost>
In-Reply-To: <200608241108.52379.vda.linux@googlemail.com>
User-Agent: Opera Mail/9.00 (Linux)
From: Milan Hauth <milahu@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 11:08:52 +0200, Denis Vlasenko  
<vda.linux@googlemail.com> wrote:

> On Wednesday 23 August 2006 21:40, Milan Hauth wrote:
>> I have tried MTD's NAND module according this [1] document, but it also
>> did not work.
>>
>> As Richard B. Johnson <linux-os@analogic.com> already mentioned, a  
>> regular
>> IDE interface has to be emulated. Somehow. Anyhow.
>
> Yes, I never saw flash-based IDE devices, but they exist, that's true.
> However, it's not necessarily what you have.
> I think that IDE devices should be detected by kernel at boot-up.
> You say that they are not. That's why I'm inclined to think
> your flash memory is not IDEish.

What I also forgot to mention is, that it's a SmartMedia Flash Card I have  
here, which is told to always identify as a IDE device.


> lsusb? Or if you have no lsusb, then:
>
> # mount | grep usb
> none on /proc/bus/usb type usbfs (rw)

Ohh, that's why lsusb never worked.. but you won't like the current result:

Bus 001 Device 003: ID 046a:002b Cherry GmbH  -->  Keyboard
Bus 001 Device 002: ID 0451:2046 Texas Instruments, Inc. TUSB2046 Hub
Bus 001 Device 001: ID 0000:0000  -->  What the..?


But I'm afraid I broke my SMC, while playing around with my disassembled  
T20, since GRUB hangs with 'GRUB _' without having changed anything in the  
software. D'oh!

That's why I can't test with 'USB Mass Storage' support in the kernel at  
the moment, which would probably uncover the mysterious '0000:0000' USB  
device. Gonna try again next week with a new SMC.

Cheers, milahu
