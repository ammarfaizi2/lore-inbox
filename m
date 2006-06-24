Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933212AbWFXHtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212AbWFXHtN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 03:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933213AbWFXHtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 03:49:13 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:17641 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S933212AbWFXHtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 03:49:13 -0400
Date: Sat, 24 Jun 2006 08:49:11 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] intelfb cleanup
Message-ID: <Pine.LNX.4.64.0606240848210.30220@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you pull the intelfb-patches branch from:
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6

It contains a cleanup from Al for some really brutal previous efforts
at sparse cleanups.

Dave.


  drivers/video/intelfb/intelfb.h    |    2 +-
  drivers/video/intelfb/intelfbdrv.c |   18 +++++++++---------
  drivers/video/intelfb/intelfbhw.c  |   24 ++++++++++--------------
  3 files changed, 20 insertions(+), 24 deletions(-)

commit 0fe6e2d2928e089d16ec5ed7ba634c1d60916020
Author: Al Viro <viro@ftp.linux.org.uk>
Date:   Fri Jun 23 06:05:39 2006 +0100

     intelfb delousing

     ring_head is offset in card memory, not iomem pointer.  Fixed, removed
     fuckloads of amazingly bogus casts somebody had sprinkled all over the
     place.

     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
     Signed-off-by: Dave Airlie <airlied@linux.ie>
