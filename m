Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWEXGmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWEXGmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 02:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWEXGmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 02:42:55 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:49298 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932619AbWEXGmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 02:42:54 -0400
Message-ID: <4473FFB6.5010601@aitel.hist.no>
Date: Wed, 24 May 2006 08:39:50 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <44700ACC.8070207@gmail.com>	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>	 <200605230048.14708.dhazelton@enter.net>	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>	 <E1Fifom-0003qk-00@chiark.greenend.org.uk> <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
In-Reply-To: <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/23/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
>> Jon Smirl <jonsmirl@gmail.com> wrote:
>>
>> > 1) Running the video ROM at boot to reset cards, emu86
>>
>> Jon, how many times am I going to have to tell you that this won't work?
>> The video ROM is not always present on laptop hardware, and even when it
>> is it may jump into sections of ROM that have vanished since boot.
>> In the long run, graphics drivers need to know how to program cards from
>> scratch rather than depending on 80x25 text mod being there for them.
>
> 1) I didn't put a lot of detail into the line item but you only need
> to use the ROM to reset secondary cards on x86 architectures. Primary
> cards are always initialized by the system BIOS so you don't need to
> run their ROM on boot. I think the only way to get a secondary card
> into a laptop is through a PCMCIA slot and I've only seen one PCMCIA
> video card.
I wonder, could this secondary initialization be done by the bootloader?
A standard pc bios don't initialize extra graphichs cards, and making
a custom bios isn't easy.  But the boot loader (lilo/grub) runs in a mode
where calling into a bios should be easy. 

Or will there be a lot of trickery in mapping the secondary (and
tertiary...) card bioses somewhere in order to run them?

Helge Hafting
