Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281221AbRKRAD7>; Sat, 17 Nov 2001 19:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281832AbRKRADt>; Sat, 17 Nov 2001 19:03:49 -0500
Received: from mailin5.bigpond.com ([139.134.6.78]:21696 "EHLO
	mailin5.bigpond.com") by vger.kernel.org with ESMTP
	id <S281221AbRKRADp>; Sat, 17 Nov 2001 19:03:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: hari <harisri@bigpond.com>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Linux-2.4.15-pre5 - probably something wrong with /proc/cpuinfo.
Date: Sun, 18 Nov 2001 11:06:20 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111171055290.11475-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111171055290.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011118000346Z281221-17408+15574@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001 15:56, Alexander Viro wrote:
> I can't reproduce it here.  Which version of bash it is?
Hello,

It is: GNU bash, version 2.04.0(1)-release

On a related note redirecting the contents of /proc/cpuinfo using 'cat' 
command to a file on my home directory and providing that as an input fixes 
the problem. For eg:

#/bin/bash
# set and adjust the CMOS clock
if test "$HWCLOCK_ACCESS" != "no" ; then
echo -n Setting up the CMOS clock
CLOCKCMD=hwclock
cat /proc/cpuinfo > /root/2.4.15-pre5
while read line; do
        case "$line" in
                *MTX\ Plus*) CLOCKCMD="hwclock --mtxplus --directisa" ;;
                *PReP\ Dual\ MTX*) CLOCKCMD="hwclock --mtxplus --directisa" ;;
        esac
done < /root/2.4.15-pre5
fi

Thanks.
-- 
Hari.
harisri@bigpond.com

