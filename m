Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129434AbQKWBgS>; Wed, 22 Nov 2000 20:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129529AbQKWBgH>; Wed, 22 Nov 2000 20:36:07 -0500
Received: from pump3.york.ac.uk ([144.32.128.131]:57302 "EHLO pump3.york.ac.uk")
        by vger.kernel.org with ESMTP id <S129434AbQKWBf5>;
        Wed, 22 Nov 2000 20:35:57 -0500
Message-ID: <3A1C6D4C.7060306@demeter.cs.york.ac.uk>
Date: Thu, 23 Nov 2000 01:05:16 +0000
From: Michel Salim <mas118@demeter.cs.york.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.13 i686; en-US; m18) Gecko/20001117
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Michel Salim <mas118@cs.york.ac.uk>, LKML <linux-kernel@vger.kernel.org>,
        dhinds@valinux.com
Subject: Re: i82365 PCI-PCMCIA bridge still not working in 2.4.0-test11
In-Reply-To: <3A1AC075.4020506@cs.york.ac.uk> <4186.974889923@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch... but it does not quite work. It applies cleanly, 
but upon booting the patched kernel, the machine freezes completely upon 
PCMCIA initialisation (it got to the point where the init script said 
'Loading modules' then nothing). CTRL+ALT+DEL does not work, either.

Anyone got a clue? Would love to help debug this if someone would just 
walk me through it.

Michel

David Woodhouse wrote:

> mas118@cs.york.ac.uk said:
> 
>>  Installed kernel 2.4.0-test11 on my Debian Woody box today. Had no
>> problem apart from getting PCMCIA to work. I have a PCI-PCMCIA adapter
>>  on my desktop PC, using the Cirrus Logic CL6729 chipset;
> 
> 
> Linus got a bit carried away when stripping out all the CardBus support 
> from i82365, and took out the support for PCI-PCMCIA bridges too.
> 
> Try this snapshot of my development tree, or use lspci to find the IO 
> address of the device and specify that to the existing module.
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
