Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTDFTVD (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTDFTVD (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:21:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20367
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263057AbTDFTVC (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 15:21:02 -0400
Subject: Re: Debugging hard lockups (hardware?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Urbanik <nicku@vtc.edu.hk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E8FC9FB.A030ACFB@vtc.edu.hk>
References: <3E8FC9FB.A030ACFB@vtc.edu.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 19:34:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 07:32, Nick Urbanik wrote:
> This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll Lock do
> not respond.  The NMI watchdog does not kick in.

For the NMI watchdog to fail (if you have it enabled) requires pretty
major disaster to have occurred since the NMI will be delivered through
any kind of system hang

> I guess hardware.  But memtest run exhaustively shows no problem.

Memory errors normally generate "Oops" type lines rather than other
stuff

> I have six 80 G IDE disks, software RAID, LVM on top.  On Red Hat 8.0 and 9.
> 
> Any hints on how to troubleshoot this (besides replacing motherboard and other
> components I cannot afford to replace?)

Is your PSU up to scratch for six disks ?

> /dev/md3:
>  Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
>  Timing buffered disk reads:  64 MB in 21.93 seconds =  2.92 MB/sec
> (last horribly. slow; get zillions of lines in syslog saying stuff like:
> Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 4096
> Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 1024
> Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 1024 -->

Im not sure what this one indicates actually

> Any pointers to web sites, information that may help, any hints, suggestions,
> ideas,... all most welcome.  Actually, if replacing the motherboard would fix
> it, I'd do it, but I cannot guess why it should help; Asus motherboards have
> always been good to me before.

Your choice of components looks fine, its all stuff I trust, even if the
ethernet card is not good for performance it ought to be fine in
general. If it is a faulty part most likely its a one off fault.

Which bits of the system are not being used (sound, video, network ?)

