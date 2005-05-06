Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVEFVh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVEFVh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVEFVh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:37:27 -0400
Received: from quark.didntduck.org ([69.55.226.66]:18577 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261276AbVEFVhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:37:00 -0400
Message-ID: <427BE3A0.7010000@didntduck.org>
Date: Fri, 06 May 2005 17:37:36 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3c509 module and 2.6 kernel: not all NICs are recognized?
References: <427BD143.4010909@tls.msk.ru> <427BDD22.1080601@tls.msk.ru>
In-Reply-To: <427BDD22.1080601@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> A bit more information.
> 
> Michael Tokarev wrote:
> 
>>Finally, I tried to boot our gateway machine into 2.6 (2.6.11.8
>>to be certain) kernel.  The machine is quite old, it's 100MHz
>>Pentium-classic, yet it works as a router just fine.
>>
>>And surprizingly, this is the first machine I tried to upgrade
>>to 2.6 which does not work.
>>
>>It have 4 3c509 cards, one EISA and 3 ISA.  Here's the dmesg
>>output when I load 3c509 module on 2.4 kernel:
>>
>>eth0: 3c5x9 at 0x2000, 10baseT port, address  00 60 08 4b 31 bf, IRQ 15.
>>3c509.c:1.19 16Oct2002 becker@scyld.com
>>http://www.scyld.com/network/3c509.html
>>eth1: 3c5x9 at 0x3000, 10baseT port, address  00 20 af 92 f6 ef, IRQ 7.
>>3c509.c:1.19 16Oct2002 becker@scyld.com
>>http://www.scyld.com/network/3c509.html
>>eth2: 3c5x9 at 0x4000, 10baseT port, address  00 20 af 92 83 02, IRQ 5.
>>3c509.c:1.19 16Oct2002 becker@scyld.com
>>http://www.scyld.com/network/3c509.html
>>eth3: 3c5x9 at 0x5000, BNC port, address  00 20 af 99 f2 ac, IRQ 12.
>>3c509.c:1.19 16Oct2002 becker@scyld.com
>>http://www.scyld.com/network/3c509.html
>>
>>(the last one, with IRQ#12 and BNC port, is EISA).
> 
> 
> All the ISA cards are in EISA mode (set in 3c5x9cfg.exe utility).
> IRQs are assigned by the EISA bus (set by EISA configuration utility).
> If any of the ISA cards are in non-EISA mode, the some of them
> does not work at all, starting from EISA BIOS config during boot.
> So I can't switch the cards into PNP mode.
> 
> Also, I tried setting the cards manually with 3c509 module
> parameters.  The only parameter one can tweak is irq=,
> but it seems the parameter is ignored -- I tried
>  modprobe 3c509 irq=15,7,5,12
> but it still detects only the EISA card with irq=12, just
> like without irq= line at all.
> 
> 

what does dmesg|grep EISA show?

--
				Brian Gerst
