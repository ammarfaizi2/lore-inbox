Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTJXNdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 09:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTJXNdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 09:33:41 -0400
Received: from sojef.skynet.be ([195.238.2.127]:17028 "EHLO sojef.skynet.be")
	by vger.kernel.org with ESMTP id S262188AbTJXNdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 09:33:39 -0400
Subject: Re: problems with Seagate 120 GB drives when mutlwrite = 16
From: kris <kris.buggenhout@skynet.be>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200310191908.14369.bzolnier@elka.pw.edu.pl>
References: <1066578892.3091.11.camel@borg-cube.lan>
	 <200310191908.14369.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1067002420.3015.7.camel@borg-cube.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 24 Oct 2003 15:33:41 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (sojef.skynet.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-19 at 19:08, Bartlomiej Zolnierkiewicz wrote: 
> On Sunday 19 of October 2003 17:54, kris wrote:
> > Hi,
> 
> Hi,
> 
> > I have noticed some problems with recent large drives, connected to a
> > variety of controllers.
> >
> > I tested with nforce ide controller, a CMD649 based controller and an
> > Intel 870 cghipset. all have same or similar symptoms.
> >
> > Linux 2.4.22 kernel : (Linux borg-cube 2.4.22-xfs #2 SMP Tue Oct 7
> > 20:53:04 CEST 2003 i686 unknown)
> >
> > Oct  6 15:52:12 borg-cube kernel: hdg: dma_timer_expiry: dma status ==
> > 0x21
> > Oct  6 15:52:22 borg-cube kernel: hdg: timeout waiting for DMA
> > Oct  6 15:52:22 borg-cube kernel: hdg: timeout waiting for DMA
> > Oct  6 15:52:22 borg-cube kernel: hdg: status error: status=0x58 {
> > DriveReady SeekComplete DataRequest }
> > Oct  6 15:52:22 borg-cube kernel:
> > Oct  6 15:52:22 borg-cube kernel: hdg: drive not ready for command
> > Oct  6 15:52:22 borg-cube kernel: hdg: status timeout: status=0xd0 {
> > Busy }
> > Oct  6 15:52:22 borg-cube kernel:
> > Oct  6 15:52:22 borg-cube kernel: hdg: no DRQ after issuing WRITE
> > Oct  6 15:52:22 borg-cube kernel: ide3: reset: success
> >
> > same in 2.4.20 ( kernel from Suse)
> >
> > 2.6.0-test6 :
> >
> > Oct  9 09:43:09 borg-cube kernel: hdg: dma_timer_expiry: dma status ==
> > 0x21
> > Oct  9 09:43:18 borg-cube kernel:
> > Oct  9 09:43:19 borg-cube kernel: hdg: DMA timeout error
> > Oct  9 09:43:19 borg-cube kernel: hdg: dma timeout error: status=0x58 {
> > DriveReady SeekComplete DataRequest }
> > Oct  9 09:43:19 borg-cube kernel:
> > Oct  9 09:43:19 borg-cube kernel: hdg: status timeout: status=0xd0 {
> > Busy }
> > Oct  9 09:43:19 borg-cube kernel:
> > Oct  9 09:43:19 borg-cube kernel: hdg: no DRQ after issuing MULTWRITE
> > Oct  9 09:43:20 borg-cube kernel: ide3: reset: success
> >
> > same in 2.6.0-test8
> >
> > so behaviour is consistent.
> >
> > I can avoid this with either turning off dma access or disabling the
> > multwrite ( hdparm -m0 /dev/hdg)
> >
> > is this a known bug, or should I file one ?
> 
> Error message is known, but fact that disabling PIO multiwrite cures
> it is new, so please fill bugzilla entry.

I have to come back on this... i did not test it enough apparently...
when i was transferring cd-images from one system to the other... the
dreaded ide reset occurred again...

so disabling multiwrite is not involved.

The 60GB disk (with the OS) is working fine on my nforce ide controller.
but the 120GB disks are not... I verified, it is not a cabling issue...
used different cables, different lengths, at the moment they are
connected with shielded rounded cables. 

Is there a fix for this ( not the workaround ... disabling dma) or are
these 120Gb disks just plain bad choice.... ;(

I do not notice any problems when i use the disk in windoows, but then
again, windows tends to hide these things...;)

kind regards,Kris


