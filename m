Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSGALZI>; Mon, 1 Jul 2002 07:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSGALZH>; Mon, 1 Jul 2002 07:25:07 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:46057 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315456AbSGALZG>; Mon, 1 Jul 2002 07:25:06 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Ralph Corderoy <ralph@inputplus.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Date: Mon, 1 Jul 2002 21:24:20 +1000
User-Agent: KMail/1.4.5
References: <200207011102.g61B22305958@blake.inputplus.co.uk>
In-Reply-To: <200207011102.g61B22305958@blake.inputplus.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207012124.20330.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002 21:02, Ralph Corderoy wrote:
> Hi,
>
> Does anyone here have a USB Happy Hacking Keyboard Lite Mk 2 keyboard?
>
> On connecting to my 2.4.18 Linux system I find that it works great,
> except that certain triples of keys produce four characters instead of
> three when typed in rapid succession.  This happens under XFree86 and
> also at a tty.  For example, typing `swa' rapidly produces `swaw'.
What is the event interface (dev/input/eventX) showing for this type of input?

> Further investigation revealed that only certain combination of keys
> exhibit the problem.  More examples are
>
>     keys produces
>     rty    rtty
>     yui    yuui
>     tyu    tyuy
>     swa    swaw
>     jhg    jhgh
>
> But other won't show the problem, e.g. `zxc', `asd', and `qwe'.
>
> My theory is that usbkbd.o doesn't cope with ErrorRollover which is
> being generated, unlike hid.o which didn't used to but does now.
Err, how do you reconcile that with only seeing it on some keys?

BTW: usbkbd isn't meant for real work. You should use full HID.

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
