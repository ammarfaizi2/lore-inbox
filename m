Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273920AbRI0VeX>; Thu, 27 Sep 2001 17:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273923AbRI0VeO>; Thu, 27 Sep 2001 17:34:14 -0400
Received: from snowball.fnal.gov ([131.225.81.94]:15122 "EHLO
	snowball.fnal.gov") by vger.kernel.org with ESMTP
	id <S273920AbRI0VeE>; Thu, 27 Sep 2001 17:34:04 -0400
Date: Thu, 27 Sep 2001 16:34:31 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
Message-ID: <Pine.LNX.4.31.0109271622520.28262-100000@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem, as described earlier in this thread by Adam McKenna,
describes errors such as

hda: timeout waiting for DMA
hda: irq timeout: status 0x58 { DriveReady SeekComplete DataRequest}

I have been seeing these errors on a number of systems, although
only intermittently, and they have been similar in nature
on all kernels between 2.2.16 and 2.4.7.

A couple months ago it was reported that someone was testing a
2.4.7-ac2 patch level and not having any lock-ups with ultraDMA.
My question--there was a new file "serverworks.c" inserted in the
2.4.6 ac patches.  Does anyone know if that made it into the kernel
and supposedly fixed the problem?  (My guess is that it has *not*
made it in, although there is a drivers/ide/serverworks.c file
in my 2.4.7-2.9 version of the kernel, it is not the same length
and there are some diffs).  If it didn't make it in,
is there any other patch that is known to work to fix this problem
and make ultradma work properly?  (and if I should be able to RTFM
and figure this out for myself, someone please give me a pointer.)


Some have reported
that using multi-word DMA (hdparm -X34) works but this is
not fast enough for us.

We have seen quite a difference on systems that are otherwise
the same (Supermicro 370DLE w/serverworks OSB4 LE chipset) by swapping
different models of hard disk drives.  With some types of drive
(Seagate) we
observe massive corruption of the file system but nothing reported
in /var/log/messages or on the console.  Currently we see hda
timeouts (but only on about 10 systems over the course of 2 months)
which hang the machine but after a reboot things are fine (Western
Digital).

There have been some rumours on other lists that this bug is tied
to simultaneous access of both IDE busses.  Any truth to that?

If anyone can provide help in tracking the existence of the patch,
or has successfully got UltraDMA working on one of these systems by
any means necessary, please let me know.

Thanks

Steve Timm


------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

