Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313854AbSDZLku>; Fri, 26 Apr 2002 07:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313862AbSDZLkt>; Fri, 26 Apr 2002 07:40:49 -0400
Received: from uisge.3dlabs.com ([193.133.230.45]:9415 "EHLO uisge.3dlabs.com")
	by vger.kernel.org with ESMTP id <S313854AbSDZLks>;
	Fri, 26 Apr 2002 07:40:48 -0400
Date: Fri, 26 Apr 2002 12:34:59 +0100
From: Paul Sargent <Paul.Sargent@3dlabs.com>
To: linux-kernel@vger.kernel.org
Subject: Machine not freeing Cached Memory?
Message-ID: <20020426113459.GH9968@3dlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There,

I'm having some VM problems. I wonder if anybody can help.

I've got a box here that currently reports....

holly:~/linux-2.4.14# free -tm
             total       used       free     shared    buffers     cached
Mem:          3021       1041       1980          0          4        885
-/+ buffers/cache:        151       2870
Swap:         3905        126       3779
Total:        6927       1167       5759
	     
As you can see, it's a 3G physical RAM box. Currently it's sitting there
with 885MB of Memory labeled as Cache, but if I run a process which requires
lots of memory, then the system seems to prefer swapping, rather than
freeing up the cache memory. For example...

             total       used       free     shared    buffers     cached
Mem:          3021       3019          2          0          1        845
-/+ buffers/cache:       2172        849
Swap:         3905        488       3417
Total:        6927       3508       3419
	     
Yes, some 40MB of cache gets freed, but it's mainly (300MB) of swap that
gets used. This tends to slow down processes before they need to because the
machine is thrashing  (and I mean really hammering) swap.

Anyone got any ideas?

Kernel is 2.4.14, and it's a debian woody installation.

Is a later version of 2.4 likly to help me here?

Cheers

Paul
-- 
Paul Sargent
mailto: Paul.Sargent@3Dlabs.com
