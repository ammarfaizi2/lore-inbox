Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263010AbTCSNft>; Wed, 19 Mar 2003 08:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263011AbTCSNft>; Wed, 19 Mar 2003 08:35:49 -0500
Received: from fmr02.intel.com ([192.55.52.25]:8413 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263010AbTCSNfr>; Wed, 19 Mar 2003 08:35:47 -0500
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D6E0@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Helge Hafting'" <helgehaf@aitel.hist.no>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [Bug 471] New: Root on software raid don't boot on new 2.5 ke
	rnel since after 2.5.45
Date: Wed, 19 Mar 2003 05:50:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

You didn't list your kernel configuration.
Make sure you have CONFIG_BLK_DEV_MD=y (not =m) for root mirroring.
This is easy to forget, since the default is =m.

The others should be able to be modules, however you know that 
the module interface is radically changed in 2.5.45 and beyond,
so trying it with the other scsi & raid modules compiled in would 
be a good test.

Andy

-----Original Message-----
From: Helge Hafting [mailto:helgehaf@aitel.hist.no] 
Sent: Wednesday, March 19, 2003 5:15 AM
To: Martin J. Bligh
Cc: linux-kernel
Subject: Re: [Bug 471] New: Root on software raid don't boot on new 2.5
kernel since after 2.5.45


Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=471
> 
>            Summary: Root on software raid don't boot on new 2.5 kernel
since
>                     after 2.5.45

Root on raid-1 works fine for me, with and without devfs.  My kernel has
no module support, everything is compiled in.  I don't use initrd.
I have used root-raid with every 2.5 kernel except for a few that had
raid bugs. (Affecting all raid, the root weren't special.)

Until recently the root raid always did an unclean shutdown, but this didn't
cause other trouble than a bootup resync.


