Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUHWSVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUHWSVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUHWSTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:19:22 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:53237 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S266479AbUHWSQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:16:43 -0400
Date: Mon, 23 Aug 2004 21:16:39 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: der.eremit@email.de, christer@weinigel.se, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <4128CAA2.nail9RG21R1OG@burner>
Message-ID: <Pine.LNX.4.58.0408232113030.4258@kai.makisara.local>
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
 <2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
 <2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
 <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
 <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
 <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
 <412889FC.nail9MX1X3XW5@burner> <Pine.LNX.4.58.0408221450540.297@neptune.local>
 <m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Joerg Schilling wrote:

> Christer Weinigel <christer@weinigel.se> wrote:
> 
...
> > One is to make cdrecord suid root and then make it drop all
> > capabilities except for SYS_CAP_RAWIO.  But even if cdrecord is
> > audited, there are a lot of other applications that need to be able to
> > send raw SCSI commands such as mt (to change the compression or tape
> > format of a streamer).  And this violates goal 2, every security guide
> > I've seen lately recommends minimizing the amount of suid binaries,
> > not adding more.
> 
> A better way is to have services like this in /usr/bin/pfexec that 
> do the ecirity related parts before calling the other binaries.
> 
> BTW: 'mt' should not need to send SCSI comands. THis shoul dbe handled via
> specilized ioctls.
> 
There are already ioctls for changing the tape parameters. Christer, there 
is no need to introduce tapes into this discussion.

-- 
Kai
