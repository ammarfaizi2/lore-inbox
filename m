Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSFYGZF>; Tue, 25 Jun 2002 02:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSFYGZE>; Tue, 25 Jun 2002 02:25:04 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:25042 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S312558AbSFYGZD>; Tue, 25 Jun 2002 02:25:03 -0400
Date: Mon, 24 Jun 2002 23:25:53 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: "R. Steve McKown" <smckown@titaniummirror.com>
cc: realtek@scyld.com, <linux-kernel@vger.kernel.org>
Subject: Re: System hang with heavy network traffic using rtl8139c
In-Reply-To: <3D17BEFA.6030008@titaniummirror.com>
Message-ID: <Pine.LNX.4.44.0206242318280.4858-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try the scyld/Donald Becker driver...

http://www.scyld.com/network/rtl8139.html

The realtek 8139 chip has, a probably well deserved reputation of being
unsuitable for high performance network applications so it may the case
that they are simply unsuitable for your application.

joelja

On Mon, 24 Jun 2002, R. Steve McKown wrote:

> Hi -
> 
> We have a multi-threaded load test program that will cause any x86 
> system configuration upon which we've tried that that contains at least 
> one rtl8139c to hard lock the system.  The exact same OS image and test 
> program has been shown to run on several exact same configurations by 
> simply replacing the rtl8139c device(s) with intel 82559ER's or Digital 
> 21143TD's.  Please read on for more info.
> 
> 
> I am involved in reliability testing of our linux-based network device 
> with which we plan to use realtek 8139c parts as its three main network 
> interfaces.  The system is architecturally very much like an x86 PC and 
> runs a standard linux 2.4.16 kernel with some well-used community 
> patches and/or driver modules.
> 
> We created a multi-threaded test program that generates bidirectional 
> traffic over all network interfaces simultaneously as fast as possible. 
>  Using this test, the system will lock up hard, taking from 90 seconds 
> to 1.5 weeks to do so.  Most failures occur, however, within the 2-5 
> hour range.  The lock-up is complete, in that not even sysrq works. 
>  More typical network traffic patterns do not cause lockups.  In 
> general, the test configurations have between 4 and 8 network devices 
> installed in the system, with most tests running with 8 devices.  No 
> test has used more than 4 devices of any single chipset.
> 
> We have ran our test on various hardware configurations to narrow the 
> problem boundaries, and the results are always the same: if the 
> configuration includes a RealTek 8139C part it will lock up.  If it 
> contains *no* 8139C it will not.
> 
> We can duplicate this behaviour on our hardware using either Geode GX1 
> processors or Transmeta Crusoe TM5800 processors.  We can duplicate it 
> on desktop Pentium MMX-based systems that contain none of our hardware. 
>  Realtek configurations lock up regardless of which driver we are using 
> (rtl8139 v1.18 / pci-scan v1.08 or 8139too v0.9.22).  With any 
> configuration, replacing the rtl parts with intel (82559ER) or digital 
> (21143TD) and the system will not fail.  The reverse has also been true. 
> Mixed-part environments fail even with a single rtl part installed, but 
> will not if there are no rtl parts.
> 
> I'm hoping to get some feedback from some of you out there who have 
> worked with this part more than I.  I'll be happy to post specifics as 
> requested.  I also appreciate thoughts on how to debug this problem 
> given that it fully locks up the system.
> 
> I have posted this message to LKML and to the realtek ML, so reply 
> accordingly.
> 
> All the best,
> R. Steve McKown
> Titanium Mirror, Inc.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


