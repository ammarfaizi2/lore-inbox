Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbREPIEi>; Wed, 16 May 2001 04:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261825AbREPIE3>; Wed, 16 May 2001 04:04:29 -0400
Received: from mail.sai.co.za ([196.33.40.8]:17934 "EHLO mail.sai.co.za")
	by vger.kernel.org with ESMTP id <S261824AbREPIER>;
	Wed, 16 May 2001 04:04:17 -0400
From: "David Wilson" <davew@sai.co.za>
To: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: FW: I think I've found a serious bug in AMD Athlon page_alloc.c routines, where do I mail the developer(s) ?
Date: Wed, 16 May 2001 10:05:50 +0200
Message-ID: <NEBBJFIIGKGLPEBIJACLAEHKDMAA.davew@sai.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <Pine.LNX.4.10.10105151853040.15328-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for getting back to me, yea I'm running my fsb at 100
already....still seems to be the same problem.
I donno, I'm just gonna have to mess around with things till I get it right
;-)

Thanks for the guidance anyways.


Regards
David Wilson
Technical Support Centre
The S.A Internet
0860 100 869
http://www.sai.co.za



-----Original Message-----
From: Mark Hahn [mailto:hahn@coffee.psychology.mcmaster.ca]
Sent: 16 May 2001 01:01
To: David Wilson
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: I think I've found a serious bug in AMD Athlon
page_alloc.c routines, where do I mail the developer(s) ?


> I think I've found a serious bug in AMD Athlon page_alloc.c routines in

there's nothing athlon-specific there.

> correct on the DFI AK75-EC motherboard, if I set the CPU kernel type to
586
> everything is 100%, if I use "Athlon" kernel type I get:
> kernel BUG at page_alloc.c:73

when you select athlon at compile time, you're mainly
getting Arjan's athlon-specific page-clear and -copy functions
(along with some relatively trivial alignment changes).
these functions are ~3x as fast as the generic ones,
and seem to cause dram/cpu-related oopes on some machines.

in short: faster code pushes the hardware past stability.
there's no reason, so far, to think that there's anything
wrong with the code - Alan had a possible issue with prefetching
and very old Atlons, but the people reporting problems like this
are actually running kt133a and new fsb133 Athlons.

> I've changed RAM, Motherboard etc... still the same.

changed to a non-kt133a board?  how about running fsb and/or dram
at 100, rather than 133?

> Also the same system runs linux-2.2.16 100%

2.2 doesn't have the fast page-clear and -copy code afaik.

afaik, there are *no* problems on kt133 machines,
and haven't heard any pain from people who might have
Ali Magic1, AMD 760 or KT266 boards, but they're still rare.


