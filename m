Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUKBRXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUKBRXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbUKBRNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:13:45 -0500
Received: from fep18.inet.fi ([194.251.242.243]:12521 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S261536AbUKBRIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:08:32 -0500
Date: Tue, 2 Nov 2004 19:08:30 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9: VmLib:  4294948464 kB
Message-ID: <20041102170830.GA30536@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Linux 2.6.9 with these patches which might affect output of
/proc/*/status:
[PATCH] statm: __vm_stat_accounting
[PATCH] statm: shared = rss - anon_rss
[PATCH] statm: fix negative data
[PATCH] procfs: fix task_mmu.c text size reporting
[PATCH] report per-process pagetable usage
exec-shield-nx-2.6.9-A2

$ cat /proc/27443/status
Name:   slrn
State:  S (sleeping)
SleepAVG:       88%
Tgid:   27443
Pid:    27443
PPid:   27442
TracerPid:      0
Uid:    500     500     500     500
Gid:    500     500     500     500
FDSize: 256
Groups: 37 500 509 546 
VmSize:    31552 kB
VmLck:         0 kB
VmRSS:     27540 kB
VmData:    26676 kB
VmStk:        48 kB
VmExe:       344 kB
VmLib:  4294948464 kB
VmPTE:        48 kB
StaBrk: 080c1000 kB
Brk:    09a92000 kB
StaStk: bfffeae0 kB
ExecLim:        b8000000
Threads:        1
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 0000000000201000
SigCgt: 0000000008184083
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000

$ cat /proc/27443/maps
0052f000-00531000 r-xp 00000000 16:46 705185     /lib/libdl-2.3.3.so
00531000-00532000 r-xp 00001000 16:46 705185     /lib/libdl-2.3.3.so
00532000-00533000 rwxp 00002000 16:46 705185     /lib/libdl-2.3.3.so
0061f000-0067e000 r-xp 00000000 16:03 441137     /usr/lib/libslang-utf8.so.1.4.9
0067e000-00683000 rwxp 0005f000 16:03 441137     /usr/lib/libslang-utf8.so.1.4.9
00683000-0069a000 rwxp 00683000 00:00 0 
00a5b000-00a6a000 r-xp 00000000 16:46 705218     /lib/libresolv-2.3.3.so
00a6a000-00a6b000 ---p 0000f000 16:46 705218     /lib/libresolv-2.3.3.so
00a6b000-00a6c000 r-xp 0000f000 16:46 705218     /lib/libresolv-2.3.3.so
00a6c000-00a6d000 rwxp 00010000 16:46 705218     /lib/libresolv-2.3.3.so
00a6d000-00a6f000 rwxp 00a6d000 00:00 0 
05a4b000-05a60000 r-xp 00000000 16:46 705113     /lib/ld-2.3.3.so
05a60000-05a61000 r-xp 00014000 16:46 705113     /lib/ld-2.3.3.so
05a61000-05a62000 rwxp 00015000 16:46 705113     /lib/ld-2.3.3.so
05a64000-05b85000 r-xp 00000000 16:46 705184     /lib/tls/libc-2.3.3.so
05b85000-05b87000 r-xp 00120000 16:46 705184     /lib/tls/libc-2.3.3.so
05b87000-05b89000 rwxp 00122000 16:46 705184     /lib/tls/libc-2.3.3.so
05b89000-05b8b000 rwxp 05b89000 00:00 0 
05b8d000-05bae000 r-xp 00000000 16:46 705187     /lib/tls/libm-2.3.3.so
05bae000-05baf000 r-xp 00020000 16:46 705187     /lib/tls/libm-2.3.3.so
05baf000-05bb0000 rwxp 00021000 16:46 705187     /lib/tls/libm-2.3.3.so
08048000-0809e000 r-xp 00000000 16:03 22162      /usr/local/bin/slrn-0.9.8.1
0809e000-080a3000 rwxp 00055000 16:03 22162      /usr/local/bin/slrn-0.9.8.1
080a3000-09a92000 rwxp 080a3000 00:00 0 
b7d3a000-b7d3c000 r-xp 00000000 16:03 13191      /usr/lib/gconv/ISO8859-15.so
b7d3c000-b7d3e000 rwxp 00001000 16:03 13191      /usr/lib/gconv/ISO8859-15.so
b7d3e000-b7d44000 r-xs 00000000 16:03 18788      /usr/lib/gconv/gconv-modules.cache
b7d44000-b7d48000 r-xp 00000000 16:46 385711     /lib/libnss_dns-2.3.3.so
b7d48000-b7d49000 r-xp 00003000 16:46 385711     /lib/libnss_dns-2.3.3.so
b7d49000-b7d4a000 rwxp 00004000 16:46 385711     /lib/libnss_dns-2.3.3.so
b7d4a000-b7d53000 r-xp 00000000 16:46 398835     /lib/libnss_files-2.3.3.so
b7d53000-b7d54000 r-xp 00008000 16:46 398835     /lib/libnss_files-2.3.3.so
b7d54000-b7d55000 rwxp 00009000 16:46 398835     /lib/libnss_files-2.3.3.so
b7d75000-b7d76000 rwxp b7d75000 00:00 0 
b7d76000-b7d77000 r-xp 00f9a000 16:03 125645     /usr/lib/locale/locale-archive
b7d77000-b7da9000 r-xp 00f51000 16:03 125645     /usr/lib/locale/locale-archive
b7da9000-b7daa000 r-xp 00ead000 16:03 125645     /usr/lib/locale/locale-archive
b7daa000-b7db1000 r-xp 00e9b000 16:03 125645     /usr/lib/locale/locale-archive
b7db1000-b7dde000 r-xp 00e57000 16:03 125645     /usr/lib/locale/locale-archive
b7dde000-b7fde000 r-xp 00000000 16:03 125645     /usr/lib/locale/locale-archive
b7fde000-b7fe0000 rwxp b7fde000 00:00 0 
bfff4000-c0000000 rw-p bfff4000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 

$ cat /proc/27443/statm
7888 6885 290 86 0 6681 0

$ cat /proc/27443/stat
27443 (slrn) S 27442 27442 27440 34826 27442 0 14282 0 191 0 18606 2295 0 0 16 0 1 0 14295650 32309248 6885 4294967295 134512640 134863112 3221220064 3221211132 94680994 0 0 2101248 135807107 3222662067 0 0 17 0 0 0

$ size /usr/local/bin/slrn-0.9.8.1 
   text    data     bss     dec     hex filename
 350167   16636  123784  490587   77c5b /usr/local/bin/slrn-0.9.8.1

now the code in fs/proc/task_mmu.c:task_mem() is:

  text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
  lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;

and PAGE_SHIFT is 12 for me.

-- 
