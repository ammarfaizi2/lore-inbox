Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281758AbRKQOnD>; Sat, 17 Nov 2001 09:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281759AbRKQOmn>; Sat, 17 Nov 2001 09:42:43 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:56027 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S281758AbRKQOmf>; Sat, 17 Nov 2001 09:42:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: hari <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.15-pre5 - probably something wrong with /proc/cpuinfo.
Date: Sun, 18 Nov 2001 01:45:29 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011117144242Z281758-17408+15441@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following shell script (extracted from SuSE 7.1 /etc/rc.d/boot) would 
execute fine on Linux-2.4.14, Linux-2.4.15-pre3 etc.. but not on 
Linux-2.4.15-pre5 (AMD Athlon Computer). Couldn't check it on 
Linux-2.4.15-pre4 as it would not compile successfully.

#!/bin/bash
# set and adjust the CMOS clock
if test "$HWCLOCK_ACCESS" != "no" ; then
echo -n Setting up the CMOS clock
CLOCKCMD=hwclock
while read line; do
        case "$line" in
                *MTX\ Plus*) CLOCKCMD="hwclock --mtxplus --directisa" ;;
                *PReP\ Dual\ MTX*) CLOCKCMD="hwclock --mtxplus --directisa" ;;
        esac
done < /proc/cpuinfo
fi

May someone be kind enough to let me know where the problem could be?
-- 
Thank you,
harisri@bigpond.com
