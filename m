Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263389AbTC2HNS>; Sat, 29 Mar 2003 02:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbTC2HNS>; Sat, 29 Mar 2003 02:13:18 -0500
Received: from host130-255.pool62211.interbusiness.it ([62.211.255.130]:55172
	"EHLO penny.tippete.net") by vger.kernel.org with ESMTP
	id <S263389AbTC2HNR>; Sat, 29 Mar 2003 02:13:17 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: / listed twice in /proc/mounts
Reply-To: Pierfrancesco Caci <pf@tippete.net>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: Sat, 29 Mar 2003 08:24:31 +0100
In-Reply-To: <Pine.LNX.4.21.0303272110420.16348-100000@ppg_penguin> (Ken
 Moffat's message of "Thu, 27 Mar 2003 21:16:01 +0000 (GMT)")
Message-ID: <87smt6ws7k.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <Pine.LNX.4.21.0303272110420.16348-100000@ppg_penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Ken" == Ken Moffat <ken@kenmoffat.uklinux.net> writes:

    > On 27 Mar 2003, Christian Laursen wrote:
    >> The other day, I upgraded the components of a software package
    >> that I maintain, including updating the kernel from 2.4.18 to
    >> 2.4.20.
    >> 
    >> I noticed something strange: / is now listed twice in /proc/mounts
    >> like this
    >> 
    >> rootfs / rootfs rw 0 0
    >> /dev/root / ext2 rw 0 0
    >> 
    >> It confused one of my scripts, so I had to implement a quick workaround.
    >> 
    >> Is this a feature or a bug?
    >> 

    >  Is your /etc/mtab a symlink to /proc/mounts ?  That is generally
    > thought not to be a good idea.


I have the same "double root":

# cat /proc/mounts 
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
[...]

# ls -las /dev/root
   0 lr-xr-xr-x    1 root     root            4 Mar 22 15:07 /dev/root -> md/0

# ls -als /etc/mtab
   1 -rw-r--r--    1 root     root          345 Mar 23 15:55 /etc/mtab

# cat /etc/mtab
/dev/md0 / ext3 rw 0 0
[...]


could it be a 'feature' of devfs, or maybe of raid devices ?

kernel version is 2.4.21-pre5-ac3

Pf

-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.21-pre5-ac3 #1 Sat Mar 15 22:04:18 CET 2003 i686 GNU/Linux

