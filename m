Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316699AbSEVTgN>; Wed, 22 May 2002 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSEVTgM>; Wed, 22 May 2002 15:36:12 -0400
Received: from horus.webmotion.com ([209.87.243.246]:5519 "EHLO
	horus.webmotion.ca") by vger.kernel.org with ESMTP
	id <S316699AbSEVTgK>; Wed, 22 May 2002 15:36:10 -0400
Message-ID: <3CEBF314.3090209@bonin.ca>
Date: Wed, 22 May 2002 15:35:48 -0400
From: Andre Bonin <kernel@bonin.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us, fr-ca
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
In-Reply-To: <20020520223132.GC25541@kroah.com> <008b01c2012d$69db21c0$0601a8c0@CHERLYN> <20020522192101.GG4802@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, May 21, 2002 at 09:10:04PM -0400, André Bonin wrote:
> 
>>----- Original Message -----
>>From: "Greg KH" <greg@kroah.com>
>>To: <linux-usb-devel@lists.sourceforge.net>
>>Cc: <linux-kernel@vger.kernel.org>; <Linux-usb-users@lists.sourceforge.net>
>>Sent: Monday, May 20, 2002 6:31 PM
>>Subject: What to do with all of the USB UHCI drivers in the kernel?
>>
>>
>>
>>>Ok, now that 2.5.16 is out, we have a total of 4 different USB UHCI
>>>controller drivers in the kernel!  That's about 3 too many for me :)
>>>
>>>So what to do?  I propose the following:
>>>
>>>  From now until July 1, I want everyone to test out both the uhci-hcd
>>>  and usb-uhci-hcd drivers on just about every piece of hardware they
>>>  can find.  This includes SMP, UP, preempt kernels, big and little
>>>  endian machines, and loads of different types of USB devices.
>>>
>>The UHCI driver never recognizes my hardware.  The OHCI driver (in the
>>2.4.18 kernel) does however.  My Asus A7M266-D doesn't have an onboard USB
>>but they ship an add-on card with the motherboard (made by Asus).
>>
> 
> This is probably because you have an OHCI hardware device, not a UHCI
> device.  What does 'lspci -v' say for your machine?

Sorry, i'me not too familiar with the USB architecture.  Anyway here is 
the relevant lspci entries (note: I did this under my working 2.4.18)

02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
         Subsystem: Unknown device 807d:0035
         Flags: bus master, medium devsel, latency 32, IRQ 19
         Memory at cd000000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2

02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
         Subsystem: Unknown device 807d:0035
         Flags: bus master, medium devsel, latency 32, IRQ 16
         Memory at cc800000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2

02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
         Subsystem: Unknown device 807d:1043
         Flags: bus master, medium devsel, latency 32, IRQ 17
         Memory at cc000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2


> And how does 2.5.17 work for you?

Not too good beacuse I don't have the option of enabling OHCI :)  Are we 
still keeping it?


> thanks,

I thank you sir!

> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 



