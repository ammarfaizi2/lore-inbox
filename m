Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSILQRz>; Thu, 12 Sep 2002 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSILQRz>; Thu, 12 Sep 2002 12:17:55 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:48141 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316519AbSILQRy>;
	Thu, 12 Sep 2002 12:17:54 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209121622.g8CGMgP07303@oboe.it.uc3m.es>
Subject: route inode->block_device in 2.5?
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Thu, 12 Sep 2002 18:22:42 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a pointer chain by which one can get to the struct
block_device of the underlying block device from an inode?

Well, or from kdev_t (since inode->i_rdev is such).

I want to drop a 'special' request on to the request queue of the
backing device, but I can't find a convenient entry point with more than
an inode to hand, and I can't find the route from there.  Tes, I can get
the major, and look at that offset in the blk_dev array, but those are
blk_dev_struct 's not struct block_device's.

I agree that you may well ask why I want to do this, but at the moment
this is just experimetin, so i can't answer sensibly - to try the effect
of 'special' requests, maybe. If it's not possible, tell me, and I'll
concentrate on some other thing.

Thanks for any hint kindly dropped ..

Peter
