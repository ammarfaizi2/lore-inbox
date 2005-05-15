Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVEOQ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVEOQ4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 12:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVEOQ4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 12:56:13 -0400
Received: from one.firstfloor.org ([213.235.205.2]:27521 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261434AbVEOQ4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 12:56:11 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       okuyamak@dd.iij4u.or.jp
Subject: Re: Disk write cache
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	<200505151121.36243.gene.heskett@verizon.net>
	<20050515152956.GA25143@havoc.gtf.org>
	<20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	<42877C1B.2030008@pobox.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 May 2005 18:56:09 +0200
In-Reply-To: <42877C1B.2030008@pobox.com> (Jeff Garzik's message of "Sun, 15
 May 2005 12:43:07 -0400")
Message-ID: <m1zmuw8m3a.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
>
> The ability of a filesystem or fsync(2) to cause a [FLUSH|SYNC] CACHE
> command to be generated has only been present in the most recent 2.6.x
> kernels.  See the "write barrier" stuff that people have been
> discussing.

Are you sure mainline does it for fsync() file data at all? iirc it
was only done for journal writes in reiserfs/xfs/jbd. However since
I suppose a lot of disks flush everything pending on a flush cache
command it still works assuming the file systems write the 
data to disk in fsync before syncing the journal. I don't know
if they do that.

-Andi
