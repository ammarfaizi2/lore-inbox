Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTAIORJ>; Thu, 9 Jan 2003 09:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTAIORJ>; Thu, 9 Jan 2003 09:17:09 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:7083 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id <S266702AbTAIORI>;
	Thu, 9 Jan 2003 09:17:08 -0500
Date: Thu, 9 Jan 2003 16:25:50 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Megaraid crash (Blocked mailbox......!!) with 2.4.19-aa and 2.4.20-aa
Message-ID: <20030109142550.GK19326@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I've seen this at least 5 times now in one month.. One of our boxes die
when postgresql maintenance script AND backup cron jobs are ran at the same
time (by mistake - normally they are not ran at the same time)..

So it seems to be related to high disk i/o. The adapter is 
HP NetRAID 1M with latest firmware. There is one RAID5 array with 3 disks
configured to it.

Usually this crash happens 1 to 2 times a week.. always when cron starts to
run the stuff at the night. The console will be flooded with "Blocked
mailbox......!!" text (which surprisingly means that the megaraid firmware
has stopped responding.. according to google)

This box doesn't have high disk i/o at the daytime, only at the night when
cron starts to do things..

When the cron jobs are not ran at the same time, the box is stable.


Other box using the same kind of adapter, but RAID1 array instead, having
high disk i/o all the time doesn't have any problems.. (with the same kernels).


Kernels are compiled with gcc 2.95.4 (Debian 3.0).


Any thoughts?


-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
