Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRCBX5Z>; Fri, 2 Mar 2001 18:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130167AbRCBX5Q>; Fri, 2 Mar 2001 18:57:16 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:5556 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130162AbRCBX5G>; Fri, 2 Mar 2001 18:57:06 -0500
Message-ID: <3AA03354.A07F5179@uow.edu.au>
Date: Sat, 03 Mar 2001 10:57:08 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Collectively Unconscious <swarm@warpcore.provalue.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: I/O problem with sustained writes
In-Reply-To: <3AA00D5A.44FA21D0@mandrakesoft.com> <Pine.LNX.4.10.10103021455500.29369-100000@warpcore.provalue.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Collectively Unconscious wrote:
> 
> We are having a problem with writes.
> They start at 14 M/s for the first hour and then drop to 2.5 M/s and stay
> that way. Reads do not seem effected and we've noticed this on the 2.2.16,
> 2.2.17, 2.2.18 and now the 2.2.19pre11 kernels.
> 
> These are SMP P-IIIs from 450 to 800 MHz. Redhat 6.2

I've seen something similar on Seagate ST313021A IDE drives.
After a few minutes their read throughput falls from 20
megs/sec to about 5.  Issuing *any* drive-setting command
brings the throughput back.  Even a command which the disk
doesn't support.

So I have a cron job which runs `hdparm -A1' once per minute.

-
