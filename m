Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312731AbSDFSv5>; Sat, 6 Apr 2002 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312734AbSDFSv4>; Sat, 6 Apr 2002 13:51:56 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:55869 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S312731AbSDFSvz>; Sat, 6 Apr 2002 13:51:55 -0500
Message-ID: <3CAF4613.8EF65E0C@mindspring.com>
Date: Sat, 06 Apr 2002 11:01:39 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <E16tuNx-0002LL-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all,
    several people had suggested this.

    as it turns out one thing that was slowing my boot down was actually the
framebuffer.  When the kernel boots and it switches to mode 0x317 (maybe other
modes or all did not try) it would actually take a second or two to switch to
the new mode.  This is on a fast machine so I imagine that on a slower machine
it may take longer.

    also it seems that ide2 probe would take long as well.  maybe less than 1/2
second but it would be noticable so adding ide2=noprobe helped as well.  this
may be that there is no ide2 and it has to time out.  I guess the time out is
very small.

    also the cdrom probe takes a little time as well...

    removeing all these unnecessary drivers has speed it up some more as well.
it seems it now boots in about 1/2 the time.

Joe

> > So what is the best way in Linux to figure out what you can remove from the
> > kernel to make it smaller and boot hopefully faster on low end machines?
>
> Say "M" to everything that isnt your root file system or directly dependant
> on it. The whole "build a custom kernel" thing is mostly a red herring.

