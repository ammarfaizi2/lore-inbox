Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbRDCM7m>; Tue, 3 Apr 2001 08:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDCM7c>; Tue, 3 Apr 2001 08:59:32 -0400
Received: from [166.70.28.69] ([166.70.28.69]:59722 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S131474AbRDCM71>;
	Tue, 3 Apr 2001 08:59:27 -0400
To: Fu-hau Hsu <fhsu@ic.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory maps
In-Reply-To: <Pine.GSO.4.21.0104021611050.24682-100000@sparky.ic.sunysb.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2001 06:57:22 -0600
In-Reply-To: Fu-hau Hsu's message of "Mon, 2 Apr 2001 16:25:11 -0400 (EDT)"
Message-ID: <m1r8zaw37x.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fu-hau Hsu <fhsu@ic.sunysb.edu> writes:

> Dear freinds:
> 
>  I have following questions about memory maps. I appreciate any
> suggestion.
> 
>  Q. (1)When a process is running, how can I get the range of data, stack,
>        and code segments, say the stack segment is from address 0x..... to
>        0x..... so do data segments and code segments?
>        PS: Under ELF format, there are several seperaed code and data
>            segments, but the process control table has only one pair of
>            pointers for each, Are the pointers still useful?


Sort of, you can currently confuse the elf loader with multiple bss segments.
The stack, and the brk pointer are still used. 

>     (2) /proc/*/maps will show us those info, but how does it get these
>        info? 

This is a reflection of what areas of memory the kernel sees.  In principle
every thing is now handled by mmap, and this /proc/maps is a reflection
of that.  See under the files in mm/*.c

Eric
