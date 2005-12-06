Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVLFHKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVLFHKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 02:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVLFHKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 02:10:39 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:14505 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751432AbVLFHKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 02:10:39 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Tue, 06 Dec 2005 08:10:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Message-ID: <4395475C.21877.29399CFE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0512051132460.1609@scrub.home>
References: <4390E48E.4020005@mvista.com>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=112970@20051206.070542Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Dec 2005 at 11:35, Roman Zippel wrote:

> Hi,
> 
> On Fri, 2 Dec 2005, George Anzinger wrote:
> 
> > In a discusson aroung the leapsecond and how to disable it (some folks don't
> > want the time jump) it came to light that, for the most part, this is unused
> > code.  It requires that time be kept in UST to be useful and, from what I can
> > tell, most folks keep time in their local timezone, thus, effectively,
> > disableing the usage of the leapsecond correction (ntp figures this out and
> > just says "no").  Possibly it is time to ask if we should keep this in the
> > kernel at all.
> 
> I'm thinking about moving the leap second handling to a timer, with the 
> new timer system it would be easy to set a timer for e.g. 23:59.59 and 
> then set the time. This way it would be gone from the common path and it 
> wouldn't matter that much anymore whether it's used or not.

Will the timer solution guarantee consistent and exact updates?

Regards,
Ulrich

