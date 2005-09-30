Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVI3Ew2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVI3Ew2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 00:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVI3Ew2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 00:52:28 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:23937 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932202AbVI3Ew1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 00:52:27 -0400
Message-Id: <200509300452.j8U4qKw17804@www.watkins-home.com>
From: "Guy" <bugzilla@watkins-home.com>
To: "'Bill Davidsen'" <davidsen@tmr.com>
Cc: "'Holger Kiehl'" <Holger.Kiehl@dwd.de>,
       "'Mark Hahn'" <hahn@physics.mcmaster.ca>,
       "'linux-raid'" <linux-raid@vger.kernel.org>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Where is the performance bottleneck?
Date: Fri, 30 Sep 2005 00:52:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <433AF75F.2060208@tmr.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcXEaJ43BLlaJKpVRleHS1G4E/vAWQBESlvQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-raid-owner@vger.kernel.org [mailto:linux-raid-
> owner@vger.kernel.org] On Behalf Of Bill Davidsen
> Sent: Wednesday, September 28, 2005 4:05 PM
> To: Guy
> Cc: 'Holger Kiehl'; 'Mark Hahn'; 'linux-raid'; 'linux-kernel'
> Subject: Re: Where is the performance bottleneck?
> 
> Guy wrote:
> 
> >In most of your results, your CPU usage is very high.  Once you get to
> about
> >90% usage, you really can't do much else, unless you can improve the CPU
> >usage.
> >
> That seems one of the problems with software RAID, the calculations are
> done in the CPU and not dedicated hardware. As you move to the top end
> drive hardware the CPU gets to be a limit. I don't remember off the top
> of my head how threaded this code is, and if more CPUs will help.

My old 500MHz P3 can xor at 1GB/sec.  I don't think the RAID5 logic is the
issue!  Also, I have not seen hardware that fast!  Or even half as fast.
But I must admit, I have not seen a hardware RAID5 in a few years.  :(

   8regs     :   918.000 MB/sec
   32regs    :   469.600 MB/sec
   pIII_sse  :   994.800 MB/sec
   pII_mmx   :  1102.400 MB/sec
   p5_mmx    :  1152.800 MB/sec
raid5: using function: pIII_sse (994.800 MB/sec)

Humm..  It did not select the fastest?

Guy
> 
> I see you are using RAID-1 for your system stuff, did one of the tests
> use RAID-0 over all the drives? Mirroring or XOR redundancy help
> stability but hurt performance. Was the 270MB/s with RAID-0 or ???
> 
> --
> bill davidsen <davidsen@tmr.com>
>   CTO TMR Associates, Inc
>   Doing interesting things with small computers since 1979
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

