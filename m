Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313036AbSDCDKl>; Tue, 2 Apr 2002 22:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313041AbSDCDKc>; Tue, 2 Apr 2002 22:10:32 -0500
Received: from london.rubylane.com ([208.184.113.40]:21554 "HELO
	london.rubylane.com") by vger.kernel.org with SMTP
	id <S313033AbSDCDKR>; Tue, 2 Apr 2002 22:10:17 -0500
Message-ID: <20020403031016.5504.qmail@london.rubylane.com>
From: jim@rubylane.com
Subject: Re: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
To: xyzzy@speakeasy.org (Trent Piepho)
Date: Tue, 2 Apr 2002 19:10:15 -0800 (PST)
Cc: jim@rubylane.com, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.4.04.10204021623420.5141-100000@xyzzy.dsl.speakeasy.net> from "Trent Piepho" at Apr 02, 2002 04:48:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 2 Apr 2002 jim@rubylane.com wrote:
> > 2. The MB IDE ports transfer data at about 18000K/sec while doing
> > cat /dev/hda >/dev/null and looking at vmstat.
> 
> I think the serverworks IDE is only mode4, not even UDMA33.  I heard a lot of
> bad things about it, and removed all the IDE drives from our serverworks
> system's controller.
> 
> > hdk.  In a 32-bit slot, cat /dev/hdx >/dev/null shows 31300K/sec.  But
> > doing cat /dev/hde4 (a specific partition) for example gives
> > 8400K/sec.  That makes no sense to me.
> 
> The outer cylinders of a drive are faster than the inner cylinders.  Try
> repartitioning the drive so that hde4 starts at cylinder 1, and see if that
> changes the speed.

That's not it because all 4 drives are partitioned the same, yet hde4
gives 8400K/sec and hdk4 gives 31000K.  Also there are the same number
of interrupts/sec and context switches per sec according to vmstat in
the 8400 and 31000 case.

> Maybe the promise cards and
> the serverworks IDE controller are just crappy hardware, and are never going
> to work correctly?

I certainly can relate to that!

Thanks for the feedback,
Jim

