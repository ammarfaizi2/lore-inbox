Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261667AbRESGwg>; Sat, 19 May 2001 02:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbRESGw0>; Sat, 19 May 2001 02:52:26 -0400
Received: from skif.spylog.com ([194.67.35.250]:53569 "HELO skif.spylog.com")
	by vger.kernel.org with SMTP id <S261667AbRESGwS>;
	Sat, 19 May 2001 02:52:18 -0400
Date: Sat, 19 May 2001 10:52:01 +0400
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.51)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: http://www.spylog.ru
X-Priority: 3 (Normal)
Message-ID: <24243045671.20010519105201@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.4 folks
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  I've trying to move some of my servers to 2.4.4 kernel from 2.2.x.
  Everything goes fine, notable perfomance increase occures, but the
  problem is I'm really often touch the following problem:

__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.

This message may also show 1-order, 0-order, 3-order failures (only
one type at the time).  This problems also appeared then I tried to
use 2.4.1-2.4.3 kernels.

This sometimes leads to system hang, sometimes some processes gets
unkillable (even by kill -9) and in some cases I do not see any bad
results from this, but still this does not looks the right thing to
happen.

The problem is the systems this happens on are not short of memory.
Here is the free output for the system I had this happened this
morning:

rat:~ #  free
             total       used       free     shared    buffers     cached
Mem:       1028628    1025820       2808          0       9340     332412
-/+ buffers/cache:     684068     344560
Swap:      2097136          0    2097136


Does anyone has any ideas about this problem ?


-- 
Best regards,
 Peter                          mailto:pz@spylog.ru


