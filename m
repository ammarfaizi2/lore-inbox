Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSLTRO6>; Fri, 20 Dec 2002 12:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbSLTRO6>; Fri, 20 Dec 2002 12:14:58 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:41447 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S262871AbSLTRO5>; Fri, 20 Dec 2002 12:14:57 -0500
Date: Fri, 20 Dec 2002 08:42:08 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: USB 2.0 is too slow?
To: linux-kernel@vger.kernel.org
Message-id: <3E034860.70509@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >   Some problems I met as follows.

You didn't mention what kernel or driver version you used.
I'd expect more success with the latest 2.5 code, which
should appear as a patch against 2.4.21pre soon.


 >   (1)Sometimes it can copy completely in 30 seconds.

300 MB, 30 seconds ... 10 MB/sec, faster can be had;
that shouldn't tax the usb2 hardware at all.  But some
PCI systems might not like that additional load.


 >       Is the echi-hcd module instable or immature now?
 >       Or the VIA USB 2.0 host controller is bad support?

Some of both.  It's explicitly so on 2.4 (CONFIG_EXPERIMENTAL)
and has on 2.5 has recently been regaining stability.  Not that
long ago we switched over so usb-storage uses scatterlists to
do queued I/O, stressing the driver and hardware a lot more ...
the expected kinds of bugs did show up, and are being squished.

And you need relatively recent drivers for the VIA support
to behave, in any case.  Or even Intel; there's a timeout
that Intel expects to be relatively long, and current kernels
have it quite short.  We learned that just this week... :)

- Dave



