Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270641AbRHNSaD>; Tue, 14 Aug 2001 14:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270630AbRHNS3x>; Tue, 14 Aug 2001 14:29:53 -0400
Received: from lips.borg.umn.edu ([160.94.232.50]:53253 "EHLO
	lips.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S270643AbRHNS3u>; Tue, 14 Aug 2001 14:29:50 -0400
Message-ID: <3B794B4F.1000303@thebarn.com>
Date: Tue, 14 Aug 2001 11:01:19 -0500
From: Russell Cattelan <cattelan@thebarn.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andre Pang <ozone@algorithm.com.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci + SMP -> bad
In-Reply-To: <20010814002131.A26321@bubba.toscano.org> <E15Wdc6-00016N-00@the-village.bc.nu> <997794181.326309.1471.nullmailer@bozar.algorithm.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Pang wrote:

>On Tue, Aug 14, 2001 at 01:48:06PM +0100, Alan Cox wrote:
>
>>>	- use the uhci USB driver when I'm using a USB printer.  If I
>>>	  use the usb-uhci driver with my USB printer, the whole system
>>>	  locks.  This has been reported a few times on LKML,
>>>	  linux-usb-users, and linux-usb-developers and nobody helped,
>>>	  but a few people wrote back with "me too"s.  It was broken in
>>>	  the trasnition from 2.4.3 to 2.4.4 and only seems to affect
>>>	  SMP systems.  I just gave up on USB printing and went back to
>>>	  my parallel port.
>>>
>>usb-uhci seems to not be SMP safe. Ultimately we don't need both uhci
>>drivers so that hasnt been one that worried me.  Probably we should drop
>>the other uhci driver over time (2.5 maybe)
>>
>
>i'd just thought i'd verify that usb-uchi seems to be causing
>some havoc on SMP boxes.
>
>i've had complete crashes (Alt-SysRq-s doesn't respond) when i
>try to print stuff to a USB printer using the usb-uchi and
>printer modules.  this is on an SMP box.
>
>however -- 2.4.2 works perfectly for that.  it broke from 2.4.4
>onward (tried 2.4.[5-7], i'm presuming .8 hasn't fixed the
>problem.)
>
>if anybody wants me to help them diagnose the problem, i'd be
>more than happy to, but i'm not sure where to start at the
>moment.
>

Note the usb sound driver does that same thing even on a UP box (with 
SMP kernel and UP kernel)

I've tried to debug the problem but setting nmi_watchdog=1 at boot time 
does seem
to catch the problem so I don't have much to go on.

If you haven't set nmi_watchdog yet you may want to try it and see if 
you have
better luck.

And yes comfirmed 2.4.3 works 2.4.[45678] does not.


-Russell Cattelan


