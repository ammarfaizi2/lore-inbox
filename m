Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131415AbRCWUVv>; Fri, 23 Mar 2001 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbRCWUVo>; Fri, 23 Mar 2001 15:21:44 -0500
Received: from chromium11.wia.com ([207.66.214.139]:6158 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S131415AbRCWUV2>; Fri, 23 Mar 2001 15:21:28 -0500
Message-ID: <3ABBB0EF.7A292060@chromium.com>
Date: Fri, 23 Mar 2001 12:24:16 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zach Brown <zab@zabbo.net>
CC: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: kernel support for _user space_ web server accelerator
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com> <15030.54194.780246.320476@pizda.ninka.net> <3AB6D574.8C123AE9@chromium.com> <15030.54685.535763.403057@pizda.ninka.net> <3ABAC8D4.B464EB9B@chromium.com> <20010323141449.B24144@tetsuo.zabbo.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here it comes again,

I don't like the idea of having a web server in the kernel, I don't think it
belongs there.

Yes I'm pretty familiar with TUX, I believe that it is a foundamental piece of
achievement in web server performance study. Neverthanless I think that it is
sitting on the wrong spot.

I'm building an alternative web server that is entirely in _user space_ and
that achieves the same level of performance as TUX. Presently I can match TUX
performance within 10-20%, and I still have quite a few improvements in my
pocket.

Nevertheless I need some minimal help from the kernel, like a FAST (and
secure?) mechanism for socket forwarding and a better (non-blocking on
files) sendfile interface.

For the time being I'm using a socket delivery mechanism similar to that of
TUX and khttpd, as I stated at the beginning of this thread. I don't like the
idea of patching the kernel, I don't believe that it is a viable distribution
mechanism and I'm trying to find a better way of adding the functionality that
I require as a kernel module.

Currently the "right" kernel network interfaces are exposed to the modules only
if khttpd or ipv6 are compiled as modules. Can we change this such that a
standard binary kernel (say, the one coming with a vanilla RedHat distrubution
or similar) would expose the right stuff?

Would it make any sense to have a real system call doing this kind of stuff?

HELP! :)

TIA, ciao,

 - Fabio

Zach Brown wrote:

> > Zach, have you ever noticed such a performance bottleneck in your phhttpd?
>
> yup, this is definitely something you don't want to be doing in the fast
> path :)
>
> > Any thoughts?
>
> Sorry I don't remember the start of this thread, but I'll ask anyway;
> have you looked at Ingo Molnar's Tux server?  Its state of the art unix
> serving, implemented in the linux kernel:
>
> http://people.redhat.com/mingo/TUX-patches/
>
> --
>  zach

