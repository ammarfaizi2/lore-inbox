Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSK1RVK>; Thu, 28 Nov 2002 12:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266157AbSK1RVJ>; Thu, 28 Nov 2002 12:21:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:53993 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265998AbSK1RVJ>;
	Thu, 28 Nov 2002 12:21:09 -0500
Date: Thu, 28 Nov 2002 17:26:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: odd ext3 problem with 2.5.50
Message-ID: <20021128172619.GA930@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erm. Whats going on here ?

(davej@tetrachloride:davej)$ ls .viminfo
ls: .viminfo: No such file or directory
(davej@tetrachloride:davej)$ touch .viminfo
touch: creating `.viminfo': File exists
(davej@tetrachloride:davej)$ 

strace of the touch..

brk(0x8050000)                          = 0x8050000
open(".viminfo", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) = -1 EEXIST (File exists)
utime(".viminfo", NULL)                 = -1 ENOENT (No such file or directory)
write(2, "touch: ", 7touch: )                  = 7
write(2, "creating `.viminfo\'", 19creating `.viminfo')    = 19
write(2, ": File exists", 13: File exists)           = 13
write(2, "\n", 1
)                       = 1
_exit(1)                                = ?


strace of the ls...

lstat64(".viminfo", 0x80580ac)          = -1 ENOENT (No such file or directory)
write(2, "ls: ", 4ls: )                     = 4


.viminfo is actually there, and does show up with bash's tab completion.
Weird.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
