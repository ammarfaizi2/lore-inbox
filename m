Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRBXWcU>; Sat, 24 Feb 2001 17:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129665AbRBXWcK>; Sat, 24 Feb 2001 17:32:10 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:36871 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129667AbRBXWb5>;
	Sat, 24 Feb 2001 17:31:57 -0500
Message-ID: <3A98365A.451C4473@sh0n.net>
Date: Sat, 24 Feb 2001 17:31:55 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Mike Galbraith <mikeg@wen-online.de>, lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <Pine.LNX.4.21.0102241357220.3684-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing so..., Im not sure hot to use ksymoops or where to get that program.
I just usually use the sysq and dump but its ugly ;-)

Shawn.

Marcelo Tosatti wrote:

> On Fri, 23 Feb 2001, Shawn Starr wrote:
>
> > Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> > Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> > Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
> > Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> > Feb 23 21:17:47 coredump kernel: __alloc_pages: 3-order allocation failed.
> > Feb 23 21:17:47 coredump kernel: __alloc_pages: 2-order allocation failed.
> > Feb 23 21:17:47 coredump kernel: __alloc_pages: 1-order allocation failed.
> >
> > didnt, work, still causing this..
>
> Ok, could you please add a line with "BUG();" after the
> printk("__alloc_pages: %d-order allocation failed", ..) in mm/page_alloc.c
> function __alloc_pages() ?
>
> This will make you get an oops when an allocation fails and if you decode
> it (with ksymoops) we can have a pretty useful backtrace to have more clue
> of what's failing.
>
> TIA

