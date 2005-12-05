Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVLEIAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVLEIAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 03:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVLEIAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 03:00:52 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:36488 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751322AbVLEIAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 03:00:51 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: george@mvista.com
Date: Mon, 05 Dec 2005 08:59:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Message-ID: <4394018D.19764.2440ED5D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <4390E48E.4020005@mvista.com>
References: <20051202032604.19357.59425.sendpatchset@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=112929@20051205.074535Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Dec 2005 at 16:19, George Anzinger wrote:

> john stultz wrote:
> > All,
> > 	Here is the second of two patches which try to minimize my ntp rework
> > patches.
> > 	
> > This patch further changes the interrupt time NTP code, breaking out the
> > leapsecond processing and introduces an accessor to a shifted ppm
> 
> In a discusson aroung the leapsecond and how to disable it (some folks 
> don't want the time jump) it came to light that, for the most part, 
> this is unused code.  It requires that time be kept in UST to be 
> useful and, from what I can tell, most folks keep time in their local 
> timezone, thus, effectively, disableing the usage of the leapsecond 
> correction (ntp figures this out and just says "no").  Possibly it is 
> time to ask if we should keep this in the kernel at all.

I think this is not a question at all whether people like leap seconds or not: 
Either they want to have the current official time, or they do not. If they do 
not, they won't care about NTP; if they do they'd use it.

If they don't like leap seconds, they'd go into politics to forbid them by law.

Regards,
Ulrich

