Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUDWUYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUDWUYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUDWUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:24:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:61891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbUDWUYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:24:03 -0400
Date: Fri, 23 Apr 2004 13:17:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] blkdev.h: functions no longer inline
Message-Id: <20040423131756.708e8c36.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


// linux-266-rc2
// These are EXPORTed SYMBOLs; 'inline' was removed from them
// in ll_rw_blk.c on 2002-11-25.

diffstat:=
 include/linux/blkdev.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naurp ./include/linux/blkdev.h~extern_inline ./include/linux/blkdev.h
--- ./include/linux/blkdev.h~extern_inline	2004-04-20 15:54:29.000000000 -0700
+++ ./include/linux/blkdev.h	2004-04-23 12:01:30.000000000 -0700
@@ -513,8 +513,8 @@ extern void blk_requeue_request(request_
 extern void blk_plug_device(request_queue_t *);
 extern int blk_remove_plug(request_queue_t *);
 extern void blk_recount_segments(request_queue_t *, struct bio *);
-extern inline int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
-extern inline int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
+extern int blk_phys_contig_segment(request_queue_t *q, struct bio *, struct bio *);
+extern int blk_hw_contig_segment(request_queue_t *q, struct bio *, struct bio *);
 extern int scsi_cmd_ioctl(struct gendisk *, unsigned int, unsigned long);
 extern void blk_start_queue(request_queue_t *q);
 extern void blk_stop_queue(request_queue_t *q);
