Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbRD1TDU>; Sat, 28 Apr 2001 15:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135597AbRD1TDK>; Sat, 28 Apr 2001 15:03:10 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:58765 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132614AbRD1TC4>; Sat, 28 Apr 2001 15:02:56 -0400
Date: Sat, 28 Apr 2001 19:13:56 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: kernel lock in dcache.c
Message-ID: <Pine.LNX.4.21.0104281909320.703-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  d_move() in fs/dcache.c is checking the kernel lock is held
(switch_names() does the same, but is only called from d_move()).

  My question is why?
  I can't see what it is using the kernel lock to sync/protect against.

  Anyone out there know?

Thanks,
Mark

