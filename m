Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262720AbSI1FpW>; Sat, 28 Sep 2002 01:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262721AbSI1FpW>; Sat, 28 Sep 2002 01:45:22 -0400
Received: from waste.org ([209.173.204.2]:17553 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262720AbSI1FpW>;
	Sat, 28 Sep 2002 01:45:22 -0400
Date: Sat, 28 Sep 2002 00:50:40 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] /dev/random cleanup
Message-ID: <20020928055040.GM21969@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resent with current l-k address]

Linus,

The following patches against 2.5.39 clean up the RNG support
substantially. Please pay special attention to the first patch, which
fixes two major bugs in the reseeding logic. They can be easily
demonstrated by running 'cat /dev/random | hexdump' on a quiescent
system. When it blocks, lightly tapping the mouse generates a large
stream of additional output, despite very little entropy being added.

The second and third patches introduce my fixes for the more
theoretical issues and should address all the issues that have been
raised.

The fourth and fifth make the pool and reseeding logic much more clear
and create a new pool for /dev/urandom that avoids starving
/dev/random readers.

Six and seven propagate the new API to the rest of the kernel and
remove dead code.

Please apply.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
