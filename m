Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbTDGDHz (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTDGDHz (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:07:55 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:6419
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263210AbTDGDHq 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 23:07:46 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1049685316.894.5.camel@localhost>
References: <20030406183234.1e8abd7f.akpm@digeo.com>
	 <Pine.LNX.4.44.0304062200570.1604-100000@localhost.localdomain>
	 <20030406182815.65dd9304.akpm@digeo.com> <1049685316.894.5.camel@localhost>
Content-Type: multipart/mixed; boundary="=-0L8Tu7KdPZBo9v8B9zMc"
Organization: 
Message-Id: <1049685554.894.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 23:19:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0L8Tu7KdPZBo9v8B9zMc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-04-06 at 23:15, Robert Love wrote:
> On Sun, 2003-04-06 at 21:28, Andrew Morton wrote:
> 
> > I am now very confused.
> 
> It is a battle tactic.

Here is the the strace of `rpm -q glibc' without disabling NPTL.  It
fails.

	Robert Love

--=-0L8Tu7KdPZBo9v8B9zMc
Content-Disposition: attachment; filename=rpm-nptl.log
Content-Type: text/plain; name=rpm-nptl.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

1271  execve("/bin/rpm", ["rpm", "-q", "glibc"], [/* 29 vars */]) = 0
1271  uname({sys="Linux", node="phantasy", ...}) = 0
1271  brk(0)                            = 0x8069000
1271  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
1271  open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/etc/ld.so.cache", O_RDONLY) = 3
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=36231, ...}) = 0
1271  old_mmap(NULL, 36231, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
1271  close(3)                          = 0
1271  open("/usr/lib/librpm-4.2.so", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\233"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=298016, ...}) = 0
1271  old_mmap(NULL, 344020, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40020000
1271  old_mmap(0x40066000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x46000) = 0x40066000
1271  old_mmap(0x40069000, 45012, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40069000
1271  close(3)                          = 0
1271  open("/usr/lib/librpmdb-4.2.so", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300|\1"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=898968, ...}) = 0
1271  old_mmap(NULL, 911744, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40074000
1271  old_mmap(0x4014d000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd8000) = 0x4014d000
1271  old_mmap(0x40151000, 6528, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40151000
1271  close(3)                          = 0
1271  open("/usr/lib/librpmio-4.2.so", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\300\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=349912, ...}) = 0
1271  old_mmap(NULL, 384636, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40153000
1271  old_mmap(0x401a2000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x4f000) = 0x401a2000
1271  old_mmap(0x401a9000, 32380, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401a9000
1271  close(3)                          = 0
1271  open("/usr/lib/libpopt.so.0", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\24\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=26896, ...}) = 0
1271  old_mmap(NULL, 29872, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401b1000
1271  old_mmap(0x401b8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x6000) = 0x401b8000
1271  close(3)                          = 0
1271  open("/usr/lib/libelf.so.1", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\214\33"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=62272, ...}) = 0
1271  old_mmap(NULL, 65164, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401b9000
1271  old_mmap(0x401c8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe000) = 0x401c8000
1271  close(3)                          = 0
1271  open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320>\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=79744, ...}) = 0
1271  old_mmap(NULL, 50040, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401c9000
1271  old_mmap(0x401d3000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa000) = 0x401d3000
1271  old_mmap(0x401d4000, 4984, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401d4000
1271  close(3)                          = 0
1271  open("/lib/librt.so.1", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\33"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=37552, ...}) = 0
1271  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401d6000
1271  old_mmap(NULL, 73720, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401d7000
1271  old_mmap(0x401dd000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x401dd000
1271  old_mmap(0x401df000, 40952, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401df000
1271  close(3)                          = 0
1271  open("/usr/lib/libbz2.so.1", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\22\0\000"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=62128, ...}) = 0
1271  old_mmap(NULL, 61008, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401e9000
1271  old_mmap(0x401f7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe000) = 0x401f7000
1271  close(3)                          = 0
1271  open("/lib/tls/libc.so.6", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`V\1B4\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=1531064, ...}) = 0
1271  old_mmap(0x42000000, 1257224, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
1271  old_mmap(0x4212e000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12e000) = 0x4212e000
1271  old_mmap(0x42131000, 7944, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42131000
1271  close(3)                          = 0
1271  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401f8000
1271  mprotect(0x40153000, 323584, PROT_READ|PROT_WRITE) = 0
1271  mprotect(0x40153000, 323584, PROT_READ|PROT_EXEC) = 0
1271  set_thread_area({entry_number:-1 -> 6, base_addr:0x401f8500, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
1271  munmap(0x40017000, 36231)         = 0
1271  set_tid_address(0x401f8548)       = 1271
1271  rt_sigaction(SIGRTMIN, {0x401cce30, [], SA_RESTORER, 0x401d2618}, NULL, 8) = 0
1271  rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
1271  getrlimit(0x3, 0xbffff944)        = 0
1271  brk(0)                            = 0x8069000
1271  brk(0x806a000)                    = 0x806a000
1271  brk(0)                            = 0x806a000
1271  open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=30313968, ...}) = 0
1271  mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0x401f9000
1271  close(3)                          = 0
1271  open("/usr/lib/rpm/rpmpopt-4.2", O_RDONLY|O_LARGEFILE) = 3
1271  _llseek(3, 0, [20870], SEEK_END)  = 0
1271  _llseek(3, 0, [0], SEEK_SET)      = 0
1271  read(3, "#/*! \\page config_rpmpopt Defaul"..., 20870) = 20870
1271  close(3)                          = 0
1271  brk(0)                            = 0x806a000
1271  brk(0x806b000)                    = 0x806b000
1271  brk(0)                            = 0x806b000
1271  brk(0x806c000)                    = 0x806c000
1271  brk(0)                            = 0x806c000
1271  brk(0x806d000)                    = 0x806d000
1271  open("/etc/popt", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  getuid32()                        = 0
1271  geteuid32()                       = 0
1271  open("/home/rml/.popt", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  execve("/usr/lib/rpm/rpmq", ["/usr/lib/rpm/rpmq", "-q", "glibc"], [/* 29 vars */]) = 0
1271  uname({sys="Linux", node="phantasy", ...}) = 0
1271  brk(0)                            = 0x804b000
1271  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
1271  open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/etc/ld.so.cache", O_RDONLY) = 3
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=36231, ...}) = 0
1271  old_mmap(NULL, 36231, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
1271  close(3)                          = 0
1271  open("/usr/lib/librpmbuild-4.2.so", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0Q\0\000"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=142268, ...}) = 0
1271  old_mmap(NULL, 216060, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40020000
1271  old_mmap(0x40041000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x21000) = 0x40041000
1271  old_mmap(0x40043000, 72700, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40043000
1271  close(3)                          = 0
1271  open("/usr/lib/librpm-4.2.so", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\233"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=298016, ...}) = 0
1271  old_mmap(NULL, 344020, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40055000
1271  old_mmap(0x4009b000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x46000) = 0x4009b000
1271  old_mmap(0x4009e000, 45012, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4009e000
1271  close(3)                          = 0
1271  open("/usr/lib/librpmdb-4.2.so", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300|\1"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=898968, ...}) = 0
1271  old_mmap(NULL, 911744, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400a9000
1271  old_mmap(0x40182000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd8000) = 0x40182000
1271  old_mmap(0x40186000, 6528, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40186000
1271  close(3)                          = 0
1271  open("/usr/lib/librpmio-4.2.so", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\300\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=349912, ...}) = 0
1271  old_mmap(NULL, 384636, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40188000
1271  old_mmap(0x401d7000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x4f000) = 0x401d7000
1271  old_mmap(0x401de000, 32380, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x401de000
1271  close(3)                          = 0
1271  open("/usr/lib/libpopt.so.0", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\24\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=26896, ...}) = 0
1271  old_mmap(NULL, 29872, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401e6000
1271  old_mmap(0x401ed000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x6000) = 0x401ed000
1271  close(3)                          = 0
1271  open("/usr/lib/libelf.so.1", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\214\33"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=62272, ...}) = 0
1271  old_mmap(NULL, 65164, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401ee000
1271  old_mmap(0x401fd000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe000) = 0x401fd000
1271  close(3)                          = 0
1271  open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320>\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=79744, ...}) = 0
1271  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401fe000
1271  old_mmap(NULL, 50040, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x401ff000
1271  old_mmap(0x40209000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa000) = 0x40209000
1271  old_mmap(0x4020a000, 4984, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4020a000
1271  close(3)                          = 0
1271  open("/lib/librt.so.1", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\33"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=37552, ...}) = 0
1271  old_mmap(NULL, 73720, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4020c000
1271  old_mmap(0x40212000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x40212000
1271  old_mmap(0x40214000, 40952, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40214000
1271  close(3)                          = 0
1271  open("/usr/lib/libbz2.so.1", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\22\0\000"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=62128, ...}) = 0
1271  old_mmap(NULL, 61008, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4021e000
1271  old_mmap(0x4022c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe000) = 0x4022c000
1271  close(3)                          = 0
1271  open("/lib/tls/libc.so.6", O_RDONLY) = 3
1271  read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`V\1B4\0"..., 512) = 512
1271  fstat64(3, {st_mode=S_IFREG|0755, st_size=1531064, ...}) = 0
1271  old_mmap(0x42000000, 1257224, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
1271  old_mmap(0x4212e000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12e000) = 0x4212e000
1271  old_mmap(0x42131000, 7944, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42131000
1271  close(3)                          = 0
1271  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4022d000
1271  mprotect(0x40188000, 323584, PROT_READ|PROT_WRITE) = 0
1271  mprotect(0x40188000, 323584, PROT_READ|PROT_EXEC) = 0
1271  set_thread_area({entry_number:-1 -> 6, base_addr:0x4022d8c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
1271  munmap(0x40017000, 36231)         = 0
1271  set_tid_address(0x4022d908)       = 1271
1271  rt_sigaction(SIGRTMIN, {0x40202e30, [], SA_RESTORER, 0x40208618}, NULL, 8) = 0
1271  rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
1271  getrlimit(0x3, 0xbffff924)        = 0
1271  brk(0)                            = 0x804b000
1271  brk(0x804c000)                    = 0x804c000
1271  brk(0)                            = 0x804c000
1271  open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=30313968, ...}) = 0
1271  mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4022e000
1271  close(3)                          = 0
1271  open("/usr/lib/rpm/rpmpopt-4.2", O_RDONLY|O_LARGEFILE) = 3
1271  _llseek(3, 0, [20870], SEEK_END)  = 0
1271  _llseek(3, 0, [0], SEEK_SET)      = 0
1271  read(3, "#/*! \\page config_rpmpopt Defaul"..., 20870) = 20870
1271  close(3)                          = 0
1271  brk(0)                            = 0x804c000
1271  brk(0x804d000)                    = 0x804d000
1271  brk(0)                            = 0x804d000
1271  brk(0x804e000)                    = 0x804e000
1271  open("/etc/popt", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  getuid32()                        = 0
1271  geteuid32()                       = 0
1271  open("/home/rml/.popt", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/etc/rpm/platform", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  uname({sys="Linux", node="phantasy", ...}) = 0
1271  rt_sigaction(SIGILL, {0x400887e0, [ILL], SA_RESTORER|SA_RESTART, 0x420275c8}, {SIG_DFL}, 8) = 0
1271  rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
1271  open("/usr/lib/rpm/rpmrc", O_RDONLY|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  gettimeofday({1049685359, 231411}, NULL) = 0
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=10193, ...}) = 0
1271  mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 231794}, NULL) = 0
1271  read(3, "#/*! \\page config_rpmrc Default "..., 8192) = 8192
1271  gettimeofday({1049685359, 231926}, NULL) = 0
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 232069}, NULL) = 0
1271  read(3, "sv4.2\n\nos_compat: FreeMiNT: mint"..., 8192) = 2001
1271  gettimeofday({1049685359, 232150}, NULL) = 0
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 232278}, NULL) = 0
1271  read(3, "", 6191)                 = 0
1271  gettimeofday({1049685359, 232346}, NULL) = 0
1271  gettimeofday({1049685359, 232414}, NULL) = 0
1271  close(3)                          = 0
1271  gettimeofday({1049685359, 232489}, NULL) = 0
1271  gettimeofday({1049685359, 232549}, NULL) = 0
1271  gettimeofday({1049685359, 232583}, NULL) = 0
1271  munmap(0x40017000, 8192)          = 0
1271  brk(0)                            = 0x804e000
1271  brk(0x804f000)                    = 0x804f000
1271  brk(0)                            = 0x804f000
1271  brk(0x8050000)                    = 0x8050000
1271  brk(0)                            = 0x8050000
1271  brk(0x8051000)                    = 0x8051000
1271  brk(0)                            = 0x8051000
1271  brk(0x8052000)                    = 0x8052000
1271  brk(0)                            = 0x8052000
1271  brk(0x8053000)                    = 0x8053000
1271  open("/usr/lib/rpm/redhat/rpmrc", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/etc/rpmrc", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/home/rml/.rpmrc", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/usr/lib/rpm/macros", O_RDONLY|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  gettimeofday({1049685359, 234477}, NULL) = 0
1271  mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 234714}, NULL) = 0
1271  read(3, "#/*! \\page config_macros Default"..., 8192) = 8192
1271  gettimeofday({1049685359, 234842}, NULL) = 0
1271  brk(0)                            = 0x8053000
1271  brk(0x8054000)                    = 0x8054000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 236325}, NULL) = 0
1271  read(3, "ity with legacy\n#\tversions of rp"..., 8192) = 8192
1271  gettimeofday({1049685359, 236423}, NULL) = 0
1271  brk(0)                            = 0x8054000
1271  brk(0x8055000)                    = 0x8055000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 237874}, NULL) = 0
1271  read(3, "================================"..., 8192) = 8192
1271  gettimeofday({1049685359, 237971}, NULL) = 0
1271  brk(0)                            = 0x8055000
1271  brk(0x8056000)                    = 0x8056000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 240345}, NULL) = 0
1271  read(3, "\\\n  RPM_DOC_DIR=\\\"%{_docdir}\\\"\\\n"..., 8192) = 8192
1271  gettimeofday({1049685359, 240445}, NULL) = 0
1271  brk(0)                            = 0x8056000
1271  brk(0x8057000)                    = 0x8057000
1271  brk(0)                            = 0x8057000
1271  brk(0x8058000)                    = 0x8058000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 246284}, NULL) = 0
1271  read(3, "LAGS:-%{-s:-s}}\"  ; export LDFLA"..., 8192) = 3503
1271  gettimeofday({1049685359, 246369}, NULL) = 0
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 246496}, NULL) = 0
1271  read(3, "", 4689)                 = 0
1271  gettimeofday({1049685359, 246575}, NULL) = 0
1271  brk(0)                            = 0x8058000
1271  brk(0x8059000)                    = 0x8059000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 247422}, NULL) = 0
1271  read(3, "", 8192)                 = 0
1271  gettimeofday({1049685359, 247489}, NULL) = 0
1271  gettimeofday({1049685359, 247546}, NULL) = 0
1271  close(3)                          = 0
1271  gettimeofday({1049685359, 247616}, NULL) = 0
1271  gettimeofday({1049685359, 247654}, NULL) = 0
1271  gettimeofday({1049685359, 247687}, NULL) = 0
1271  munmap(0x40017000, 8192)          = 0
1271  open("/usr/lib/rpm/i686-linux/macros", O_RDONLY|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  gettimeofday({1049685359, 247883}, NULL) = 0
1271  mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 248071}, NULL) = 0
1271  read(3, "# Per-platform rpm configuration"..., 8192) = 2429
1271  gettimeofday({1049685359, 248165}, NULL) = 0
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 248329}, NULL) = 0
1271  read(3, "", 5763)                 = 0
1271  gettimeofday({1049685359, 248398}, NULL) = 0
1271  brk(0)                            = 0x8059000
1271  brk(0x805a000)                    = 0x805a000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 249684}, NULL) = 0
1271  read(3, "", 8192)                 = 0
1271  gettimeofday({1049685359, 249751}, NULL) = 0
1271  gettimeofday({1049685359, 249789}, NULL) = 0
1271  close(3)                          = 0
1271  gettimeofday({1049685359, 249857}, NULL) = 0
1271  gettimeofday({1049685359, 249893}, NULL) = 0
1271  gettimeofday({1049685359, 249927}, NULL) = 0
1271  munmap(0x40017000, 8192)          = 0
1271  open("/etc/rpm/macros.specspo", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/etc/rpm/macros.prelink", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/etc/rpm/macros.solve", O_RDONLY|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  gettimeofday({1049685359, 250203}, NULL) = 0
1271  mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 250386}, NULL) = 0
1271  read(3, "#\tThe path to the dependency uni"..., 8192) = 768
1271  gettimeofday({1049685359, 250473}, NULL) = 0
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 250616}, NULL) = 0
1271  read(3, "", 7424)                 = 0
1271  gettimeofday({1049685359, 250683}, NULL) = 0
1271  select(4, [3], NULL, NULL, {1, 0}) = 1 (in [3], left {1, 0})
1271  gettimeofday({1049685359, 251131}, NULL) = 0
1271  read(3, "", 8192)                 = 0
1271  gettimeofday({1049685359, 251198}, NULL) = 0
1271  gettimeofday({1049685359, 251236}, NULL) = 0
1271  close(3)                          = 0
1271  gettimeofday({1049685359, 251302}, NULL) = 0
1271  gettimeofday({1049685359, 251338}, NULL) = 0
1271  gettimeofday({1049685359, 251371}, NULL) = 0
1271  munmap(0x40017000, 8192)          = 0
1271  open("/etc/rpm/macros.up2date", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/etc/rpm/macros", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/etc/rpm/i686-linux/macros", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  open("/home/rml/.rpmmacros", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  time(NULL)                        = 1049685359
1271  rt_sigprocmask(SIG_BLOCK, ~[], [], 8) = 0
1271  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
1271  rt_sigprocmask(SIG_BLOCK, ~[], [], 8) = 0
1271  rt_sigaction(SIGHUP, {0x400ca860, [], SA_RESTORER, 0x40208618}, {SIG_DFL}, 8) = 0
1271  rt_sigaction(SIGINT, {0x400ca860, [], SA_RESTORER, 0x40208618}, {SIG_DFL}, 8) = 0
1271  rt_sigaction(SIGTERM, {0x400ca860, [], SA_RESTORER, 0x40208618}, {SIG_DFL}, 8) = 0
1271  rt_sigaction(SIGQUIT, {0x400ca860, [], SA_RESTORER, 0x40208618}, {SIG_DFL}, 8) = 0
1271  rt_sigaction(SIGPIPE, {0x400ca860, [], SA_RESTORER, 0x40208618}, {SIG_DFL}, 8) = 0
1271  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
1271  getgid32()                        = 0
1271  getuid32()                        = 0
1271  stat64("/", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
1271  stat64("/var/", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
1271  stat64("/var/lib/", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
1271  stat64("/var/lib/rpm", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
1271  access("/var/lib/rpm", W_OK)      = 0
1271  access("/var/lib/rpm/__db.001", F_OK) = 0
1271  access("/var/lib/rpm/Packages", F_OK) = 0
1271  open("/usr/share/locale/locale.alias", O_RDONLY) = 3
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
1271  mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
1271  read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
1271  read(3, "", 4096)                 = 0
1271  close(3)                          = 0
1271  munmap(0x40017000, 4096)          = 0
1271  open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en_US.utf8/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en_US/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en.UTF-8/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en.utf8/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en/LC_MESSAGES/rpm.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  brk(0)                            = 0x805a000
1271  brk(0x805b000)                    = 0x805b000
1271  stat64("/var/lib/rpm/DB_CONFIG", 0xbfffe490) = -1 ENOENT (No such file or directory)
1271  open("/var/lib/rpm/DB_CONFIG", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
1271  stat64("/var/lib/rpm/__db.001", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  open("/var/lib/rpm/__db.001", O_RDWR|O_DIRECT|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  close(3)                          = 0
1271  select(0, NULL, NULL, NULL, {3, 0}) = 0 (Timeout)
1271  stat64("/var/lib/rpm/__db.001", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  open("/var/lib/rpm/__db.001", O_RDWR|O_DIRECT|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  close(3)                          = 0
1271  select(0, NULL, NULL, NULL, {6, 0}) = 0 (Timeout)
1271  stat64("/var/lib/rpm/__db.001", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  open("/var/lib/rpm/__db.001", O_RDWR|O_DIRECT|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  close(3)                          = 0
1271  select(0, NULL, NULL, NULL, {9, 0}) = 0 (Timeout)
1271  stat64("/var/lib/rpm/__db.001", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  open("/var/lib/rpm/__db.001", O_RDWR|O_DIRECT|O_LARGEFILE) = 3
1271  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
1271  fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
1271  close(3)                          = 0
1271  write(2, "rpmdb: ", 7)            = 7
1271  write(2, "unable to join the environment", 30) = 30
1271  write(2, "\n", 1)                 = 1
1271  open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
1271  brk(0)                            = 0x805b000
1271  brk(0x805d000)                    = 0x805d000
1271  write(2, "error: ", 7)            = 7
1271  write(2, "db4 error(11) from dbenv->open: "..., 65) = 65
1271  write(2, "error: ", 7)            = 7
1271  write(2, "cannot open Packages index using"..., 77) = 77
1271  rt_sigprocmask(SIG_BLOCK, ~[], [], 8) = 0
1271  rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) = 0
1271  rt_sigaction(SIGINT, {SIG_DFL}, NULL, 8) = 0
1271  rt_sigaction(SIGTERM, {SIG_DFL}, NULL, 8) = 0
1271  rt_sigaction(SIGQUIT, {SIG_DFL}, NULL, 8) = 0
1271  rt_sigaction(SIGPIPE, {SIG_DFL}, NULL, 8) = 0
1271  rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
1271  write(2, "error: ", 7)            = 7
1271  write(2, "cannot open Packages database in"..., 46) = 46
1271  fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
1271  mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
1271  write(1, "package glibc is not installed\n", 31) = 31
1271  munmap(0x40017000, 4096)          = 0
1271  exit_group(1)                     = ?

--=-0L8Tu7KdPZBo9v8B9zMc--

