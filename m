Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317203AbSFBPlF>; Sun, 2 Jun 2002 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317204AbSFBPlE>; Sun, 2 Jun 2002 11:41:04 -0400
Received: from lawcv2.lcisp.com ([12.44.138.11]:14344 "EHLO lcisp.com")
	by vger.kernel.org with ESMTP id <S317203AbSFBPlD>;
	Sun, 2 Jun 2002 11:41:03 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Need help tracing regular write activity in 5 s interval
Date: Sun, 2 Jun 2002 10:41:03 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALOEAOIKAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0206020922410.29405-100000@hawkeye.luckynet.adm>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Couldn't you disable syslog and klog for this test?  Just output to the
console.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Thunder from the
hill
Sent: Sunday, June 02, 2002 10:26 AM
To: Matthias Andree
Cc: Linux Kernel Mailing List
Subject: Re: Need help tracing regular write activity in 5 s interval


Hi,

> So: is there any trace software that can tell me "at 15:52:43.012345,
> process 4321 marked 7 blocks dirty on device /dev/hda5" (or even more
> detail so I can figure if it's just an atime update -- as with svscan --
> or a write access)? And that is NOT to be attached to a specific process
> (hint: strace is not an option).

Problem: we'd have to do that using printk. printk issues another write
call, which will mark things dirty. Issued is another printk, which marks
things dirty and issues another printk...

I suppose one write would become looped here?

Regards,
Thunder
--
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



