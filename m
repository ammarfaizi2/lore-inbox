Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266053AbSKLH5N>; Tue, 12 Nov 2002 02:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKLH5N>; Tue, 12 Nov 2002 02:57:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:17138 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S266053AbSKLH5M>;
	Tue, 12 Nov 2002 02:57:12 -0500
Message-ID: <3DD0B5DC.BE90D497@mvista.com>
Date: Tue, 12 Nov 2002 00:03:40 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH ] POSIX clocks & timers take 10 (NOT HIGH RES)
References: <Pine.LNX.4.33L2.0211111539030.23954-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Hi George,
> 
> I have a couple of small comments on the latest POSIX interface
> patch (take 10 -- NOT HIGH RES).
> 
> 1.  arch/i386/kernel/entry.S uses nr_syscalls and the patch
> removes NR_syscalls from include/asm-i386/sys.h, but
> user-mode-linux needs/uses NR_syscalls.  However, I see why you
> removed it from sys.h:  it's basically a dead file.
> And it looks like include/linux/sys.h shouldn't have that
> #define in it (should be per arch).

The best place for this define, if it is needed at all, is
in unistd.h.  It seems really silly to have to modify so
many files to add a system call.  If it were not so late in
the game, I would offer up a single file system call thing,
but after 260 calls, well, maybe I will even so, but AFTER
the freeze since it will not add any new features.
> 
> 2.  again in arch/i386/kernel/entry.S:  the added syscall number
> /*comments*/ are off by 1.

Oops!  Just a comment though :)
 

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
