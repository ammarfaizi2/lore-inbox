Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130175AbRCCAbI>; Fri, 2 Mar 2001 19:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130179AbRCCAa7>; Fri, 2 Mar 2001 19:30:59 -0500
Received: from clev-max5-cs-43.dial.bright.net ([209.143.46.237]:19981 "EHLO
	skylab.winds.org") by vger.kernel.org with ESMTP id <S130175AbRCCAao>;
	Fri, 2 Mar 2001 19:30:44 -0500
Date: Fri, 2 Mar 2001 19:31:51 -0500 (EST)
From: Byron Stanoszek <gandalf@skylab.winds.org>
To: <linux-kernel@vger.kernel.org>
Subject: Memory-related hangup (2.4.2-ac3)
Message-ID: <Pine.LNX.4.31.0103021922240.5032-100000@skylab.winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason why the kernel appears to hang temporarily for 3-5 minutes
under this circumstance:

gandalf:~> free
             total       used       free     shared    buffers     cached
Mem:        126700     125024       1676          0        964      61640
-/+ buffers/cache:      62420      64280
Swap:        97648      97648          0


The system seems to favor the cache, but leaves no room for processes to use
the remaining 64MB of ram. This happened while running netscape after viewing
a couple of pages with a lot of images on them.

Older kernels would happily allow processes to eat up cache space when memory
was low. In fact, I used to be able to use 32MB of swap without any problems
(even when netscape had more memory allocated to it than this now).

Lately with 2.4 kernels I had to add another 64MB swap file to the existing 32,
and the performance seems no different than without it, when compared to the
old way of letting netscape just use all 125MB if it wants to (and sacrifice
cached files, which aren't important in this case).

Is there a setting I can control to force the kernel to give up cache when
memory is low without hanging the machine? I personally don't think 50% process
memory + 50% cache is an ideal solution--especially when running stuff that
really wants >= 150MB (RAM + swap).

Actually I'd prefer having cache use half the remaining RAM not taken up by
processes, instead of half the total RAM on the system. Any suggestions?

Regards,
 Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

