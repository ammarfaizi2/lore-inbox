Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316260AbSEWHh5>; Thu, 23 May 2002 03:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316362AbSEWHh4>; Thu, 23 May 2002 03:37:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47367 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316260AbSEWHh4>; Thu, 23 May 2002 03:37:56 -0400
Message-ID: <3CEC8D6B.9060500@evision-ventures.com>
Date: Thu, 23 May 2002 08:34:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andre Bonin <kernel@bonin.ca>, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
In-Reply-To: <20020520223132.GC25541@kroah.com> <008b01c2012d$69db21c0$0601a8c0@CHERLYN> <20020522192101.GG4802@kroah.com> <3CEBF314.3090209@bonin.ca> <20020522201546.GB5168@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Greg KH napisa?:
> On Wed, May 22, 2002 at 03:35:48PM -0400, Andre Bonin wrote:
> 
>>>This is probably because you have an OHCI hardware device, not a UHCI
>>>device.  What does 'lspci -v' say for your machine?
>>
>>Sorry, i'me not too familiar with the USB architecture.  Anyway here is 
>>the relevant lspci entries (note: I did this under my working 2.4.18)
>>
>>02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
>>        Subsystem: Unknown device 807d:0035
>>        Flags: bus master, medium devsel, latency 32, IRQ 19
>>        Memory at cd000000 (32-bit, non-prefetchable) [size=4K]
>>        Capabilities: [40] Power Management version 2
>>
>>02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
>>        Subsystem: Unknown device 807d:0035
>>        Flags: bus master, medium devsel, latency 32, IRQ 16
>>        Memory at cc800000 (32-bit, non-prefetchable) [size=4K]
>>        Capabilities: [40] Power Management version 2
>>
>>02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
>>        Subsystem: Unknown device 807d:1043
>>        Flags: bus master, medium devsel, latency 32, IRQ 17
>>        Memory at cc000000 (32-bit, non-prefetchable) [size=256]
>>        Capabilities: [40] Power Management version 2
> 
> 
> You only have EHCI and OHCI hardware.  No wonder the UHCI drivers do not
> work :)
> 
> 
>>>And how does 2.5.17 work for you?
>>
>>Not too good beacuse I don't have the option of enabling OHCI :)  Are we 
>>still keeping it?
> 
> 
> Yes, use the ohci-hcd driver.  Also you can use the ehci-hcd driver if
> you have any USB 2.0 devices, as it looks like you have a USB 2.0
> controller.


Could you please just do me a small favour and drop something
in to linux/Documentation. Becouse I'm right now already confused
about which driver to use and which alias to put in /etc/modules.conf
so kudzu stops hollering about not knowing what to do
if I out of a sudden reboot in to 2.5.xx kernel.

Many thank's in advance.

PS. I could of course figure it out of my self, but since
I don't attach anything to USB on my box *that* frequently.


