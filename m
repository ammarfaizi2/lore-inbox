Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWAaHG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWAaHG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWAaHG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:06:58 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31139
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030303AbWAaHG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:06:57 -0500
Date: Mon, 30 Jan 2006 23:06:42 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Linux 2.6.15.2
Message-ID: <20060131070642.GA25015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.15.2 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.15.1 and 2.6.15.2, as it is small enough to do so.

The updated 2.6.15.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.15.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                       |    2 -
 arch/sparc64/kernel/time.c     |   22 +++++++--------
 arch/x86_64/kernel/pci-gart.c  |    1 
 block/ll_rw_blk.c              |   24 ----------------
 drivers/ide/ide-cd.c           |   10 ------
 drivers/message/i2o/i2o_scsi.c |    2 -
 drivers/net/hamradio/mkiss.c   |    1 
 drivers/usb/input/pid.c        |    2 -
 fs/reiserfs/super.c            |    2 -
 fs/ufs/util.h                  |    4 +-
 include/linux/blkdev.h         |    1 
 include/linux/skbuff.h         |    2 -
 ipc/mqueue.c                   |   59 ++++++++++++++++++++++-------------------
 sound/usb/usbaudio.c           |   26 ++++++++++++++----
 14 files changed, 74 insertions(+), 84 deletions(-)

Summary of changes from v2.6.15.1 to v2.6.15.2
==============================================

Alexander Viro:
      Fix double decrement of mqueue_mnt->mnt_count in sys_mq_open (CVE-2005-3356)

Andi Kleen:
      Mask off GFP flags before swiotlb_alloc_coherent

Clemens Ladisch:
      usb-audio: don't use empty packets at start of playback

David S. Miller:
      Make second arg to skb_reserved() signed.

Dmitry Torokhov:
      Input: HID - fix an oops in PID initialization code

Evgeniy:
      Fix oops in ufs_fill_super at mount time

Greg Kroah-Hartman:
      Linux 2.6.15.2

Jens Axboe:
      Kill blk_attempt_remerge()

Markus Lidel:
      Fix i2o_scsi oops on abort

Ralf Baechle DL5RB:
      Fix mkiss locking bug

Richard Mortimer:
      Fix timekeeping on sparc64 ultra-IIe machines

Vitaly Fertman:
      Someone broke reiserfs v3 mount options and this fixes it

