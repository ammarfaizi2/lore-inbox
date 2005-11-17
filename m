Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVKQWuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVKQWuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVKQWub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:50:31 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:25755 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964960AbVKQWub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:50:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=de0IRMA9ayym9MpSjj125BKAk0sjX8lxshYsavDa4/HHKRgobn0RqBVeb6P3UL9PmomuUAiBDHOE17+E297AlM5L4xqvwqmBOuKMY5kA6fv33ozpu5imFI+bEdxLjXTcn1n9rOVtQBRjksWmKPoLfRron9TmxzEm/0sZ5t8DKrI=
Message-ID: <e294b46e0511171450o14816979x9e20fa547654be65@mail.gmail.com>
Date: Thu, 17 Nov 2005 22:50:29 +0000
From: Bradley Chapman <kakadu@gmail.com>
To: Bart Samwel <bart@samwel.tk>
Subject: Re: Laptop mode causing writes to wrong sectors?
Cc: linux-kernel@vger.kernel.org, Jan Niehusmann <jan@gondor.com>
In-Reply-To: <437CF478.7010406@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>
	 <437C9334.3020606@samwel.tk>
	 <e294b46e0511170822w79e5478asf49183c8447c7c77@mail.gmail.com>
	 <437CF478.7010406@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Samwel,

On 11/17/05, Bart Samwel <bart@samwel.tk> wrote:
> Bradley Chapman wrote:
> > Mr. Samwel,
> >
> > On 11/17/05, Bart Samwel <bart@samwel.tk> wrote:
> >> OK, that's the second report then. I'm beginning to worry. :/
> >>
> >> Are you seeing any DMA timeout messages in your kernel log?
> >
> > Once, when my /var partition got trashed - about thirty or forty loud
> > and scary messages from the IDE core saying that various disk accesses
> > (i.e. normal read/writes) were failing. I do believe DMA was
> > mentioned.
>
> This could be the problem I was talking about. Was this happening during
> spindown or not?

I believe so. I only noticed it when I checked my dmesg after the
ipw2200 driver crapped out yet again...

>
> > Another time (i.e. just now), I got five Oopses in a row, most of them
> > in kmem_cache_alloc() but with one in generic_aio_file_read().
> > Unfortunately I am using fglrx right now so they are probably quite
> > meaningless...*
>
> I guess so. They all oops on reading the same address (0x05c2a5bb),
> there's something corrupted in the slab cache, cause unknown. Very
> possibly fglrx.

Indeed. I expected as such.

>
> > Most of the time though, I don't see anything.
>
> ...while still experiencing corruption?
>
> >> Bradley, Jan, since when have these problems been happening? Kernel
> >> version-wise, I mean?
> >
> > They started with 2.6.13. I can't remember ever expereincing random
> > partition trashing or random file corruption in 2.6.12. I tried
> > 2.6.14.1 - that kernel did Bad Things as well.
> >
> > So far though, as long as I stay on juice, 2.6.13 seems to behave.
>
> Hmmmm. This means that you could still be experiencing the same thing
> that Andrea Gelmini was reporting. Could you try the things he said made
> it worse, and check if things go wrong? You are, of course, allowed to
> decline because of the risk involved. :-) The things are:
>
> Big activity:
>
> * iozone -A
> * unrar big file
> * In order to make it happen faster:
>         cd /proc/sys/vm
>         echo 100 > dirty_background_ratio
>         echo 1000000 > dirty_expire_centisecs
>         echo 100 > dirty_ratio
>         echo 1000000 > dirty_writeback_centisecs

No thanks. I'll stick to 'normal usage' triggers and see if I can
gather any data that way ;-)))

>
> --Bart
>

Brad
--
SCREW THE ADS! http://adblock.mozdev.org/
