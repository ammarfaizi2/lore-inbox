Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUKOXKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUKOXKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUKOXKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:10:05 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:15816 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261643AbUKOXJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:09:17 -0500
Message-ID: <4199371C.2010101@free.fr>
Date: Tue, 16 Nov 2004 00:09:16 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       Adam Belay <ambx1@neo.rr.com>, bjorn.helgaas@hp.com, vojtech@suse.cz
Subject: Re: [PATCH] PNP support for i8042 driver
References: <41960AE9.8090409@free.fr>	 <200411140148.02811.dtor_core@ameritech.net>	 <41974DFD.5070603@free.fr> <d120d50004111506416237ff1b@mail.gmail.com>	 <419908B8.10202@free.fr> <d120d500041115122846b9f0fa@mail.gmail.com> <41993320.3010501@free.fr>
In-Reply-To: <41993320.3010501@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Hi,
> 

>>
>>
>> I think you need to make an effort to make a PCI device use IRQ12
>> but the idea is that if you don't have a mouse attached (but you do
>> have i8042) and you are short on free interrupts and your HW can
>> use IRQ12 for some other stuff let it have it. That is the reqson why
>> i8042 requests IRQ only when corresponding port is open. No mouse -
>> IRQ is free.
>>
> And what happen if you use irq12 for an other stuff and you plug your 
> mouse and try to use it. The motherboard hasn't desalocated the irq12 
> for mouse, so there will be a big conflict...
> 
In that case a boot param solve the problem, it says you could
desactivate the resource in the bios/acpi for the mouse.
So even if a mouse is plug, the other driver shouldn't receive others 
interrupts (I don't know exactly what happen if for example irq12 is 
used for pci and mouse in acpi config and if there are other protection 
again that case...)


Matthieu

