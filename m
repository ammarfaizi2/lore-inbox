Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbRDDWkw>; Wed, 4 Apr 2001 18:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132512AbRDDWkd>; Wed, 4 Apr 2001 18:40:33 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:52232 "HELO
	mail11.speakeasy.net") by vger.kernel.org with SMTP
	id <S132511AbRDDWkY>; Wed, 4 Apr 2001 18:40:24 -0400
Message-ID: <3ACB94E3.2030108@megapathdsl.net>
Date: Wed, 04 Apr 2001 14:40:51 -0700
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac2 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: "Joachim 'roh' Steiger" <roh@convergence.de>
CC: Thomas Dodd <ted@cypress.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted due to
In-Reply-To: <Pine.LNX.4.21.0104050004060.21943-100000@campari.convergence.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim 'roh' Steiger wrote:

> i would like to help to track down this problem
> i'm using a gigabyte 7IXE revision 1.1
> kernel is 2.4.1
> 
> lspci output for usb:
> 00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
> (rev 06) (prog-i
> f 10 [OHCI])
>         Flags: bus master, medium devsel, latency 16, IRQ 11
>         Memory at efffc000 (32-bit, non-prefetchable) [size=4K]
> 
> 
> On Wed, 4 Apr 2001, Miles Lane wrote:
> 
>> Thomas Dodd wrote:
>> 
>> 
>>> Alan Cox wrote:
>>> 
>>> 
>>>> because we dont know the full scope of the problem yet.
>>> 
>>> Exactly how many bug reports has this caused?
>>> What kind of problems?
>> 
> 
> here i only have this kernelmessage floating around in my logfiles about 1
> time the day: 
> 
> Apr  4 14:47:15 campari kernel: usb-ohci.c: bogus NDP=204 for OHCI 
> usb-00:07.4
> Apr  4 14:47:15 campari kernel: usb-ohci.c: rereads as NDP=4
> 
> 
>> error."  Most of the time, when the error occurs, it seems
>> pretty benign.  That is, I haven't noticed it crashing USB
>> device connections, causing data corruption or OOPSen.
>> Some folks _have_ reported OOPSen, though, that seemed to
>> be triggered by the erratum #4 hardware bug.  I think I
>> may have had one of these a long time ago.
> 
> 
> as you see it's revision 6
> i've had no other problems with usb for now and use this
>  idVendor           0x046d Logitech Inc.
>  idProduct          0xc00c 
> usb-wheelmouse all the time
> 
> i've never had this kernel or previous kernel (2.4.0test8) oopsen 
> and it runs perfectly stable here
> 
> 
>> I believe David has found that there definitely are code
>> paths where this hardware bug can cause failures of various
>> sorts and that's why the AMD-756 has been blacklisted.
> 
> 
> since i did'nt cause any troubles here i would not like to have the
> complete AMD-756 blacklisted in the ohci-driver
> eventually only some revisions are that bad
> 
> please correct me if i'm wrong i only don't want to blacklist complete
> chipset-series

Hi Joachim,

Personally, I agree with you, but I can also understand David's
desire to avoid wasting time chasing phantom bugs that only
show up due to this broken hardware.  If it turns out that
there is actually a well-defined workaround that AMD will
tell us about, it shouldn't take too long before we have a
real fix and the AMD-756 can be taken off of the blacklist.

My guess is that there are specific drivers for which this
hardware bug causes problems.  You probably just aren't
using the *right* drivers.  :-)

Luckily, USB add-on cards are pretty cheap, so I suppose you
could just put a new host-controller in your test machine
for a month or two until David and Alan get this sorted out
with AMD.  Think of it this way, you'll have more hardware
configurations to test with, so get a UHCI or EHCI card.
Woohoo!  (Only half kidding)

	Miles

