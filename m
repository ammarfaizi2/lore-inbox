Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269909AbRHEETg>; Sun, 5 Aug 2001 00:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269912AbRHEET1>; Sun, 5 Aug 2001 00:19:27 -0400
Received: from zeus.kernel.org ([209.10.41.242]:52374 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269909AbRHEETN>;
	Sun, 5 Aug 2001 00:19:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: alad@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: fcgp understanding 
In-Reply-To: Your message of "Tue, 31 Jul 2001 13:49:16 +0530."
             <65256A9A.002DAB65.00@sandesh.hss.hns.com> 
Date: Sun, 05 Aug 2001 14:19:18 +1000
Message-Id: <E15TFNq-0008V2-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <65256A9A.002DAB65.00@sandesh.hss.hns.com> you write:
> Hi,
>      Can somone please explain in brief -- How to read fcgp ( Free coding
> graphical project) for a
> particular file. One such map (for mmap.c) is at --
> http://fcgp.sourceforge.net/images/mm_mmap.c.png

This is off-topic, but maybe one canonical answer will stop others.

	The solid line (around the top and right edges) is a C file,
labelled on the bottom left.  The dashed lines means a function,
labelled on the bottom left.  Light green functions are file-local
(static).  Red functions are exported to modules.  Dark green
functions are called through a pointer.  Other functions are blue.

	Within each function, the circles are loops, the branches are
conditional statements (if, switch, ?:).  The loops approximately
circle the code they loop around.

	So, we can see that do_munmap looks like a loop around a whole
heap of little branchy code.  Indeed, looking at the code in mm/mmap.c,
half the function is a loop.

Hope that helps,
Rusty.
--
Premature optmztion is rt of all evl. --DK
