Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272422AbRIKMMS>; Tue, 11 Sep 2001 08:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272424AbRIKMMH>; Tue, 11 Sep 2001 08:12:07 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:5136 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272422AbRIKMLt>; Tue, 11 Sep 2001 08:11:49 -0400
Message-ID: <3B9DFF44.3D89368C@t-online.de>
Date: Tue, 11 Sep 2001 14:10:44 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109102306.f8AN6iY21834@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" schrieb:
> 
> >What about a kind of timer ?
> 
> The functions are run serially.  If I'm to wait, I must block
> or risk having the machine powered off prior to completing my shutdown.
> 
> A coworker of mine playing with the MD code reminded me that
> he had to change the priority of the MD notifier to make it work.
> I believe that this is the correct fix as there are other SCSI
> drivers that have shutdown hooks.
> 
> All HBA drivers currently use 0 (or the lowest) as their priority.
> MD (line 3475 of drivers/md/md.c) uses 0 too.  Change it to INT_MAX
> and MD will always get shutdown prior to any child devices it might
> use.

One question is still open on this case:
Why does the Oops only occur if the "aic7xxx=verbose" is set ?

The above explanation is correct (AFAIK), but the kernel-oops should
then happen on *every* reboot, not only if this verbose-parameter is
set...or does the driver try to shutdown the drives and then write to
the log "AIC7xxx shutdown successfull"...?...:-))

Solong...
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
