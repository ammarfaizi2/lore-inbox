Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUAZPi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUAZPi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:38:26 -0500
Received: from spc1-brig1-3-0-cust85.lond.broadband.ntl.com ([80.0.159.85]:64145
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S263777AbUAZPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:38:18 -0500
Date: Mon, 26 Jan 2004 15:38:17 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Charles Shannon Hendrix <shannon@widomaker.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
In-Reply-To: <4014789F.2000202@tmr.com>
Message-ID: <Pine.LNX.4.58.0401261522370.12103@ppg_penguin>
References: <20040117031925.GA26477@widomaker.com> <4014789F.2000202@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004, Bill Davidsen wrote:

> Charles Shannon Hendrix wrote:
> >
> > Is CD burning supposed to work with kernel 2.6.1 using the ATAPI
> > interface, or are bugs still being worked out?
> >
> > I have run cdrecord under kernel 2.4.2x and it worked great using the
> > ATAPI interface like this:
> >
> > % cdrecord dev=ATAPI:bus,drive,lun
> >

 Did a bit of that recently with 2.4, everything was ok except that
fixation, at least for audio CDs under xcdroast, took a _very_ long
time.  That box is now running 2.6.1 and using -dev=/dev/hdc : I tested
xcdroast on audio the other day - writing was ok, but it insisted on
reading from 0,0,0 and claimed there was nothing in /dev/hdc.  I've just
tested writing a data cd from /dev/hdc and it works fine for me.

 I got the impression that under 2.4 dev=ATAPI was not the best way to
go.  For 2.6 it seems happy to use the regular device name.  Burns at
16x, which is all the drive supports, reads fine on what I've tested.
Suggest you (Charles) try it as -dev=/dev/hdc (or wherever it is).

>
> I believe that you will find that you have to compile for 2.6 on a
> machine with /usr/src/linux pointing to the 2.6 kernel source. This is
> being discussed elsewhere, but is what got things working for me.
>

 Surely not!  The basic system on that box of mine was put together in
October 2002 (although X, the graphical stuff, and cdrecord were only
compiled two or three months back - 2.6.1 is my first try with 2.6 on
it).  I'm a good boy, I don't have /usr/src/linux:


GNU C Library stable release version 2.2.5, by Roland McGrath et al.
Copyright (C) 1992-2001, 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 2.95.3 20010315 (release).
Compiled on a Linux 2.4.19 system on 2002-10-10.
Available extensions:
	GNU libio by Per Bothner
	crypt add-on version 2.1 by Michael Glad and others
	linuxthreads-0.9 by Xavier Leroy
	BIND-8.2.3-T5B
	libthread_db work sponsored by Alpha Processor Inc
	NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
Report bugs using the `glibcbug' script to <bugs@gnu.org>.

ls: /usr/src/linux: No such file or directory


Ken
-- 
This is a job for Riviera Kid!
