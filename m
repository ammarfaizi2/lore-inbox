Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSGVHgg>; Mon, 22 Jul 2002 03:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSGVHgg>; Mon, 22 Jul 2002 03:36:36 -0400
Received: from mikrolahti.fi ([195.237.35.128]:10501 "EHLO pleco.mikrolahti.fi")
	by vger.kernel.org with ESMTP id <S316573AbSGVHgf>;
	Mon, 22 Jul 2002 03:36:35 -0400
Date: Mon, 22 Jul 2002 10:39:41 +0300
To: linux-kernel@vger.kernel.org
Subject: still troubles with an Alpha-kernel
Message-ID: <20020722073941.GA10979@pleco.mikrolahti.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: samppa@pleco.mikrolahti.fi (Sami Louko)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday i posted a message about troubles compiling 2.2.20RAID or
2.4.18/2.4.19rc1/2.4.19rc1aa2 kernel for an Alpha PC164LX.

I got a tip to use gcc-3.1 but i didn't find it from debian-trees,
so i used the latest 3.0 (gcc-3.0.4) compiler, and tried again.
2.2.20 w/RAID doesn't compile, so doesn't aa2-patched 2.4.19rc1.
I tried 2.4.18 using gcc-3.0.4 and it did compile and almost work.
I was able to make raid-1 /dev/md0, mke2fs -j for it and mount it
without any errors, but when i tried to use it, got crash.

Then i downloaded the latest 2.4-patch, 2.4.19-rc3 and compiled it
again. That went successfully and again it does allow me to create
raid, make filesystem and mount it, but using will crash.
Couple of minutes ago, i make very interesting notification.
This may be a reason, but how can it be solved:

pleco:/# free  
             total       used       free     shared    buffers     cached
Mem:        514112      95408     418704          0       1976      27864
pleco:/# ls -l /proc/kcore 
-r--------    1 root     root     4380869902336 heinä  22 09:59 /proc/kcore
pleco:/# ls -lh /proc/kcore 
-r--------    1 root     root         4.0T heinä  22 10:38 /proc/kcore

The core shows a bit huge :-/ Four terabytes... huh.
What's up next?!

Please, CC directly to me: samppa@mikrolahti.com

--sl
