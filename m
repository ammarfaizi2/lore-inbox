Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262381AbSJaOUv>; Thu, 31 Oct 2002 09:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbSJaOUv>; Thu, 31 Oct 2002 09:20:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28939 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262381AbSJaOUu>;
	Thu, 31 Oct 2002 09:20:50 -0500
Message-ID: <3DC13D81.4050008@pobox.com>
Date: Thu, 31 Oct 2002 09:26:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Peter Chubb <peter@chubb.wattle.id.au>, tridge@samba.org, tytso@mit.edu
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <20021031030143.401DA2C150@lists.samba.org> <20021031101558.GB7487@fib011235813.fsnet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:

>ii) vcalloc, this *didn't* get merged, and will probably end up getting
>    moved into dm.h.
>

Yeah, historically we have avoided things like this.

kcalloc gets proposed every year or so too.

>iii) ioctl32 support: people have argued against an ioctl interface,
>     and I'm inclined to agree with them, which is why I'm going to
>     publish an fs interface shortly.  However, given that we are
>     currently using an ioctl interface how do we avoid adding support for
>     32bit userland/64 kernel space ?  If EVMS isn't touching these
>     files does that mean they're not supporting these architectures ?
>
>        arch/mips64/kernel/ioctl32.c
>        arch/ppc64/kernel/ioctl32.c
>        arch/s390x/kernel/ioctl32.c
>        arch/sparc64/kernel/ioctl32.c
>  
>

Well, I'll note that ALSA compartmentalizes their ioctl32 handling 
within their own subsystem, which seems like a decent solution.

That said, [maybe I'm biased <g>], using an fs interface allows one to 
completely eliminate an ioctl32 interface.  That would be the direction 
I would greatly prefer by the time 2.5.x hits the code freeze.

Best regards, and congrats for getting it merged,

    Jeff




