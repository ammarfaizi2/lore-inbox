Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTBAOrt>; Sat, 1 Feb 2003 09:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTBAOrs>; Sat, 1 Feb 2003 09:47:48 -0500
Received: from n1114ber.planetcomm.net ([64.4.122.114]:45497 "EHLO
	paul.wright.house") by vger.kernel.org with ESMTP
	id <S264697AbTBAOrs>; Sat, 1 Feb 2003 09:47:48 -0500
Subject: Re: [PATCH] USB HardDisk Booting 2.4.20
From: Wesley Wright <wewright@verizonmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Samuel Flory <sflory@rackable.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030131022151.GA25068@alpha.home.local>
References: <1043947657.7725.32.camel@steven>
	<1043952432.31674.22.camel@irongate.swansea.linux.org.uk>
	<3E39A895.9000602@rackable.com>  <20030131022151.GA25068@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Feb 2003 10:00:51 -0500
Message-Id: <1044111651.1965.7.camel@steven>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm personnaly using this simple patch with success with an usb disk on
> key. It adds an option "setuptime" which waits the requested amount of ms
> before booting. I use it with "setuptime=2500" and my USB works fine.
> 
> I think it could be of a more general use, and perhaps it could be
> accepted into mainstream if it doesn't break anything ?

The reason I took the other approach is that I didn't want to introduce
an arbitrary delay into my startup.  I have varying speed machines
(ranging from P90 up to Athlon 1800) and wanted a solution consistent
across all of them.  I think that you can accomplish the delay startup
through initrd without a kernel change.

Delay solutions don't directly deal with the race between mounting and
detecting the USB device though.  If I select a value to small then I
still don't get a successful mount.

Maybe this isn't a major concern for this area of the kernel though... 
at this point there really aren't any other tasks so the delay should
have very consistent results.

Thanks,
-- Wes

