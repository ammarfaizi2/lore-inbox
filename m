Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWAJJfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWAJJfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 04:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWAJJfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 04:35:12 -0500
Received: from mx.laposte.net ([81.255.54.11]:26116 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932168AbWAJJfL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 04:35:11 -0500
Date: Tue, 10 Jan 2006 10:33:17 +0100
Message-Id: <ISVEJH$DEFF7A73BB517DB961D40DE65BBC816F@laposte.net>
Subject: Re: panic with AIC7xxx
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "emmanuel\.fuste" <emmanuel.fuste@laposte.net>
To: "bunk" <bunk@stusta.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "James\.Bottomley" <James.Bottomley@SteelEye.com>,
       "linux-scsi" <linux-scsi@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B103)
X-SenderIP: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> On Sat, Oct 29, 2005 at 01:34:20AM +0200, Emmanuel Fusté wrote:
> 
> > Hello,
> 
> Hi Emmanuel,
> 
> > I recently made the switch from 2.4.26 to 2.6.13 and
2.6.14rc5 on my old
> > dual 586mmx 233mhz.
> 
> are your problems still present in 2.6.15?
> 
> > I've got many problems with SMP on 2.6.13 (bad irq
balancing/routing
> > very bad performance on IDE and SCSI) but I tried to use
the long
> > awaited CDRW support.
> > I format a disc with cdrwtools -d/dev/cdrw -t4 -q
> > the initialisation of the disc start and ~5min later I got :
> > 
> > Oct 20 20:44:57 rafale kernel: scsi0:0:3:0: Attempting to
queue an ABORT message
> > Oct 20 20:44:57 rafale kernel: CDB: 0x4 0x17 0x0 0x0 0x0 0x0
> > Oct 20 20:44:57 rafale kernel: scsi0: At time of recovery,
card was not paused
......
> > 
> > Now I use a 2.6.14rc5 kernel with great results from a
performance stand
> > point: no longer bad SMP IRQ routing/balancing, good perfs
for IDE and
> > SCSI disc but when I try to blank a disc with the same
command:
> > cdrwtools -d/dev/cdrw -t4 -q
> > Nothing append and the cd-writer/scsi bus directly crash:
> > Oct 26 21:07:57 rafale kernel: scsi0:0:3:0: Attempting to
queue an ABORT message
> > Oct 26 21:07:57 rafale kernel: CDB: 0x5c 0x0 0x0 0x0 0x0
0x0 0x0 0x0 0xc 0x0 0x0 0x0
> > Oct 26 21:07:57 rafale kernel: scsi0: At time of recovery,
card was not paused
.......
> 
> cu
> Adrian
> 
> -- 

I was waiting the merge of the patch serie from Hannes
Reinecke <hare () suse ! de>, because of the sequencer fixes.
I did'nt try this patch serie myself because the sequencer
fixes one ([PATCH 5/6]] never reach lkml or linux-scsi.

I will compile a clean 2.6.15 today and give it a try this
evening.

Regards,
Emmanuel.

Accédez au courrier électronique de La Poste : www.laposte.net ; 
3615 LAPOSTENET (0,34 €/mn) ; tél : 08 92 68 13 50 (0,34€/mn)



