Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRCPLe6>; Fri, 16 Mar 2001 06:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCPLej>; Fri, 16 Mar 2001 06:34:39 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:39949 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S130470AbRCPLee>; Fri, 16 Mar 2001 06:34:34 -0500
To: linux-kernel@vger.kernel.org
Subject: cannot mount later cdrom sessions with 2.4.x
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 16 Mar 2001 11:33:40 +0000
Message-ID: <y7rhf0uosmj.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is multisession CDROM support broken in 2.4.x?

I have an "Enhanced CD" which has a bunch of audio tracks followed by
a data track (is this the same as CD-XA? I can't remember).  Under
2.2, I can mount the iso9660 filesystem on the data track without
trouble, using the session option:

# mount -o session=19 /mnt/cdrom

But under 2.4.2, the mount fails with this in the kernel log:

Session 20 start 230045 type 4
attempt to access beyond end of device
16:00: rw=0, want=460123, limit=61884
isofs_read_super: bread failed, dev=16:00, iso_blknum=230061, block=460122

It looks like the blk_size entry doesn't get updated to reflect the
fact that isofs has issued an ioctl to switch to a later session on
the disc.

The drive I'm using is:
hdc: MATSHITADVD-ROM SR-8174, ATAPI CD/DVD-ROM drive

Dave Wragg
(hoping that the QuickTime movies on the data track use an xanim
supported codec, but not optimistic)
