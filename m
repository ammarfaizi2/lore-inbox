Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSGCTDN>; Wed, 3 Jul 2002 15:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSGCTDM>; Wed, 3 Jul 2002 15:03:12 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:48941 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317171AbSGCTDL>; Wed, 3 Jul 2002 15:03:11 -0400
Subject: EXT3-fs error on kernel 2.4.18-pre3
From: Anton Altaparmakov <aia21@cantab.net>
To: sct@redhat.com, Andrew Morton <akpm@zip.com.au>, adilger@turbolinux.com
Cc: LKML <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Jul 2002 20:05:38 +0100
Message-Id: <1025723138.3817.10.camel@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed that my file server running 2.4.18-pre3 + IDE patches &
NTFS patches has this error message in the logs:

EXT3-fs error (device md(9,4)): ext3_free_blocks: Freeing blocks not in
datazone - block = 33554432, count = 1

This is the only ext3 error I have seen and the uptime is currently over
74 days. The error actually appeared two weeks ago. The timing coincides
well with when this device (/dev/md4, a MD RAID-1 array) ran out of
space, so it may well be related.

All seems to be working again after I freed up some space. Haven't run
fsck as I would hate to down the server with that nice uptime...

Should I be worried?

I am only mentioning this as I suppose it may be a bug somewhere in
ENOSPC handling, so perhaps someone is interested in this report...

-- 
Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
