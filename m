Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTIDRcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265341AbTIDRcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:32:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:38593 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265338AbTIDRcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:32:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 4 Sep 2003 10:24:13 -0700 (PDT)
Subject: Re: serial console on x86
In-Reply-To: <Pine.LNX.4.53.0309041301060.6201@chaos>
Message-ID: <Pine.LNX.4.44.0309041023010.18624-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Richard B. Johnson wrote:

> On Thu, 4 Sep 2003, David Lang wrote:
>
> > I am attempting to install linux (debian 3 based) on some dual athlon
> > boxes with no video card. The BIOS does include serial console
> > capabilities
> >
> > once the system is installed I have no problem booting from the hard
> > drive, but when I attempt to boot from a CD to install (ISOLINUX custom
> > boot disk) I see the lilo prompt, the loading kernel message, the loading
> > initrd.gz message and then it prints 'Ready.' and reboots the same
> > bootdisk will work just fine if I install a video card in the machine (and
> > the same kernel with lilo boots just fine without a video card after it
> > gets installed)
> >
> > any ideas why the kernel may crash before printing any messages in this
> > situation? I've tried this with 2.4.17 and 2.4.22 with the exact same
> > results.
> >
> > David Lang
>
> 	append="console=ttyS0,9600"
> ... in the lilo configuration works fine in the exact same kernels
> you cite. However, the CD install does not have the console changed
> so it will probably not work. The BIOS is never used past the point
> where the OS is physically loaded so it makes no difference
> if you have "serial console capabilities" in the BIOS.

I have a similar line in the lilo configuration. if there is a video card
in the system this works and I see the kernel boot over the serial port,
if there is not a video card it reboots instead of running the kernel.

David Lang

> You can readily make an 'init' that opens a serial port if the
> console failed to open. That's done all the while in embedded
> systems. You just can't get that off a "distribution disk".
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
>             Note 96.31% of all statistics are fiction.
>
>
