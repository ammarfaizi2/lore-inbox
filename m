Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRKMUkZ>; Tue, 13 Nov 2001 15:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278839AbRKMUkQ>; Tue, 13 Nov 2001 15:40:16 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:58060 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S278818AbRKMUkB>; Tue, 13 Nov 2001 15:40:01 -0500
Date: Tue, 13 Nov 2001 21:37:32 +0100 (CET)
From: kees <kees@schoen.nl>
To: J Sloan <jjs@toyota.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: report: tun device
In-Reply-To: <3BF17C99.A11BDAA0@lexus.com>
Message-ID: <Pine.LNX.4.33.0111132131330.29497-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I referred to KERNEL 2.4.14 with patch-2.4.15pre3

I did recompile vtund AFTER my new kernel installment and startup and it
didn't help.
I traced vtund and it opens /dev/net/tun
the ioctl call after it returns the error

----------------------------------------- from the trace

writev(2, [{"vtund[27645]: Session demo_s[127"..., 51}, {"\n", 1}], 2) = 52
rt_sigaction(SIGPIPE, {0x40137270, [], 0x4000000}, {SIG_IGN}, 8) = 0
send(4, "<30>Nov 13 19:37:48 vtund[27645]"..., 71, 0) = 71
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
open("/dev/net/tun", O_RDWR)            = 7
ioctl(7, 0x54ca, 0xbffff18c)            = -1 EBADFD (File descriptor in
bad statclose(7)                                = 0
time([1005676668])                      = 1005676668
getpid()                                = 27645
writev(2, [{"vtund[27645]: Can\'t allocate tun"..., 73}, {"\n", 1}], 2) = 74
rt_sigaction(SIGPIPE, {0x40137270, [], 0x4000000}, {SIG_IGN}, 8) = 0

----------------------------------------

I'm willing and able to do more tests

regards
Kees


On Tue, 13 Nov 2001, J Sloan wrote:

> kees wrote:
>
> > Hi
> >
> > No I downloaded 2.4.14 and applied patch-2.4.15.pre3
>
> OK, let me rephrase the question:
>
> What kernel version were you running when
> vtun last worked?
>
> Also, what version of vtun have you?
>
> cu
>
> jjs
>
> >
> >
> > Kees
> >
> > On Tue, 13 Nov 2001, J Sloan wrote:
> >
> > > kees wrote:
> > >
> > > > Hi
> > > >
> > > > I have build 2.4.15pre3 but stil can't use /dev/net/tun (vtund).
> > > >
> > > >
> > > > Nov 13 08:38:29 schoen3 vtund[16676]: Can't allocate tun device. File
> > >
> > > Did you upgrade from a pre-2.4.6 kernel?
> > >
> > > mirai.cx: /home/jjs
> > > (tty/dev/pts/2): bash: 1003 > uname -a
> > > Linux mirai.cx 2.4.15-pre4 #2 Mon Nov 12 22:55:11 PST 2001 i686 GenuineIntel
> > > mirai.cx: /home/jjs
> > > (tty/dev/pts/2): bash: 1002 > ifconfig tun0
> > > tun0      Link encap:Point-to-Point Protocol
> > >           inet addr:192.168.111.254  P-t-P:192.168.111.253
> > > Mask:255.255.255.255
> > >           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1450  Metric:1
> > >           RX packets:17 errors:0 dropped:0 overruns:0 frame:0
> > >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> > >           collisions:0 txqueuelen:10
> > >
> > >
>

