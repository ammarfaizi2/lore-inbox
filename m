Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSLQT3w>; Tue, 17 Dec 2002 14:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSLQT3w>; Tue, 17 Dec 2002 14:29:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30988 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266638AbSLQT3I>; Tue, 17 Dec 2002 14:29:08 -0500
Date: Tue, 17 Dec 2002 14:34:38 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Karina <kgs@acabtu.com.mx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trouble with kernel 2.4.18-18.7.x
In-Reply-To: <1039553498.14302.58.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021217142857.20007C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 2002, Alan Cox wrote:

> So it looks like its ok. Do file the kmod: failed to exec report in
> https://bugzilla.redhat.com/bugzilla however. Regardless of it not being
> a problem in your case it does want fixing

It appears that recent RH build initrd files w/o all of the stuff in
modules.conf. Perhaps only the first SCSI adaptor, perhaps just ignoring
the ones which don't match the build hardware. I suspect the latter, since
even using --with= in a manual mkinitrd failed (silently) to include the
modules. I can't tell you how much that sucks if you build kernels for
multiple machines on a compile server.

Also, I installed 2.4.18-18.8.0 and it put a bunch of overlong label=
statements in lilo.conf, then ran lilo and didn't check the status. Since
it had deleted the old kernel that left a totally unbootable system. Guess
RH really likes grub and only tests upgrades and such with that.

I will report this later tonight when I'm willing to take the time to
prepare a proper bug report.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

