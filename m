Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRATVdK>; Sat, 20 Jan 2001 16:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRATVdA>; Sat, 20 Jan 2001 16:33:00 -0500
Received: from mail08.voicenet.com ([207.103.0.34]:11435 "HELO mail08")
	by vger.kernel.org with SMTP id <S130673AbRATVck>;
	Sat, 20 Jan 2001 16:32:40 -0500
Message-ID: <3A6A03F4.DB6C0362@voicenet.com>
Date: Sat, 20 Jan 2001 16:32:36 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Horton <pdh@colonel-panic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via apollo KX133 ide bug in 2.4.x
In-Reply-To: <3A68DCD1.FACB4135@voicenet.com> <20000120083812.A945@colonel-panic.com> <20010120205608.C2838@colonel-panic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Horton wrote:

> On Thu, Jan 20, 2000 at 08:38:12AM +0000, Peter Horton wrote:
> >
> > I think I'm suffering the same thing on my new Asus A7V. Yesterday I got a
> > single "error in bitmap, remounting read only" type error, and today I got
> > some files in /tmp that returned I/O error when stat()ed. I do have DMA
> > enabled, but only UDMA33. I've done several kernel compiles with no
> > problems at all so looks like something is on the edge. Think I might go
> > back to 2.2.x for a bit and see what happens, or maybe just remove the VIA
> > driver :-((.
> >
>
> I apologise for following up my own E-mail, but there is something I'm
> missing here (maybe a whole lot of something). Anyone know how come we're
> seeing silent corruption ... I thought this UDMA stuff was all checksummed
> ? If there error is outside the data I assume the driver would notice ?
>
> P.

The thing is, even with UDMA disabled in the kernel, I still see the corruption
with 2.4.x (release) and above.  Anything written while using the kernel is
corrupted.   Much of the stuff will read fine (files) ... but I believe
directories get the IO error immediately and some files do also.  Everything is
seen as corrupted when you fsck a partition where this kernel has been run and
created files on.   This is a silent corruption without any errors reported and
I've only tested it on ext2.  You cannot create FS's with these kernels (at
least on the VIA chipsets) since they too are corrupted (note, only tested ext2
fs).   I did disable UDMA everywhere and still saw it happen, this problem is
not present in older 2.4.0-test kernels so it's something in the late
pre-release stage and into the release stage.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
