Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRB1XjF>; Wed, 28 Feb 2001 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129389AbRB1Xi4>; Wed, 28 Feb 2001 18:38:56 -0500
Received: from [203.126.247.144] ([203.126.247.144]:25516 "EHLO
	esngs144.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S129388AbRB1Xio>; Wed, 28 Feb 2001 18:38:44 -0500
Message-ID: <3A9D8BC4.45009947@asiapacificm01.nt.com>
Date: Wed, 28 Feb 2001 23:37:40 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ebuddington@wesleyan.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: time drift and fb comsole activity
In-Reply-To: <20010228170030.C2122@sparrow.nad.adelphia.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Buddington wrote:
> 
> I know this has been reported on the list recently, but I think I can
> provide better detail. I'm running 2.4.2 with atyfb on a K6-2/266
> running at 250. This system has no history of clock problems.
> 
> adjtimex-1.12 --compare gives me "2nd diff" readings of -0.01 in quiescent
> conditions.
> 
> flipping consoles rapidly cboosts this number to -3 or -4.
> 
> catting the full documentation to ntpd (seemed appropriate) gives me
> "2nd diff" numbers a little over 34. If I read the numbers correctly,
> 47 seconds of CMOS time passed while the system clock only passed 13
> seconds.
> 
> The processor and the CMOS clock were moving at zero velocity relative
> to each other, and were both in normal Earth gravity.

The kernel blocks interrupts during console output.  fbdev
consoles are slow.  Net result: many lost timer interrupts.

I'm working on it.  Slowly.  Should have something next week.

-
