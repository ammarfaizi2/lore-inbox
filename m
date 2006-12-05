Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757086AbWLEVrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086AbWLEVrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758272AbWLEVrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:47:19 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:58050 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086AbWLEVrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:47:18 -0500
Date: Tue, 5 Dec 2006 22:43:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Marty Leisner <linux@rochester.rr.com>, linux-kernel@vger.kernel.org,
       bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd
In-Reply-To: <4575DD73.9010008@mnsu.edu>
Message-ID: <Pine.LNX.4.61.0612052242120.18570@yvahk01.tjqt.qr>
References: <200612052024.kB5KOY1o023781@laptop13.inf.utfsm.cl>
 <4575D7F4.3060707@mnsu.edu> <Pine.LNX.4.61.0612052139180.18570@yvahk01.tjqt.qr>
 <4575DD73.9010008@mnsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 5 2006 14:58, Jeffrey Hundstad wrote:
>
> ...It also let's you mknod and friends, and let's you set permissions to files
> to more than just ONE user.  The whole point of the commands is to let you make
> distribution files without root access.  Of course you can fake all of this
> with a special archiver command.... I'm just throwing out options.

Ah. Thanks for explaining! Looks like it eats big amounts of memory when there
are a lot of files in the faekroot.


>
> $ fakeroot
> #  mkdir root
> #  mkdir root/dev/
> #  mknod root/dev/null c 1 3
> #  mknod root/dev/sda1 b 8 1
> #  chown root.disk root/dev/sda1
> #  cd root
> #  tar cvf ../root.tar ./
> #  exit
> $ tar tvf root.tar
> drwxr-xr-x root/root         0 2006-12-05 14:54 ./
> drwxr-xr-x root/root         0 2006-12-05 14:54 ./dev/
> crw-r--r-- root/root       1,3 2006-12-05 14:54 ./dev/null
> brw-r--r-- root/disk       8,1 2006-12-05 14:54 ./dev/sda1
>
> -- 
> Jeffrey Hundstad
>
>
>

	-`J'
-- 
