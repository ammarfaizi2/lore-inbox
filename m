Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129424AbQJ1OYx>; Sat, 28 Oct 2000 10:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129678AbQJ1OYn>; Sat, 28 Oct 2000 10:24:43 -0400
Received: from z211-19-80-152.dialup.wakwak.ne.jp ([211.19.80.152]:54515 "EHLO
	220fx.luky.org") by vger.kernel.org with ESMTP id <S129424AbQJ1OYb>;
	Sat, 28 Oct 2000 10:24:31 -0400
To: axboe@suse.de
Cc: shibata@luky.org, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001028000448.D3919@suse.de>
In-Reply-To: <20001024162112.A520@suse.de>
	<20001028141056T.shibata@luky.org>
	<20001028000448.D3919@suse.de>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001028232703S.shibata@luky.org>
Date: Sat, 28 Oct 2000 23:27:03 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Axboe

> > But I could not mkudf nor mkext2fs to my ATAPI 9.4GB new DVD-RAM drive.
> 
> What do you mean? What happened? strace of mke2fs of mkudf would
> be nice to have.

My system said it is not permited because it is read only.

execve("/sbin/mke2fs", ["/sbin/mke2fs", "/dev/hdc"], [/* 19 vars */]) = 0
brk(0)                                  = 0x804dd80
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=19214, ...}) = 0
old_mmap(NULL, 19214, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libext2fs.so.2", O_RDONLY)   = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=83284, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2146\0"..., 4096) = 4096
old_mmap(NULL, 71696, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40019000
mprotect(0x4002a000, 2064, PROT_NONE)   = 0
old_mmap(0x4002a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x10000) = 0x4002a000
close(3)                                = 0
open("/lib/libcom_err.so.2", O_RDONLY)  = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=8057, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\230\t\0"..., 4096) = 4096


And  /proc/ide/hdc/media says "cdrom". Is it OK?


Best Regards,

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata
0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
   ~    http://his.luky.org/ last update:2000.3.12
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
