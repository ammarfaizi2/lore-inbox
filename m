Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281805AbRLWMgJ>; Sun, 23 Dec 2001 07:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286885AbRLWMgD>; Sun, 23 Dec 2001 07:36:03 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:24582 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S281805AbRLWMfv>;
	Sun, 23 Dec 2001 07:35:51 -0500
Date: Sun, 23 Dec 2001 12:29:53 +0100
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg ?
Message-ID: <20011223112953.GA7856@obelix.gallien.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011222083457.GA666@asterix> <20011222.155713.84363957.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011222.155713.84363957.davem@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

On Sat, 22 Dec 2001, David S. Miller wrote:

> 
> What compiler are you using to build these kernels?  To be honest
> the assertion you have triggered ought to be impossible and this is
> the first report I've ever seen of it triggering.


Ok, i switched to kernel 2.4.17 and it happened again tonight.

Here's the output of ver_linux:


asterix:/usr/src/linux/scripts# ./ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
 Linux asterix 2.4.17-a1 #1 Sam Dez 22 13:39:51 CET 2001 i686 unknown
  
  Gnu C                  2.95.4
  Gnu make               3.79.1
  util-linux             2.11n
  mount                  2.11n
  modutils               2.4.11
  e2fsprogs              1.25
  PPP                    2.4.1
  Linux C Library        2.2.4
  Dynamic linker (ldd)   2.2.4
  Procps                 2.0.7
  Net-tools              1.60
  Console-tools          0.2.3
  Sh-utils               2.0.11
  Modules Loaded         nfs lockd sunrpc parport_pc lp parport
  matroxfb_maven matroxfb_crtc2 cs46xx ac97_codec soundcore i2c-matroxfb
  i2c-algo-bit i2c-core apm ide-scsi rtc

asterix:/usr/src/linux/scripts# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011006 (Debian prerelease)


Note that the kernel was compiled on asterix (another machine).

I also installed memtest86 and ran it a few days ago.

I still need to read up on its doc. but here is one error that came up
after HOURS of memtest86 running.

	Address:	190fe988; 400.90MiB
	Good:		00100000
	Bad:		00000000
	Error-Bits:	00100000

Does it mean there's a one-bit error in the first (400.90<512) 512MB Module? 
(This machine has 1GB memory in 2x512MB modules)
If so, I will remove this module and try again with only 512 MiB
memory.


    Bye, Stefan

