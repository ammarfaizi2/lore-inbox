Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269519AbTCDTFf>; Tue, 4 Mar 2003 14:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269522AbTCDTFe>; Tue, 4 Mar 2003 14:05:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:54941 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S269519AbTCDTFd>;
	Tue, 4 Mar 2003 14:05:33 -0500
Date: Tue, 4 Mar 2003 11:16:26 -0800
From: Andrew Morton <akpm@digeo.com>
To: ebrunet@lps.ens.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 bug when mounting dirty loopback ext3 filesystems
Message-Id: <20030304111626.52a64e3c.akpm@digeo.com>
In-Reply-To: <20030304144138.GA28345@lps.ens.fr>
References: <20030304144138.GA28345@lps.ens.fr>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 19:15:54.0991 (UTC) FILETIME=[7A9387F0:01C2E282]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Oops in 2.6.63 when trying to mount dirty ext3 loopback filesystems.
> 
> The kernel is 2.6.63 with the latest (2003/02/28)acpi patches, plus a
> couple of one-liners found on the mailing-lists to help swsusp working
> (one in kernel/suspend.c, one in mm/pdflush.c, and one in
> drivers/net/8139tto.c; nothing related to filesystems)
> 
> The computer is a Pentium IV on an intel chipset.
> 
> I have in /data (an ext3 partition) three files containing ext3
> partitions which are mounted using loopback. For some reason, at
> shutdown time, /data is unmounted (or remounted ro) before the loopback
> partitions, and unmounting the loopback partitions fail, and those
> partitions need to get recovered on next reboot. That is not the issue,
> I will fix it when I get some time.
> 
> The issue is that I got three identical pair of oops in a raw when trying my
> new 2.6.63 kernel. From the logs:
> 

It is not an oops really - it is just a warning.  2.5 has a number of new
consistency checks so sometimes these are long-standing things, sometimes
they are not.

I couldn't get this to happen.  Can you please come up with an exact sequence
of steps to reproduce this?  Also I'd need to know what filesytem the backing
files reside on, and what size those files are, thanks.
