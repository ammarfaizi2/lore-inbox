Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUBTA6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267641AbUBTAzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:55:39 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:30154 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S267626AbUBTAvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:51:55 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Thu, 19 Feb 2004 21:51:52 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <20040219235602.GI15848@kroah.com>
Message-ID: <Pine.LNX.4.58.0402192057590.694@pervalidus.dyndns.org>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com>
 <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org> <20040219230749.GA15848@kroah.com>
 <Pine.LNX.4.58.0402192033490.694@pervalidus.dyndns.org> <20040219235602.GI15848@kroah.com>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Greg KH wrote:

> So if you take out the line about starting udevd, does it
> work for you?

No.

> How about changing the #!/bin/bash to #!/bin/sash in the
> first line for the start_udev script?

I didn't have it, but compiled and changed. Yes, it works.

> What distro is this?

Slackware, with a cute rc.S. /bin/bash was also recompiled, shared:

$ ldd /bin/bash
        libreadline.so.4 => /usr/lib/libreadline.so.4 (0x4001c000)
        libhistory.so.4 => /usr/lib/libhistory.so.4 (0x40049000)
        libncurses.so.5 => /lib/libncurses.so.5 (0x40050000)
        libdl.so.2 => /lib/libdl.so.2 (0x4008f000)
        libc.so.6 => /lib/libc.so.6 (0x40092000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

Maybe the problem ? Does yours differ ?

bash from Slackware:

        libtermcap.so.2 => /lib/libtermcap.so.2 (0x4001c000)
        libdl.so.2 => /lib/libdl.so.2 (0x4005c000)
        libc.so.6 => /lib/libc.so.6 (0x4005f000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

OK, I'll later boot with it and see if it works. If it does,
I'll run strace with the other.

> Can you run strace on the start_udev script after boot to see who is
> needing access to /dev/null?

I forgot to run it, but noticed there was a /dev/null, but a
text file (0644). And I didn't create it anywhere.

> Oh, and if you create the /dev/null node as the first thing in the
> start_udev script does that work?

No.

-- 
http://www.pervalidus.net/contact.html
