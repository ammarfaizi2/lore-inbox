Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280939AbRKGTvR>; Wed, 7 Nov 2001 14:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280950AbRKGTvI>; Wed, 7 Nov 2001 14:51:08 -0500
Received: from proxy1.addr.com ([209.249.147.248]:28174 "EHLO proxy1.addr.com")
	by vger.kernel.org with ESMTP id <S280939AbRKGTut>;
	Wed, 7 Nov 2001 14:50:49 -0500
Date: Wed, 7 Nov 2001 14:50:01 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-Id: <20011107145001.7f11aa56.dang@fprintf.net>
In-Reply-To: <20011107213837.F26218@niksula.cs.hut.fi>
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu>
	<E161Vbf-0000m9-00@lilac.csi.cam.ac.uk>
	<20011107213837.F26218@niksula.cs.hut.fi>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I run both ext3 and reiserfs on the same computer, and, after a crash, neither of them run fsck.  My ext3 partition is mounted on /, so maybe it matters that it's mounted *before* it's fscked?  The journal replay should mark it clean, so fsck should only run when it times out.  You can also set the fsck number to "0" in your fstab, and it will never fsck, but then you will loose the periodic fscks.  (I run 2.4.13-ac7-preempt-sse at the moment.)

Daniel
--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary


On Wed, 7 Nov 2001 21:38:37 +0200
Ville Herva <vherva@niksula.hut.fi> wrote:

> On Wed, Nov 07, 2001 at 04:31:24PM +0000, you [James A Sutherland] claimed:
> > 
> > Hm.. after a decidedly unclean shutdown, I decided to force an fsck here
> > and my ext3 partition DID have two inode errors on fsck... (Having said
> > that, the last entry in syslog was from the SCSI driver, and ext3's
> > journalling probably doesn't help much when the disk it's on goes AWOL...)
> 
> A stupid question: does ext3 replay the journal before fsck? If not, the
> inode errors would be expected...
> 
> 
> -- v --
> 
> v@iki.fi
