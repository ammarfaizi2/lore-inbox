Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269298AbUINNdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269298AbUINNdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUINNcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:32:46 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:38274 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269280AbUINNcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:32:02 -0400
Subject: Re: [patch] sched: fix scheduling latencies in NTFS mount
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040914113523.GC2804@elte.hu>
References: <20040914095731.GA24622@elte.hu>
	 <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu>
	 <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu>
	 <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <20040914112847.GA2804@elte.hu>  <20040914113523.GC2804@elte.hu>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1095168699.9033.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 14:31:39 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 12:35, Ingo Molnar wrote:
> this patch fixes scheduling latencies in the NTFS mount path. We are
> dropping the BKL because the code itself is using the ntfs_lock
> semaphore which provides safe locking.
> 
> has been tested as part of the -VP patchset.

Looks good.  I designed the NTFS driver to not rely on the BKL at all so
you should be able to drop it anywhere you like.  (-:

I have applied your patch to my ntfs-2.6-devel bk tree so it doesn't get
lost.

Thanks,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

