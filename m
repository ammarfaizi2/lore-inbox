Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbRBTUgb>; Tue, 20 Feb 2001 15:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRBTUgV>; Tue, 20 Feb 2001 15:36:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:260 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129294AbRBTUgF>;
	Tue, 20 Feb 2001 15:36:05 -0500
Date: Tue, 20 Feb 2001 21:35:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: patch: loop-5
Message-ID: <20010220213553.B31903@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Slightly delayed, but here is loop-5. It's against 2.4.2-pre4, as
testing on 2.4.1-ac19 showed other problems (oom killer would kill
dbench or bash before it could finish...). I'll take a look at ac19
next. Changes since loop-4:

o Make sure loop_thread is up. A mount -o loop could sometimes sneak
  in a request before the helper thread was started. (me)

o Remove all the backing file setup, count on get_file just
  holding a reference to it. (Neil Brown)

o Remove fs/buffer.c:wakeup_bdflush work around. loop doesn't block
  on requests, so it shouldn't be needed.

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre4/loop-5

-- 
Jens Axboe

