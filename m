Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAEPdo>; Fri, 5 Jan 2001 10:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRAEPd3>; Fri, 5 Jan 2001 10:33:29 -0500
Received: from pump3.york.ac.uk ([144.32.128.131]:32412 "EHLO pump3.york.ac.uk")
	by vger.kernel.org with ESMTP id <S131964AbRAEPdM>;
	Fri, 5 Jan 2001 10:33:12 -0500
Message-ID: <3A55E901.5030606@demeter.cs.york.ac.uk>
Date: Fri, 05 Jan 2001 15:32:17 +0000
From: Michel Salim <mas118@demeter.cs.york.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.13 i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, dhinds@valinux.com
Subject: Re: i82365 PCI-PCMCIA bridge still not working in 2.4.0-test11
In-Reply-To: <3A52F33D.2050105@demeter.cs.york.ac.uk>  <3A1C6D4C.7060306@demeter.cs.york.ac.uk> <3A1AC075.4020506@cs.york.ac.uk> <4186.974889923@redhat.com> <11299.974975638@redhat.com> <9752.978515885@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> mas118@demeter.cs.york.ac.uk said:
> 
>> Manually inputting i365_base=0x1030 when loading the module results in
>>  the same freeze - nothing works at all, had to do a full hardware
>> reset.  This is on the latest 2.4.0-prerelease... 
> 
> 
> Is this the code in 2.4.0-prerelease or the code I sent you? Sounds like 
> it's probably dying in an IRQ storm.
>
The one in prerelease.

 
> I have a full databook for the i82092aa and a selection of example boards - 
> was yours one of those or another type? I'm not entirely sure when I'll 
> have time to poke at it again - I may wait for the 2.5 branch.
> 
> mas118@demeter.cs.york.ac.uk said:
> 
>> Any chance it's due to IRQ sharing?
> 
> 
> Possibly. Is any driver trying to use irq 11? Can you disable the irq for 
> the video card in your BIOS?
> 
> --
> dwmw2

Well, got it working under 2.2.17. I suspect it is just a matter of the 
drivers in 2.4.x not accomodating desktop-based PCMCIA readers. In the 
latest PCMCIA Howto there is a subsection under 2.3 on such devices and 
workarounds needed to get them running - none of them are recognised by 
the i82365 driver in 2.4.0-prerelease.

I think I'll just stick to 2.2.x for the time being - if anyone fancy a 
go at it I'm more than willing to try out the code.

Regards,

-- 
Michèl Alexandre Salim

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
