Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSBDJlU>; Mon, 4 Feb 2002 04:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288821AbSBDJlL>; Mon, 4 Feb 2002 04:41:11 -0500
Received: from [62.245.135.174] ([62.245.135.174]:65217 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S288814AbSBDJlI>;
	Mon, 4 Feb 2002 04:41:08 -0500
Message-ID: <3C5E572D.FF98495A@TeraPort.de>
Date: Mon, 04 Feb 2002 10:41:01 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre4-J0-VM-22-preempt-lock i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: wli@holomorphy.com
Subject: Re: should I trust 'free' or 'top'?
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/04/2002 10:41:01 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/04/2002 10:41:08 AM,
	Serialize complete at 02/04/2002 10:41:08 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: should I trust 'free' or 'top'?
> 
> 
> On Fri, Feb 01, 2002 at 11:24:16AM -0800, Adam McKenna wrote:
> > adam@xpdb:~$ uptime
> > 11:21am up 42 days, 18:53, 3 users, load average: 54.72, 21.21, 17.60
> > adam@xpdb:~$ free
> > total used free shared buffers cached
> > Mem: 5528464 5522744 5720 0 476 5349784
> > -/+ buffers/cache: 172484 5355980
> > Swap: 2939804 1302368 1637436
> > As you can see, there are supposedly 5.3 gigs of memory free (not counting
> > memory used for cache). However, the box is swapping like mad (about 10 megs
> > every 2 seconds according to vmstat) and the load is skyrocketing.
> 
> That 5.3GB is without kernel caches. I see 5.7MB...
> 

 And this is the problem. Caches should make the system behave better
and not get into its ways ...

 It is time that one of the approches gets accepted for the current
"stable" mainline. I do not care much which it is for 2.4.x. Both rmap
and -aa seem to fix most of the problems. Having one of them accepted
should make it easier to fix-up the remaining pathological cases.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
