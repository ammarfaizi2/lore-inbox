Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317714AbSGaDiw>; Tue, 30 Jul 2002 23:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317711AbSGaDiw>; Tue, 30 Jul 2002 23:38:52 -0400
Received: from unthought.net ([212.97.129.24]:51170 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S317708AbSGaDiu>;
	Tue, 30 Jul 2002 23:38:50 -0400
Date: Wed, 31 Jul 2002 05:42:15 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: RAID problems
Message-ID: <20020731034215.GM11129@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Bill Davidsen <davidsen@tmr.com>,
	Kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-raid@vger.kernel.org
References: <20020730175505.GI11129@unthought.net> <Pine.LNX.3.96.1020730223102.6974A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.96.1020730223102.6974A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 10:46:55PM -0400, Bill Davidsen wrote:
...
> I think you misread my comment, it was not "why doesn't the documentation
> say this" but rather "why does software RAID have this problem?"

Ok, my bad.

 - btw. I CC'ed linux-raid as this is getting a little OT for
   linux-kernel.  Let's let the thread migrate to linux-raid instead...

> I know
> this can happen in theory, but it seems that the docs imply that this
> isn't a surprise in practice. I've been running systems with SCSI RAID and

I would say it's not a surprise as such, but it's something that really
should be a very very rare occurrance.

I've seen it maybe once on a production system, having run MD on quite a
few computers for the past half decade.  And I've had a few handfulls of
people asking me about it over the years.

...
> I just surprised that the software RAID doesn't have better luck with
> this, I don't see any magic other than maybe a bus reset the firmware
> would be doing, and I'm wondering why this seems to be common with Linux.

I don't have the impression that it is common on stable hardware.  Can
anyone who runs SW RAID on a number (greater than 1) of machines comment
on this ?

However, some people run their RAID-5 arrays on the same SCSI busses as
their Zip drives, their scanners, and five other el-cheapo almost-scsi
devices, and that is just *bound* to cause this kind of mess when one of
the devices decide to lock up the bus.

You don't see this with HW raid because you don't put your $15
almost-scsi magic-foo device on your $2k HW RAID controller.

There might be other simple reasons why some HW cards don't show this
behaviour - they might simply maintain their superblocks differently
from Linux SW RAID.   I have *no* idea how current controllers do this.

> Or am I misreading the frequency with which it happens?

I hope  ;)

At least in the "stable hardware" situation.  Comments, please...

...
> Thye words are clear, I'm surprised at the behaviour. Yes, I know that's
> not your thing.

I *will* be surprised if it turns out that this is really a common
occurrence for people.   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
