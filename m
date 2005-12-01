Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVLAWQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVLAWQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVLAWQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:16:42 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:44328 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932522AbVLAWQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:16:41 -0500
Date: Thu, 01 Dec 2005 17:14:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <1133470859.23362.59.camel@localhost>
To: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Perry Gilfillan <perrye@linuxmail.org>, Don Koch <aardvark@krl.com>,
       Michael Krufky - V4L <mkrufky@m1k.net>
Message-id: <200512011714.42325.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <438F38E6.7090303@m1k.net> <1133470859.23362.59.camel@localhost>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 16:00, Mauro Carvalho Chehab wrote:
I also took Hartmut out of the Cc: list, he is mailbombing me with a
sender id scheme of some kind for every reply I make to All:

Its very poor form to do that to a mailing list although I suspect its
because he is in the CC list and getting it directly if I don't remove
him from it.  He doesn't need 2 copies anyway.

> After checking the datasheets of Thompson tuner, and I have one guess:
>
> At board description, tda9887 is not there. This tuner needs to work
>properly.
>
> This small patch does enable it for your board.
>
> You should notice that you may need to use some parameters for tda0887
>to work properly, like using port1=0 port2=0 qss=0 as insmod options
> for this module. (these are some on/off bits at the chip, to enable
> some special functions - if 0/0/0 doesn't work you may need to test
> 0/0/1, .. 1/1/1).

I'm puzzled.  In 2.6.14.3, that tuner is not loaded, and its working
fine other than spamming the logs by the megabyte about

Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561b
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc02c5638
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc054561d
Nov 29 22:56:18 coyote last message repeated 2 times
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc0445624
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc008561c
Nov 29 22:56:18 coyote kernel: CORE IOCTL: 0xc054561d
Nov 29 22:56:49 coyote last message repeated 907 times
Nov 29 22:57:50 coyote last message repeated 1828 times
Nov 29 22:58:46 coyote last message repeated 1703 times
Nov 29 22:58:46 coyote kernel: CORE IOCTL: 0xc008561c

Other than that, its fine in ntsc.

I'm currently doing a 'modprobe cx88-dvb' to load everything, but you
mention using insmod with arguments above, so please clarify as to how
I should proceed after applying that patch to, oh lets live dangerously
and do it to 2.6.15-rc4.

>Cheers,
>Mauro.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


