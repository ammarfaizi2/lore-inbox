Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTLDHmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 02:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTLDHmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 02:42:38 -0500
Received: from mail.gmx.de ([213.165.64.20]:33938 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263158AbTLDHmh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 02:42:37 -0500
X-Authenticated: #4512188
Message-ID: <3FCEE56B.9040404@gmx.de>
Date: Thu, 04 Dec 2003 08:42:35 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@hotmail.com>
CC: "b@netzentry.com" <b@netzentry.com>, linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <3FCE90CD.6060501@netzentry.com> <20031204024547.GA175@tesore.local>
In-Reply-To: <20031204024547.GA175@tesore.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>>Thanks everyone for your continued interest in this, I'll
>>try and test the no-onboard-PATA + UP LAPIC and IOAPIC and
>>add-in-card-PATA with no onboard PATA + + UP LAPIC and IOAPIC
>>when I get a spare moment which is rare.

I don't think that the AMD IDE is the problem. I have compiled it in, as 
well, but I am using the onboard SATA. Since this can be considered as 
an pci-card (the chip is connected to the pci bridge) I think ölocking 
occurs on high traffic on PCI bus. Like now I get over 60mb/s with my 
HD. Formerly I got only 25mb/s. BEfore I could do some rounds of hdparm 
-t, before it locks. Now it locks immediatly when doing hdparm -t when 
APIC is enabled.

SO, I think it is not IDE specific. DOes anybody have gigabit network 
card? MAybe that oe should try to push something big through it (without 
reading from hd). If that leads to lock up we have a semi proof that it 
is due to high traffic on pci-bus.

