Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbTA0So0>; Mon, 27 Jan 2003 13:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267284AbTA0So0>; Mon, 27 Jan 2003 13:44:26 -0500
Received: from pop.gmx.de ([213.165.64.20]:29251 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267282AbTA0SoV>;
	Mon, 27 Jan 2003 13:44:21 -0500
Message-Id: <5.1.1.6.2.20030127191904.00cc2508@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 27 Jan 2003 19:50:24 +0100
To: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>,
       linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.59-mm6
In-Reply-To: <1043670419.1691.30.camel@cc75757-a.groni1.gr.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:27 PM 1/27/2003 +0100, Luuk van der Duim wrote:
>Hello mm-users,
>
>
>   . The mysterious "machine hangs late in boot" problem has been narrowed
>     down thanks to some great work by Andres Salomon.  The machine is stuck
>     waiting on I/O completion when performing the initial lookup for
>     /sbin/devfs_helper:
>
>
>I don't believe it to be an exclusively small-devfs helper problem.

Well, my test box agrees (I have never ever used devfs, but could lock hard 
in minutes)  mm6 works fine here, so I _think_ it's probably resolved...

>It is an interaction at best. Sure I had problems using devfs-small, but
>mm2 worked and mm3 was the first that halted during boot. Both have
>devfs-small, and both need its helper. Or I am missing a subtlety here?

I don't think you're missing anything, but I also don't know wtf the 
interaction is.  I put a couple of man-days into looking for it, and came 
up with exactly nada of interest.

>Secondly, Andrew sent me a rollup of patches against 2.5.59 he thought
>were suspicious, without smalldevfs and it also halted, but at another
>place in boot, at adding swap.

Mine locked hard hard hard.  Booted fine, but died reliably under heavy load.

(something seems funky with nmi_watchdog... hard lock = no_more_nmi_ticks 
.  Anybody out there know enough about local APIC to explain why idle=poll 
gives nice 1 second nmi, but everything else depends upon cpu load?... and 
why when hardlock happens, it _stops_)

>Can someone besides me confirm this behavior or am I the loon who just
>won't understand?

My box agrees that you're not a loon fwTw :)

         -Mike

