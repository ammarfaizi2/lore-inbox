Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTKURpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 12:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTKURpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 12:45:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60431 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264387AbTKURpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 12:45:49 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test9 breaks cdrecord w. ide-scsi device
Date: 21 Nov 2003 17:34:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bplic2$fdl$1@gatekeeper.tmr.com>
References: <200310310012.47580.p_christ@hol.gr> <20031030171432.03dcaa76.mikeserv@bmts.com> <200311011219.21890.p_christ@hol.gr>
X-Trace: gatekeeper.tmr.com 1069436098 15797 192.168.12.62 (21 Nov 2003 17:34:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200311011219.21890.p_christ@hol.gr>,
P. Christeas <p_christ@hol.gr> wrote:
| > Hello
| >
| > ...
| >  
| > There is now ide-cd writing support, and cdrecord 2 supports it. I build
| > that stuff modular, so I just load the ide-cd and isofs modules (modprobe
| > takes care of the rest). I achieve the fastest writing speeds I've ever
| > had, using this driver. Far better than ide-scsi or even Sleazy CD Creator
| > in Windows.
| >
| >...
| 
| Tried it. Now used /dev/hdd there..
| This time it worked a few times and some other times it failed. 
| It now seems that I got a buffer underrun, although I do have 'realtime 
| priority' for the process.
| Note that I'm not using 'burnfree'. That's why I have linux anyway :) .
| 
| Can anybody examine why is the buffer of cdrecord less than 100% with 
| RR-scheduling? That would never happen in 2.4, cdrecord 1.10 ..

If you haven't solved this yet (firmware current?) you might try using a
large fifo, starting a burn, then looking at the system with vmstat to
see if there's a lot of system time. If so, I suspect the you are using
PIO in spite of the new method and selection of DMA for the device.

In any case it will provide a data point.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
