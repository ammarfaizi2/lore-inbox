Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132549AbRDEDEZ>; Wed, 4 Apr 2001 23:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbRDEDEQ>; Wed, 4 Apr 2001 23:04:16 -0400
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:17914 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132549AbRDEDEC>; Wed, 4 Apr 2001 23:04:02 -0400
Date: Wed, 4 Apr 2001 20:04:04 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <Pine.LNX.4.31.0104041956240.1580-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> As long as you are copying in real memory. So the PCI bus or the host
bridge
>>> implementation may be the actual limit.
>>
>> The CyrixIII sits on the same host bridges as the intel processors
>
>I don't know if it applies to this case but one thing I have seen make
>a noticeable difference is whether or not write-combining is enabled.
>If we have only be enabling MTRR's for intel this could do account
>for it.

I think what Geert was trying to point out is does MTRR perform was well
with normal memory over bus to video memory transfers as compared to
normal memory to normal memory transfers. MTTRs might not be optimzed for
these kinds of transfers. I honestly can't say since I haven't tried it. I
brought the MMX book home from works so I'm going to be experimenting
with it this weekend to find out. I really like to compare the MMX
performance to the word aligned transfers over the bus I have going. I had
a bug in my soft accel code that prevented word alignment. Once I fixed
that bug I seen a 10 fold improvement in rendering on the framebuffer.
I'm not kidding about that improvement either :-)

MTTRs enabled always makes a difference. I liek to try it with and
without. I will do some benchmarkings.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

