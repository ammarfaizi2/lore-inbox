Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287381AbSACVpZ>; Thu, 3 Jan 2002 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288334AbSACVpQ>; Thu, 3 Jan 2002 16:45:16 -0500
Received: from tourian.nerim.net ([62.4.16.79]:49412 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S288333AbSACVo7>;
	Thu, 3 Jan 2002 16:44:59 -0500
Message-ID: <3C34D0D9.6010008@free.fr>
Date: Thu, 03 Jan 2002 22:44:57 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: BALBIR SINGH <balbir.singh@wipro.com>, esr@thyrsus.com,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <E16M7Ab-0008DP-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>This would break things like cross-compilation. Not sure how many people
>>use it though. You will have to be on the machine for which you intend
>>to compile the kernel. If you are compiling the kernel for the same machine
>>then it is the best thing to happen, provided the software doing the
>>configuration for u is not broken
>>
> 
> I'm really not too worried about Grandma cross compiling kernels


ROTFL at the mental image of my Grandma configuring a cross-compiling 
environment.

Eric, you said somewhere else in this thread that eventually we should 
be able to make kernel configuration as easy as MAC configuration.

In short we can't.

MAC configuration is a dream we can't touch. The core hardware and most 
importantly the mainboard firmware is done by the very same company that 
develops the OS. I guess they didn't shout themselves in the feet and 
made firmware and hardware with clean enough interfaces that they could 
make hardware detection trivial.
Even if they did mistakes, had bugs, they have the exhaustive list of 
them and most probably can easily use workarounds.

Contrast this with the PC world : numerous mainboard manufacturers, bios 
developpers, extension card manufacturers, Operating Systems, each with 
their own bugs others desesperately try to work around...

The general case where all works ok (no bugs in dmi, pnp, ...) is the 
exception and the land here is full of workarounds and dead ends if you 
want to do hardware detection.

The worst case : the plain old ISA bus where you can't try to detect a 
specific extansion card without risking to lock the system hard by 
screwing some other type that is listening on ports you probed.

What I think we should try is to identify the most stable interfaces 
(lspci works ok for most systems and would be of great help), use them 
and let the user fill the gap (ISA/MCA/VLB/AGP bus switches for the 
*user* is a great idea indeed).

We are quite PC centric here. But other archs are certainly far more 
friendly to what you're up to.

LB.

