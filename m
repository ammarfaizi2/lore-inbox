Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUHVRYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUHVRYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268038AbUHVRX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:23:28 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55439 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268040AbUHVRVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:21:22 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer Weinigel <christer@weinigel.se>
Cc: Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <m33c2f3zg1.fsf@zoo.weinigel.se>
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	 <2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	 <2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	 <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	 <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	 <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	 <412889FC.nail9MX1X3XW5@burner>
	 <Pine.LNX.4.58.0408221450540.297@neptune.local>
	 <m37jrr40zi.fsf@zoo.weinigel.se>  <m33c2f3zg1.fsf@zoo.weinigel.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093191541.24759.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 17:19:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 17:33, Christer Weinigel wrote:
> /me keeping to the bad habit of following up to myself
> 
> Regarding the current 2.6.8 kernel, wouldn't it be a better idea to
> move the CAP_SYS_RAWIO check to open time instead of when the ioctl is
> called?  This would require a new flag somewhere in the file structure
> I suppose, e.g. file->f_mode & FMODE_RAWIO.  

This leads to all sorts of bugs where descriptors owned by one process
are given to another less priviledged one. In the networking world
similar logic led to holes because rsh for example gave root opened fd's
to users.

Alan

