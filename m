Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271952AbRHVHNZ>; Wed, 22 Aug 2001 03:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271950AbRHVHNP>; Wed, 22 Aug 2001 03:13:15 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:30640 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271949AbRHVHNI>; Wed, 22 Aug 2001 03:13:08 -0400
Date: Wed, 22 Aug 2001 03:13:23 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jordan Breeding <ledzep37@home.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
Message-ID: <20010822031323.B3737@devserv.devel.redhat.com>
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com> <200108220004.f7M04Qx01206@devserv.devel.redhat.com> <3B8355D9.7DE64E38@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8355D9.7DE64E38@home.com>; from ledzep37@home.com on Wed, Aug 22, 2001 at 01:48:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 22 Aug 2001 01:48:57 -0500
> From: Jordan Breeding <ledzep37@home.com>
> To: Pete Zaitcev <zaitcev@redhat.com>,
>    Linux Kernel <linux-kernel@vger.kernel.org>

> Running 2.4.8-ac7 using the alternate uhci driver both my USB keyboard
> and mouse work fine.  I can't use the regular uhci driver because it
> aparently has SMP issues with keyboards and like to hard lock the entire
> system, no oops or anything, if any LED key
> (numlock,capslock,scrolllock) is pressed enough times to turn an LED on
> and then off.

I think I fixed it long ago - we shipped it with Red Hat Linux 7.1
on ia64, and in errata for i386. I recall arguing about it with
Georg Archer, and it was accepted into Linus tree. But perhaps not
every hole was plugged. 

>  Using 2.4.8-ac8 with the patch from below at least works
> more than stock 2.4.8-ac8 but I still get failures: specifically the
> regular uhci driver seems to work perfectly except for the issue noted
> above.

Well, good. If you have an SMP problem - post to the list.
I have 2 SMPs, one with uchi and one with ohci, which run well.
People used to think that USB on SMP was a non-issue, but
unfortunately companies like Dell started to ship rackmounted
SMPs with USB keyboards :)

>  But my uchi controller using the alternate uhci driver on
> 2.4.8-ac8 results in an unusable system, and with the patch below kind
> of works.  By kind of I mean that it doesn't oops and there aren't any
> of the couldn't assign id type messages but I get a ton of the "raced
> timeout" messages and the mouse and keyboard only sporadically work,

I think the JE uhci forgets to post a callback sometimes,
so I'll look. Meanwhile, try to remove that printout -
it's only for JE uhci bughunt.

-- Pete
