Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVLGHdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVLGHdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 02:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVLGHdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 02:33:17 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:5530 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S964793AbVLGHdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 02:33:16 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: george@mvista.com
Date: Wed, 07 Dec 2005 08:33:07 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Thomas Gleixner <tglx@linutronix.de>
Message-ID: <43969E43.20093.2E7516A4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <4395F3FC.6030301@mvista.com>
References: <4394018D.19764.2440ED5D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=113022@20051207.072010Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2005 at 12:26, George Anzinger wrote:

[...]
> > I think this is not a question at all whether people like leap seconds or not: 
> > Either they want to have the current official time, or they do not. If they do 
> > not, they won't care about NTP; if they do they'd use it.
> > 
> > If they don't like leap seconds, they'd go into politics to forbid them by law.
> 
> I don't think that is what happens now.  Rather the leapsecond is not 

Be aware of the following: If a recent NTP daemon detects an old NTP kernel 
interface (like that of unpatched Linux), it will not use the NTP kernel interface 
at all ("disable kernel"). Thus no leap second processing will happen (AFAIK).

> requested by ntp and either a) ntp sets the clock at the required time 
> or b) it "creeps" it ahead or back by one second over a somewhat 
> longer time.  It is behavior b) that I have found some folks want.  In 
> no case do I see anyone wanting to drop the leapsecond, they just 
> don't want the discontinuity it introduces and are willing to be a 
> second (or if done properly, half a second) away from the correct time 
> for a period of time around the official leapsecond.

Fight the real problem then: Update the kernel NTP interface to the current one 
(which is several years old by now). It's named "nanokernel" by Dave Mills, and it 
was exactly the reason why I had patched Linux 2.4 to provide a nanosecond clock 
resolution (in theory), and I also thought that's the reason for having 
nanoseconds with your patch set ;-)

Regards,
Ulrich

