Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTBDEZB>; Mon, 3 Feb 2003 23:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbTBDEZB>; Mon, 3 Feb 2003 23:25:01 -0500
Received: from [202.149.212.34] ([202.149.212.34]:6959 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id <S267123AbTBDEZA>;
	Mon, 3 Feb 2003 23:25:00 -0500
Date: Tue, 4 Feb 2003 10:04:23 +0530 (IST)
From: Nohez <nohez@cmie.com>
X-X-Sender: <nohez@venus.cmie.ernet.in>
To: <Valdis.Kletnieks@vt.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: timer interrupts on HP machines 
In-Reply-To: <200302031503.h13F3Ka0023572@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.33.0302040944570.29461-100000@venus.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Feb 2003 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 03 Feb 2003 18:52:14 +0530, Nohez said:
>
> > server: # date
> > Mon Feb  3 17:38:30 IST 2003
> > server: # date
> > Mon Feb  3 17:38:20 IST 2003
>
> > We have xntpd daemon running on all our servers.
>
> Any xntpd messages in the syslog that correlate with these events? I've
> seen similar behavior on my laptop (although the clock ran very slow and
> was getting slammed 10-15 seconds forward by xntpd - was a missing interrupt
> problem).   I've seen oddness with corrupted /etc/ntp/drift files as well...

I have attached ntp log entries for the relevant time period.
Server was rebooted at approx 10:15 and the server time stopped
at 4:57. Before xntpd we used to sync time using "netdate" once
every hour. Problem occured even while using netdate.

/var/log/ntp:
-------------

7 Jan 00:46:11 xntpd[477]: offset -0.000146 sec freq 22.645 ppm error 0.000059 poll 9
7 Jan 01:46:47 xntpd[477]: offset -0.000174 sec freq 22.636 ppm error 0.000059 poll 10
7 Jan 02:47:23 xntpd[477]: offset 0.001350 sec freq 22.634 ppm error 0.000566 poll 10
7 Jan 03:47:59 xntpd[477]: offset -0.000288 sec freq 22.631 ppm error 0.000368 poll 10
7 Jan 04:48:35 xntpd[477]: offset -0.000312 sec freq 22.627 ppm error 0.000208 poll 10
7 Jan 10:18:52 xntpd[476]: system event 'event_restart' (0x01) status \
                           'sync_alarm, sync_unspec, 1 event, event_unspec'
7 Jan 10:19:08 xntpd[476]: peer LOCAL(0) event 'event_reach' (0x84) \
                           status 'unreach, conf, 1 event, event_reach' \
			   (0x801
7 Jan 10:19:09 xntpd[476]: peer xxx.x.x.xx event 'event_reach' (0x84) \
                           status 'unreach, conf, 1 event, event_reach' (0x8
7 Jan 10:22:21 xntpd[476]: system event 'event_peer/strat_chg' (0x04) \
                           status 'sync_alarm, sync_ntp, 2 events, event_res
7 Jan 10:22:21 xntpd[476]: system event 'event_sync_chg' (0x03) \
                           status 'leap_none, sync_ntp, 3 events, \
			   event_peer/strat
7 Jan 10:22:21 xntpd[476]: system event 'event_peer/strat_chg' (0x04) \
                           status 'leap_none, sync_ntp, 4 events, event_sync
7 Jan 11:19:28 xntpd[476]: offset 0.000093 sec freq 22.940 ppm error 0.000051 poll 7
7 Jan 12:20:04 xntpd[476]: offset 0.000134 sec freq 23.146 ppm error 0.000123 poll 6
7 Jan 13:20:40 xntpd[476]: offset -0.000233 sec freq 23.147 ppm error 0.000111 poll 10


