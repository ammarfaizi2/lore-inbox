Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268356AbTBSLKB>; Wed, 19 Feb 2003 06:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268357AbTBSLKB>; Wed, 19 Feb 2003 06:10:01 -0500
Received: from [66.70.28.20] ([66.70.28.20]:29701 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S268356AbTBSLJ7>; Wed, 19 Feb 2003 06:09:59 -0500
Date: Wed, 19 Feb 2003 12:21:11 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: About /etc/mtab and /proc/mounts
Message-ID: <20030219112111.GD130@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I would like to know if adding the bits of information that
/etc/mtab has and /proc/mount doesn't needs a lot of work. The
problem here is that /etc/mtab, although traditional, does not make
sense in systems where /etc is mounted read-only. Usually, the only
reason for mounting it read-write is the mtab...

    Well, nowadays is very usual to see systems where /etc/mtab is
just a symlink to /proc/mounts, but then you lose some information.
That is, you can live without that info, but if it can be easily
added I think that it would worth the effort.

    Unfortunately, some of this information is obtained from
/etc/fstab but IMHO the kernel has that info too in some table, I
suppose...

    Well, if someone familiar with this part of the kernel gives me
the information I think I can write the code for the 'extra'
information ;))

    I give an example of this extra information:

    in /etc/mtab we have:
        pts /dev/pts devpts rw,gid=5,mode=620 0 0

    in /proc/mounts we have:
        pts /dev/pts devpts rw 0 0

    Other filesystems, as tmpfs, has the size information, for
example, etc...

    Thanks in advance.
    Raúl
