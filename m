Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSDZFmj>; Fri, 26 Apr 2002 01:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313666AbSDZFmi>; Fri, 26 Apr 2002 01:42:38 -0400
Received: from codepoet.org ([166.70.14.212]:59574 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S313661AbSDZFmi>;
	Fri, 26 Apr 2002 01:42:38 -0400
Date: Thu, 25 Apr 2002 23:42:41 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Bill Davidsen <davidsen@tmr.com>, Stephen Samuel <samuel@bcgreen.com>,
        linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020426054241.GA21799@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Stephen Samuel <samuel@bcgreen.com>, linux-kernel@vger.kernel.org,
	Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <3CC738AD.50905@bcgreen.com> <Pine.LNX.3.96.1020424232237.4586B-100000@gatekeeper.tmr.com> <20020426040457.GO574@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 25, 2002 at 09:04:57PM -0700, Mike Fedyk wrote:
> 1)
> Two drives each on a seperate cable, but on the same chipset:
> /dev/hda (hard drive) (chipset1)
> /dev/hdc (cd-rom) (chipset1)
> 
> Put broken CD into /dev/hdc, and read somehow (dd, cat, whatever), now try
> to read from /dev/hda.  This (according to this thread) should be damn slow
> and you will have a very hard time to use this system while it is trying to
> read the CD.

This has not been my experience.  Reading from hda continues to
work as expected.  But the process reading from hdc stays stuck
in D state for a _long_ time....  A kill -9 takes like 10 minutes
before it gets around to actually killing anything.

> 2)
> Two drives, each on a seperate cable and on different chipsets:
> /dev/hda (hard drive) (chipset1)
> /dev/hde (cd-rom) (chipset2)
> 
> Put broken CD into /dev/hde, read it again, and try to read from /dev/hda.
> All should be good, with blue skies, and a responsive system.

Sure.  Same as above.

> Also, can someone say for sure (Andre) that this is a hardware limitation,
> not a Linux IDE locking problem, and with no possibility of a software
> work-around? 

There is a certain amount of delay when a drive hits a bad
sector.  But Linux handles things pretty badly IMHO, and could 
do a much better job.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
