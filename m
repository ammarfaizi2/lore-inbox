Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVA1Re7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVA1Re7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVA1Re7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:34:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:3558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261217AbVA1RbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:31:06 -0500
Date: Fri, 28 Jan 2005 09:31:04 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org,
       "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
 threading error
Message-ID: <20050128093104.61a7a387@dxpl.pdx.osdl.net>
In-Reply-To: <41F97E07.2040709@comcast.net>
References: <217740000.1106412985@[10.10.2.4]>
	<41F30E0A.9000100@osdl.org>
	<1106482954.1256.2.camel@tux.rsn.bth.se>
	<20050126132504.3295e07d@dxpl.pdx.osdl.net>
	<41F97E07.2040709@comcast.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the strace output of the part that SEGV's, looks like a DRI issue??


close(255)                              = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGTSTP, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTTIN, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTTOU, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_IGN}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {0x8077263, [], 0}, 8) = 0
execve("/opt/openoffice.org1.9.69/program/soffice.bin", ["/opt/openoffice.org1.9.69/progra"..., "-calc"], [/* 36 vars */]) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
brk(0)                                  = 0x80c1000
readlink("/proc/self/exe", "/opt/openoffice.org1.9.69/program/soffice.bin", 4096) = 45
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/tls/i686/sse2/libvcl680li.so", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/openoffice.org1.9.69/program/tls/i686/sse2", 0xbfffed18) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/tls/i686/libvcl680li.so", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/openoffice.org1.9.69/program/tls/i686", 0xbfffed18) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/tls/sse2/libvcl680li.so", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/openoffice.org1.9.69/program/tls/sse2", 0xbfffed18) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/tls/libvcl680li.so", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/openoffice.org1.9.69/program/tls", 0xbfffed18) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/i686/sse2/libvcl680li.so", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/openoffice.org1.9.69/program/i686/sse2", 0xbfffed18) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/i686/libvcl680li.so", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/openoffice.org1.9.69/program/i686", 0xbfffed18) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/sse2/libvcl680li.so", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/opt/openoffice.org1.9.69/program/sse2", 0xbfffed18) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libvcl680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240p\f"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=3022928, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fff000
old_mmap(NULL, 3026100, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d1c000
old_mmap(0xb7fcb000, 212992, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2ae000) = 0xb7fcb000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libsvl680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \r\7\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=1314216, ...}) = 0
old_mmap(NULL, 1313260, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7bdb000
old_mmap(0xb7cf0000, 180224, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x115000) = 0xb7cf0000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libsvt680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p@\34\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=5063884, ...}) = 0
old_mmap(NULL, 5064216, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7706000
old_mmap(0xb7b4b000, 585728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x444000) = 0xb7b4b000
old_mmap(0xb7bda000, 1560, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7bda000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libutl680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\177"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=640456, ...}) = 0
old_mmap(NULL, 638928, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb766a000
old_mmap(0xb76ec000, 106496, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x82000) = 0xb76ec000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libtl680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\26\3\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=775384, ...}) = 0
old_mmap(NULL, 777496, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb75ac000
old_mmap(0xb7659000, 69632, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xac000) = 0xb7659000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libcomphelp4gcc3.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\6\6"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=1053244, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb75ab000
old_mmap(NULL, 1056752, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb74a9000
old_mmap(0xb7586000, 151552, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xdc000) = 0xb7586000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libucbhelper3gcc3.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\336\2"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=557164, ...}) = 0
old_mmap(NULL, 560296, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7420000
old_mmap(0xb7493000, 90112, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x72000) = 0xb7493000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libvos3gcc3.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\6\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=117164, ...}) = 0
old_mmap(NULL, 116344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7403000
old_mmap(0xb741e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b000) = 0xb741e000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libuno_cppuhelpergcc3.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\10"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=324300, ...}) = 0
old_mmap(NULL, 326872, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb73b3000
old_mmap(0xb73f4000, 61440, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x40000) = 0xb73f4000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libuno_cppu.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0<\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=221064, ...}) = 0
old_mmap(NULL, 219964, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb737d000
old_mmap(0xb73ab000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0xb73ab000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libuno_sal.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2009\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=1764412, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb737c000
old_mmap(NULL, 1767720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb71cc000
old_mmap(0xb7368000, 81920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19b000) = 0xb7368000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libtk680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p/\25\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=3165852, ...}) = 0
old_mmap(NULL, 3173564, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ec5000
old_mmap(0xb7149000, 532480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x283000) = 0xb7149000
old_mmap(0xb71cb000, 3260, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb71cb000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libjvmfwk.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0200\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=118520, ...}) = 0
old_mmap(NULL, 117092, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ea8000
old_mmap(0xb6ebf000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0xb6ebf000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/tls/i686/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client/tls/i686/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/tls/i686/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client/tls/i686", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/tls/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client/tls/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/tls/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client/tls", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/i686/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client/i686/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/i686/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client/i686", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/client", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls/i686/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls/i686/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls/i686/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls/i686", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads/tls", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/i686/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads/i686/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/i686/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads/i686", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/native_threads", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/usr/java/jre1.5.0_01/lib/i386/tls/i686/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/tls/i686/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/tls/i686/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/tls/i686", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/tls/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/tls/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/tls/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/tls", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/i686/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/i686/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/i686/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/i686", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/sse2/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386/sse2", 0xbfffebac) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/java/jre1.5.0_01/lib/i386", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("/opt/openoffice.org1.9.69/program/libXext.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=57633, ...}) = 0
old_mmap(NULL, 57633, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6e99000
close(3)                                = 0
open("/usr/X11R6/lib/libXext.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\6\245"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=53508, ...}) = 0
old_mmap(0xa4e000, 55476, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xa4e000
old_mmap(0xa5b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc000) = 0xa5b000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libSM.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libSM.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000`\264"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=32688, ...}) = 0
old_mmap(0xb44000, 30296, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb44000
old_mmap(0xb4b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0xb4b000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libICE.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libICE.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\26"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=86456, ...}) = 0
old_mmap(0xb4e000, 95536, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb4e000
old_mmap(0xb63000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0xb63000
old_mmap(0xb64000, 5424, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb64000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libX11.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libX11.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340c\231"..., 512) = 512
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e98000
fstat64(3, {st_mode=S_IFREG|0755, st_size=814588, ...}) = 0
old_mmap(0x985000, 813336, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x985000
old_mmap(0xa48000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc3000) = 0xa48000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libdl.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\373"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=16908, ...}) = 0
old_mmap(0x97f000, 12388, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x97f000
old_mmap(0x981000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x981000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@H\263\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=108560, ...}) = 0
old_mmap(0xb30000, 70108, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb30000
old_mmap(0xb3e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd000) = 0xb3e000
old_mmap(0xb40000, 4572, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb40000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libstlport_gcc.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\35\4\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=864308, ...}) = 0
old_mmap(NULL, 870716, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6dc3000
old_mmap(0xb6e7b000, 114688, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb7000) = 0xb6e7b000
old_mmap(0xb6e97000, 2364, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6e97000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libstdc++.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\261"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=846672, ...}) = 0
old_mmap(NULL, 871348, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6cee000
old_mmap(0xb6da0000, 122880, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb1000) = 0xb6da0000
old_mmap(0xb6dbe000, 19380, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6dbe000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\323\225"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=215272, ...}) = 0
old_mmap(0x95a000, 139424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x95a000
old_mmap(0x97b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20000) = 0x97b000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libgcc_s.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\26\0"..., 512) = 512
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6ced000
fstat64(3, {st_mode=S_IFREG|0444, st_size=32652, ...}) = 0
old_mmap(NULL, 30336, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ce5000
old_mmap(0xb6cec000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0xb6cec000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 /\204\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1524828, ...}) = 0
old_mmap(0x82e000, 1219740, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x82e000
mprotect(0x951000, 27804, PROT_NONE)    = 0
old_mmap(0x952000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x123000) = 0x952000
old_mmap(0x956000, 7324, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x956000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libsot680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\372"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=385596, ...}) = 0
old_mmap(NULL, 384080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6c87000
old_mmap(0xb6cd8000, 53248, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x51000) = 0xb6cd8000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libicuuc.so.26", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260n\2"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=729188, ...}) = 0
old_mmap(NULL, 728304, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6bd5000
old_mmap(0xb6c74000, 77824, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9f000) = 0xb6c74000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libicule.so.26", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\334"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=152240, ...}) = 0
old_mmap(NULL, 153884, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6baf000
old_mmap(0xb6bd0000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20000) = 0xb6bd0000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libjvmaccessgcc3.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\23\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=11212, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6bae000
old_mmap(NULL, 9784, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6bab000
old_mmap(0xb6bad000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xb6bad000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libfreetype.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libfreetype.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\233"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1236799, ...}) = 0
old_mmap(0x4c10b000, 466552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4c10b000
old_mmap(0x4c176000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6b000) = 0x4c176000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libuno_salhelpergcc3.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\35\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=15424, ...}) = 0
old_mmap(NULL, 13960, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ba7000
old_mmap(0xb6baa000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0xb6baa000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libbasegfx680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\22\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=245060, ...}) = 0
old_mmap(NULL, 247592, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6b6a000
old_mmap(0xb6ba5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3a000) = 0xb6ba5000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6b69000
open("/opt/openoffice.org1.9.69/program/libxml2.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\364\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=1019736, ...}) = 0
old_mmap(NULL, 1022008, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6a6f000
old_mmap(0xb6b5d000, 45056, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xee000) = 0xb6b5d000
old_mmap(0xb6b68000, 2104, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6b68000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libicudata.so.26", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0pM\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=3849284, ...}) = 0
old_mmap(NULL, 3846792, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb66c3000
old_mmap(0xb6a6e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3aa000) = 0xb6a6e000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libz.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\205"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=63528, ...}) = 0
old_mmap(0x4ae97000, 65028, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4ae97000
old_mmap(0x4aea6000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x4aea6000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb66c2000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb66c1000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb66c0000
mprotect(0xb66c3000, 3846144, PROT_READ|PROT_WRITE) = 0
mprotect(0xb66c3000, 3846144, PROT_READ|PROT_EXEC) = 0
mprotect(0x952000, 8192, PROT_READ)     = 0
mprotect(0x97b000, 4096, PROT_READ)     = 0
mprotect(0xb3e000, 4096, PROT_READ)     = 0
mprotect(0x981000, 4096, PROT_READ)     = 0
mprotect(0x82a000, 4096, PROT_READ)     = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb66c06c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb6e99000, 57633)               = 0
set_tid_address(0xb66c0708)             = 5029
rt_sigaction(SIGRTMIN, {0xb343c0, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb34430, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff488, 31, (nil), 0}) = 0
mmap2(NULL, 65536, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb66b0000
brk(0)                                  = 0x80c1000
brk(0x80e2000)                          = 0x80e2000
gettimeofday({1106932964, 319584}, NULL) = 0
gettimeofday({1106932964, 319630}, NULL) = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=39550416, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb64b0000
close(3)                                = 0
futex(0xb7368920, FUTEX_WAKE, 2147483647) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program", {st_mode=S_IFDIR|0755, st_size=20480, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program/soffice.bin", {st_mode=S_IFREG|0555, st_size=493904, ...}) = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
setrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
gettimeofday({1106932964, 322018}, NULL) = 0
futex(0x982060, FUTEX_WAKE, 2147483647) = 0
getcwd("/home/shemminger", 4096)        = 17
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program", {st_mode=S_IFDIR|0755, st_size=20480, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program", {st_mode=S_IFDIR|0755, st_size=20480, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program/soffice.bin", {st_mode=S_IFREG|0555, st_size=493904, ...}) = 0
getcwd("/home/shemminger", 4096)        = 17
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program", {st_mode=S_IFDIR|0755, st_size=20480, ...}) = 0
lstat64("/opt", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program", {st_mode=S_IFDIR|0755, st_size=20480, ...}) = 0
lstat64("/opt/openoffice.org1.9.69/program/sofficerc", {st_mode=S_IFREG|0444, st_size=19, ...}) = 0
access("/opt/openoffice.org1.9.69/program/sofficerc", F_OK) = 0
access("/opt/openoffice.org1.9.69/program/sofficerc", F_OK) = 0
stat64("/opt/openoffice.org1.9.69/program/sofficerc", {st_mode=S_IFREG|0444, st_size=19, ...}) = 0
open("/opt/openoffice.org1.9.69/program/sofficerc", O_RDONLY) = 3
read(3, "[Bootstrap]\nLogo=1\n", 79)    = 19
lseek(3, -7, SEEK_CUR)                  = 12
read(3, "Logo=1\n", 79)                 = 7
lseek(3, 0, SEEK_CUR)                   = 19
read(3, "", 79)                         = 0
fcntl64(3, F_SETLK, {type=F_UNLCK, whence=SEEK_SET, start=0, len=0}) = 0
close(3)                                = 0
gettimeofday({1106932964, 325658}, NULL) = 0
gettimeofday({1106932964, 325723}, NULL) = 0
gettimeofday({1106932964, 325811}, NULL) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
connect(3, {sa_family=AF_FILE, path="/tmp/.X11-unix/X0"}, 19) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
access("/home/shemminger/.Xauthority", R_OK) = 0
open("/home/shemminger/.Xauthority", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0600, st_size=134, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb64af000
read(4, "\1\0\0\27sch-laptop.pdx.osdl.net\0\0010\0\22"..., 4096) = 134
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xb64af000, 4096)                = 0
writev(3, [{"l\0\v\0\0\0\22\0\20\0\0\0", 12}, {"MIT-MAGIC-COOKIE-1", 18}, {"\0\0", 2}, {"\214_|k\250\331eV]\275w\205t5\34\361", 16}], 4) = 48
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
read(3, "\1\0\v\0\0\0c\0", 8)           = 8
read(3, "\350\277\237\3\0\0\240\2\377\377\37\0\0\1\0\0\24\0\377"..., 396) = 396
write(3, "7\0\5\0\0\0\240\2?\0\0\0\10\0\0\0\377\377\0\0b\0\5\0\f"..., 64) = 64
read(3, "\1\0\2\0\0\0\0\0\1\202\0\0\0\0\0\0\0\0\0\0\35\0\0\0008"..., 32) = 32
read(3, "\1\10\3\0\227\6\0\0\37\0\0\0\0\0\0\0Y\32\0\0\0\0\0\0\1"..., 32) = 32
readv(3, [{"*Box.background:\t#e6e6e6\n*Box.fo"..., 6745}, {"\0\0\0", 3}], 2) = 6748
write(3, "\202\0\1\0", 4)               = 4
read(3, "\1\0\4\0\0\0\0\0\377\377?\0\0\0\0\0\1\0\0\0\35\0\0\000"..., 32) = 32
writev(3, [{"b\0\5\0\t\0\240\2", 8}, {"XKEYBOARD", 9}, {"\0\0\0", 3}], 3) = 20
read(3, "\1\0\5\0\0\0\0\0\1\225n\257\0\0\0\0\1\0\0\0\35\0\0\000"..., 32) = 32
write(3, "\225\0\2\0\1\0\0\0", 8)       = 8
read(3, "\1\1\6\0\0\0\0\0\1\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0008W\201"..., 32) = 32
write(3, "\20\1\6\0\16\0\0\0GNOME_SM_PROXY\5\0", 24) = 24
read(3, "\1\0\7\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0008W\201"..., 32) = 32
write(3, "\20\1\t\0\32\0\0\0NAUTILUS_DESKTOP_WINDOW_"..., 36) = 36
read(3, "\1\0\10\0\0\0\0\0i\1\0\0\0\0\0\0\1\0\0\0\35\0\0\0008W\201"..., 32) = 32
write(3, "\25\1\2\0?\0\0\0", 8)         = 8
read(3, "\1\0\t\0\26\0\0\0\26\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\0\0"..., 32) = 32
read(3, "\366\0\0\0004\1\0\0=\1\0\0\20\1\0\0\17\1\0\0i\1\0\0;\1"..., 88) = 88
write(3, "<\1\2\0\0\0\240\2+A\1\0", 12) = 12
read(3, "\1\2\v\0\0\0\0\0\26\0\200\2\0\0\0\0\0\0\0\0\35\0\0\000"..., 32) = 32
shutdown(3, 2 /* send and receive */)   = 0
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libvclplug_gtk680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\332"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=143528, ...}) = 0
old_mmap(NULL, 146420, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb648c000
old_mmap(0xb64ab000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e000) = 0xb64ab000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libgtk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgtk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libgtk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libgtk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libgtk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgtk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=57633, ...}) = 0
old_mmap(NULL, 57633, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb647d000
close(3)                                = 0
open("/usr/lib/libgtk-x11-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\16\273"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=2828300, ...}) = 0
old_mmap(0x48b6f000, 2837464, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x48b6f000
old_mmap(0x48e18000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a9000) = 0x48e18000
old_mmap(0x48e21000, 11224, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x48e21000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libgdk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgdk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libgdk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libgdk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libgdk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgdk-x11-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libgdk-x11-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260|\343"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=440260, ...}) = 0
old_mmap(0x48e26000, 441524, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x48e26000
old_mmap(0x48e8d000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x66000) = 0x48e8d000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libatk-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libatk-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libatk-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libatk-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libatk-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libatk-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libatk-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\241"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=106116, ...}) = 0
old_mmap(0xcc4000, 103980, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xcc4000
old_mmap(0xcdc000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x18000) = 0xcdc000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libgdk_pixbuf-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgdk_pixbuf-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libgdk_pixbuf-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libgdk_pixbuf-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libgdk_pixbuf-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgdk_pixbuf-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libgdk_pixbuf-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \261\265"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=82968, ...}) = 0
old_mmap(0x48b58000, 84360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x48b58000
old_mmap(0x48b6c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x13000) = 0x48b6c000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libpangox-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpangox-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libpangox-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libpangox-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libpangox-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpangox-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libpangox-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\331\325"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=43468, ...}) = 0
old_mmap(0xd5a000, 44776, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xd5a000
old_mmap(0xd64000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9000) = 0xd64000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libpango-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpango-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libpango-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libpango-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libpango-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpango-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libpango-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`j\307\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=217464, ...}) = 0
old_mmap(0xc6d000, 219020, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xc6d000
old_mmap(0xc9e000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xc9e000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libgobject-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgobject-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libgobject-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libgobject-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libgobject-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgobject-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libgobject-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 :\257\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=240776, ...}) = 0
old_mmap(0xaed000, 243680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xaed000
old_mmap(0xb27000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x39000) = 0xb27000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libgmodule-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgmodule-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libgmodule-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libgmodule-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libgmodule-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgmodule-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libgmodule-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\274"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=11172, ...}) = 0
old_mmap(0xb2b000, 8720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb2b000
old_mmap(0xb2d000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xb2d000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libgthread-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libgthread-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\241h\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=15440, ...}) = 0
old_mmap(0x689000, 12884, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x689000
old_mmap(0x68c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x68c000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libglib-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libglib-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libglib-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libglib-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libglib-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libglib-2.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libglib-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\307"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=505232, ...}) = 0
old_mmap(0xa70000, 503724, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xa70000
old_mmap(0xaea000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7a000) = 0xaea000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libvclplug_gen680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\306\2"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=531640, ...}) = 0
old_mmap(NULL, 539252, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb63f9000
old_mmap(0xb6471000, 45056, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x77000) = 0xb6471000
old_mmap(0xb647c000, 2676, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb647c000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libpsp680li.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300w\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=877720, ...}) = 0
old_mmap(NULL, 876328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6323000
old_mmap(0xb639c000, 380928, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x79000) = 0xb639c000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libpangoxft-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpangoxft-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libpangoxft-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libpangoxft-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libpangoxft-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpangoxft-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libpangoxft-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\227"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=18852, ...}) = 0
old_mmap(0x4c508000, 19836, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4c508000
old_mmap(0x4c50c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x4c50c000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXrandr.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXrandr.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360{\326"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=11080, ...}) = 0
old_mmap(0xd67000, 8668, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xd67000
old_mmap(0xd69000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xd69000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libXi.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXi.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXi.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXi.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXi.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXi.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXi.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340a\312"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=28732, ...}) = 0
old_mmap(0xca5000, 30528, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xca5000
old_mmap(0xcac000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0xcac000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXinerama.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXinerama.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300X\325"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=7840, ...}) = 0
old_mmap(0xd55000, 9472, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xd55000
old_mmap(0xd57000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0xd57000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXft.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXft.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`*\35L4"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=70364, ...}) = 0
old_mmap(0x4c1cf000, 71768, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4c1cf000
old_mmap(0x4c1e0000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10000) = 0x4c1e0000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libfontconfig.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libfontconfig.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 r\30L4"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=152756, ...}) = 0
old_mmap(0x4c17f000, 153752, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4c17f000
old_mmap(0x4c1a1000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x4c1a1000
old_mmap(0x4c1a4000, 2200, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4c1a4000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXcursor.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXcursor.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\262\313"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=32680, ...}) = 0
old_mmap(0xcb9000, 34280, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xcb9000
old_mmap(0xcc1000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0xcc1000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXrender.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXrender.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\3\313"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=29636, ...}) = 0
old_mmap(0xcaf000, 31272, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xcaf000
old_mmap(0xcb6000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0xcb6000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libsndfile.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\36\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=317088, ...}) = 0
old_mmap(NULL, 332448, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb62d1000
old_mmap(0xb631a000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x49000) = 0xb631a000
old_mmap(0xb631e000, 17056, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb631e000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libportaudio.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\31"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0444, st_size=24384, ...}) = 0
old_mmap(NULL, 27164, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb62ca000
old_mmap(0xb62d0000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5000) = 0xb62d0000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libpangoft2-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpangoft2-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libpangoft2-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libpangoft2-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libpangoft2-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libpangoft2-1.0.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libpangoft2-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\321"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=157264, ...}) = 0
old_mmap(0x4c1a7000, 154544, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4c1a7000
old_mmap(0x4c1cc000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x25000) = 0x4c1cc000
close(3)                                = 0
open("/opt/openoffice.org1.9.69/program/libexpat.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libexpat.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libexpat.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libexpat.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libexpat.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libexpat.so.0", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/libexpat.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\37"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=127592, ...}) = 0
old_mmap(0xc10000, 124868, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xc10000
old_mmap(0xc2d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d000) = 0xc2d000
close(3)                                = 0
mprotect(0xb63f9000, 491520, PROT_READ|PROT_WRITE) = 0
mprotect(0xb63f9000, 491520, PROT_READ|PROT_EXEC) = 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
fcntl64(3, F_GETFD)                     = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
munmap(0xb647d000, 57633)               = 0
sched_getparam(5029, { 0 })             = 0
sched_getscheduler(5029)                = 0 (SCHED_OTHER)
sched_get_priority_min(SCHED_OTHER)     = 0
sched_get_priority_max(SCHED_OTHER)     = 0
sched_get_priority_max(SCHED_OTHER)     = 0
open("/usr/lib/charset.alias", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
pipe([4, 5])                            = 0
fcntl64(4, F_GETFD)                     = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fcntl64(5, F_GETFD)                     = 0
fcntl64(5, F_SETFD, FD_CLOEXEC)         = 0
fcntl64(4, F_GETFL)                     = 0 (flags O_RDONLY)
fcntl64(4, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
fcntl64(5, F_GETFL)                     = 0x1 (flags O_WRONLY)
fcntl64(5, F_SETFL, O_WRONLY|O_NONBLOCK) = 0
open("/usr/X11R6/lib/X11/locale/locale.alias", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0444, st_size=57698, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb648b000
read(6, "#\t$XdotOrg: xc/nls/locale.alias,"..., 4096) = 4096
read(6, ".UTF-8\nde_BE\t\t\t\t\t\tde_BE.ISO8859-"..., 4096) = 4096
read(6, "\t\t\t\t\tes_AR.ISO8859-1\nes_AR.utf8\t"..., 4096) = 4096
read(6, "SO_8859-1\t\t\t\tfr_FR.ISO8859-1\nfr_"..., 4096) = 4096
read(6, "\tkl_GL.UTF-8\nko\t\t\t\t\t\tko_KR.eucKR"..., 4096) = 4096
read(6, "8591\t\t\t\t\tpt_PT.ISO8859-1\npt_PT.I"..., 4096) = 4096
read(6, "tf8\t\t\t\t\tvi_VN.UTF-8\nVI_VN.UTF-8\t"..., 4096) = 4096
read(6, "locale name)\n#\tthe second word i"..., 4096) = 4096
read(6, "\nde_BE.iso885915:\t\t\t\tde_BE.ISO88"..., 4096) = 4096
read(6, "9-1\nes_AR.utf8:\t\t\t\t\tes_AR.UTF-8\n"..., 4096) = 4096
read(6, "88591.en:\t\t\t\t\tfr_FR.ISO8859-1\nfr"..., 4096) = 4096
read(6, "EORGIAN-ACADEMY\nka_GE.georgianrs"..., 4096) = 4096
read(6, "\t\t\t\t\tpt_BR.ISO8859-1\npt_BR.88591"..., 4096) = 4096
read(6, ":\t\t\t\tuk_UA.CP1251\nuk_UA.utf8:\t\t\t"..., 4096) = 4096
read(6, "tal Unix utf\nuniversal.utf8@ucs4"..., 4096) = 354
read(6, "", 4096)                       = 0
close(6)                                = 0
munmap(0xb648b000, 4096)                = 0
open("/usr/X11R6/lib/X11/locale/locale.dir", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0444, st_size=30324, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb648b000
read(6, "#\t$XdotOrg: xc/nls/locale.dir,v "..., 4096) = 4096
read(6, "SO8859-1\niso8859-1/XLC_LOCALE\t\t\t"..., 4096) = 4096
read(6, "LC_LOCALE\t\t\tsv_SE.ISO8859-15\ntsc"..., 4096) = 4096
read(6, "OCALE\t\t\tfr_FR.UTF-8\nen_US.UTF-8/"..., 4096) = 4096
read(6, "/XLC_LOCALE:\t\t\tbr_FR.ISO8859-14\n"..., 4096) = 4096
read(6, "ISO8859-15\niso8859-8/XLC_LOCALE:"..., 4096) = 4096
read(6, "_ET.UTF-8\nen_US.UTF-8/XLC_LOCALE"..., 4096) = 4096
close(6)                                = 0
munmap(0xb648b000, 4096)                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0644, st_size=21544, ...}) = 0
mmap2(NULL, 21544, PROT_READ, MAP_SHARED, 6, 0) = 0xb6486000
close(6)                                = 0
futex(0x95512c, FUTEX_WAKE, 2147483647) = 0
open("/usr/X11R6/lib/X11/locale/en_US.UTF-8/XI18N_OBJS", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0444, st_size=345, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6485000
read(6, "# CATEGORY(XLC|XIM|OM)\tSHARED_LI"..., 4096) = 345
read(6, "", 4096)                       = 0
close(6)                                = 0
munmap(0xb6485000, 4096)                = 0
open("/usr/X11R6/lib/X11/locale/lib/common/xlcUTF8Load.so.2", O_RDONLY) = 6
read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\5\0"..., 512) = 512
fstat64(6, {st_mode=S_IFREG|0644, st_size=3224, ...}) = 0
old_mmap(NULL, 6236, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0xb6484000
old_mmap(0xb6485000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0) = 0xb6485000
close(6)                                = 0
open("/usr/X11R6/lib/X11/locale/locale.alias", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0444, st_size=57698, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6483000
read(6, "#\t$XdotOrg: xc/nls/locale.alias,"..., 4096) = 4096
read(6, ".UTF-8\nde_BE\t\t\t\t\t\tde_BE.ISO8859-"..., 4096) = 4096
read(6, "\t\t\t\t\tes_AR.ISO8859-1\nes_AR.utf8\t"..., 4096) = 4096
read(6, "SO_8859-1\t\t\t\tfr_FR.ISO8859-1\nfr_"..., 4096) = 4096
read(6, "\tkl_GL.UTF-8\nko\t\t\t\t\t\tko_KR.eucKR"..., 4096) = 4096
read(6, "8591\t\t\t\t\tpt_PT.ISO8859-1\npt_PT.I"..., 4096) = 4096
read(6, "tf8\t\t\t\t\tvi_VN.UTF-8\nVI_VN.UTF-8\t"..., 4096) = 4096
read(6, "locale name)\n#\tthe second word i"..., 4096) = 4096
read(6, "\nde_BE.iso885915:\t\t\t\tde_BE.ISO88"..., 4096) = 4096
read(6, "9-1\nes_AR.utf8:\t\t\t\t\tes_AR.UTF-8\n"..., 4096) = 4096
read(6, "88591.en:\t\t\t\t\tfr_FR.ISO8859-1\nfr"..., 4096) = 4096
read(6, "EORGIAN-ACADEMY\nka_GE.georgianrs"..., 4096) = 4096
read(6, "\t\t\t\t\tpt_BR.ISO8859-1\npt_BR.88591"..., 4096) = 4096
read(6, ":\t\t\t\tuk_UA.CP1251\nuk_UA.utf8:\t\t\t"..., 4096) = 4096
read(6, "tal Unix utf\nuniversal.utf8@ucs4"..., 4096) = 354
read(6, "", 4096)                       = 0
close(6)                                = 0
munmap(0xb6483000, 4096)                = 0
open("/usr/X11R6/lib/X11/locale/locale.dir", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0444, st_size=30324, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6483000
read(6, "#\t$XdotOrg: xc/nls/locale.dir,v "..., 4096) = 4096
read(6, "SO8859-1\niso8859-1/XLC_LOCALE\t\t\t"..., 4096) = 4096
read(6, "LC_LOCALE\t\t\tsv_SE.ISO8859-15\ntsc"..., 4096) = 4096
read(6, "OCALE\t\t\tfr_FR.UTF-8\nen_US.UTF-8/"..., 4096) = 4096
read(6, "/XLC_LOCALE:\t\t\tbr_FR.ISO8859-14\n"..., 4096) = 4096
read(6, "ISO8859-15\niso8859-8/XLC_LOCALE:"..., 4096) = 4096
read(6, "_ET.UTF-8\nen_US.UTF-8/XLC_LOCALE"..., 4096) = 4096
close(6)                                = 0
munmap(0xb6483000, 4096)                = 0
access("/usr/X11R6/lib/X11/locale/en_US.UTF-8/XLC_LOCALE", R_OK) = 0
open("/usr/X11R6/lib/X11/locale/en_US.UTF-8/XLC_LOCALE", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0444, st_size=2072, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6483000
read(6, "#  $XFree86: xc/nls/XLC_LOCALE/e"..., 4096) = 2072
read(6, "", 4096)                       = 0
close(6)                                = 0
munmap(0xb6483000, 4096)                = 0
getresuid32([500], [500], [500])        = 0
getresgid32([500], [500], [500])        = 0
open("/usr/share/locale/locale.alias", O_RDONLY) = 6
fstat64(6, {st_mode=S_IFREG|0644, st_size=2528, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6483000
read(6, "# Locale name alias data base.\n#"..., 4096) = 2528
read(6, "", 4096)                       = 0
close(6)                                = 0
munmap(0xb6483000, 4096)                = 0
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/gtk20.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/gtk20.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/gtk20.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/gtk20.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/gtk20.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/gtk20.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
getuid32()                              = 500
socket(PF_FILE, SOCK_STREAM, 0)         = 6
fcntl64(6, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(6, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(6)                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 6
fcntl64(6, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(6, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(6, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(6)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 6
fstat64(6, {st_mode=S_IFREG|0644, st_size=1686, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6483000
read(6, "#\n# /etc/nsswitch.conf\n#\n# An ex"..., 4096) = 1686
read(6, "", 4096)                       = 0
close(6)                                = 0
munmap(0xb6483000, 4096)                = 0
open("/opt/openoffice.org1.9.69/program/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libnss_files.so.2", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 6
fstat64(6, {st_mode=S_IFREG|0644, st_size=57633, ...}) = 0
old_mmap(NULL, 57633, PROT_READ, MAP_PRIVATE, 6, 0) = 0xb62bb000
close(6)                                = 0
open("/lib/libnss_files.so.2", O_RDONLY) = 6
read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\32"..., 512) = 512
fstat64(6, {st_mode=S_IFREG|0755, st_size=47496, ...}) = 0
old_mmap(NULL, 41604, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 6, 0) = 0xb62b0000
old_mmap(0xb62b9000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 6, 0x8000) = 0xb62b9000
close(6)                                = 0
mprotect(0xb62b9000, 4096, PROT_READ)   = 0
munmap(0xb62bb000, 57633)               = 0
open("/etc/passwd", O_RDONLY)           = 6
fcntl64(6, F_GETFD)                     = 0
fcntl64(6, F_SETFD, FD_CLOEXEC)         = 0
fstat64(6, {st_mode=S_IFREG|0644, st_size=1552, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb62c9000
read(6, "root:x:0:0:root:/root:/bin/bash\n"..., 4096) = 1552
close(6)                                = 0
munmap(0xb62c9000, 4096)                = 0
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/gtk20-properties.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/gtk20-properties.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/gtk20-properties.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/gtk20-properties.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/gtk20-properties.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/gtk20-properties.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 6
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
connect(6, {sa_family=AF_FILE, path="/tmp/.X11-unix/X0"}, 19) = 0
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
fcntl64(6, F_SETFD, FD_CLOEXEC)         = 0
access("/home/shemminger/.Xauthority", R_OK) = 0
open("/home/shemminger/.Xauthority", O_RDONLY) = 7
fstat64(7, {st_mode=S_IFREG|0600, st_size=134, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb62c9000
read(7, "\1\0\0\27sch-laptop.pdx.osdl.net\0\0010\0\22"..., 4096) = 134
read(7, "", 4096)                       = 0
close(7)                                = 0
munmap(0xb62c9000, 4096)                = 0
writev(6, [{"l\0\v\0\0\0\22\0\20\0\0\0", 12}, {"MIT-MAGIC-COOKIE-1", 18}, {"\0\0", 2}, {"\214_|k\250\331eV]\275w\205t5\34\361", 16}], 4) = 48
fcntl64(6, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(6, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
read(6, "\1\0\v\0\0\0c\0", 8)           = 8
read(6, "\350\277\237\3\0\0\240\2\377\377\37\0\0\1\0\0\24\0\377"..., 396) = 396
write(6, "7\0\5\0\0\0\240\2?\0\0\0\10\0\0\0\377\377\0\0b\0\5\0\f"..., 64) = 64
read(6, "\1\0\2\0\0\0\0\0\1\202\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\10\3\0\227\6\0\0\37\0\0\0\0\0\0\0Y\32\0\0\0\0\0\0\1"..., 32) = 32
readv(6, [{"*Box.background:\t#e6e6e6\n*Box.fo"..., 6745}, {"\0\0\0", 3}], 2) = 6748
write(6, "\202\0\1\0", 4)               = 4
read(6, "\1\0\4\0\0\0\0\0\377\377?\0\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
writev(6, [{"b\0\5\0\t\0\240\2", 8}, {"XKEYBOARD", 9}, {"\0\0\0", 3}], 3) = 20
read(6, "\1\0\5\0\0\0\0\0\1\225n\257\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\225\0\2\0\1\0\0\0", 8)       = 8
read(6, "\1\1\6\0\0\0\0\0\1\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0\30\340"..., 32) = 32
writev(6, [{"b\0\4\0\10\0\0\0", 8}, {"XINERAMA", 8}], 2) = 16
read(6, "\1\0\7\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0\30\340"..., 32) = 32
write(6, "\2\0\4\0?\0\0\0\0\10\0\0\0\0\2\0\20\0\6\0\r\0\5\0_XSET"..., 84) = 84
read(6, "\1\17\t\0\0\0\0\0\336\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\17\n\0\0\0\0\0\337\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\17\v\0\0\0\0\0\340\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\3\0\2\0?\0\0\0\16\10\2\0?\0\0\0", 16) = 16
read(6, "\1\0\f\0\3\0\0\0\"\0\0\0\1\0\0\1\377\377\377\377\0\0\0"..., 32) = 32
read(6, "3 \372\0\0\0\2\0\0\0}\10", 12) = 12
read(6, "\1\20\r\0\0\0\0\0?\0\0\0\0\0\0\0\0\4\0\3\0\0\0\0\30\340"..., 32) = 32
write(6, "\2\0\4\0?\0\0\0\0\10\0\0\0\0\2\0$\0\1\0\27\0\2\0\336\0"..., 28) = 28
read(6, "\1\352\20\0\0\0\0\0\3\0\200\0\0\0\0\0\0\0\0\0\35\0\0\0"..., 32) = 32
write(6, "\2\0\4\0\3\0\200\0\0\10\0\0\0\0B\0%\0\1\0", 20) = 20
write(6, "\3\0\2\0\3\0\200\0\16\10\2\0\3\0\200\0", 16) = 16
read(6, "\1\0\23\0\3\0\0\0\"\0\0\0\1\0\0\1\377\377\377\377\0\0\0"..., 32) = 32
read(6, "\0\0J\0\0\0B\0\0\0}\10", 12)   = 12
read(6, "\1\20\24\0\0\0\0\0?\0\0\0\0\0\0\0\n\0\n\0\0\0\0\0\30\340"..., 32) = 32
write(6, "\17\0\2\0\3\0\200\0", 8)      = 8
read(6, "\1\0\25\0\0\0\0\0?\0\0\0?\0\0\0\0\0\0\0\0\0\0\0(\0\0\0"..., 32) = 32
write(6, "\24\0\6\0\3\0\200\0\337\0\0\0\337\0\0\0\0\0\0\0\377\377"..., 24) = 24
read(6, "\1\10\26\0\240\0\0\0\337\0\0\0\0\0\0\0\200\2\0\0\0\0\0"..., 32) = 32
readv(6, [{"\0X\225\0\0\0\0\0\23\0\0\0\0\0\23\0Gtk/CanChangeAcc"..., 640}, {"", 0}], 2) = 640
write(6, "\1\20\r\0\1\0\240\2?\0\0\0\n\0\n\0\n\0\n\0\0\0\1\0\"\0"..., 88) = 88
read(6, "\1\352\31\0\0\0\0\0\341\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0"..., 32) = 32
write(6, "\20\0\5\0\f\0\240\2_NET_WM_NAME", 20) = 20
read(6, "\1\0\32\0\0\0\0\0\342\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 7
read(7, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\4\0"..., 512) = 512
fstat64(7, {st_mode=S_IFREG|0755, st_size=5336, ...}) = 0
old_mmap(NULL, 8220, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 7, 0) = 0xb62c7000
old_mmap(0xb62c8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 7, 0) = 0xb62c8000
close(7)                                = 0
brk(0x8109000)                          = 0x8109000
write(6, "\22\0\t\0\1\0\240\2\342\0\0\0\341\0\0\0\10AME\v\0\0\0s"..., 100) = 100
read(6, "\34\365\33\0\1\0\240\2\342\0\0\0S\37\31\0\0\0\0\0S\37\31"..., 32) = 32
read(6, "\34\365\34\0\1\0\240\2\'\0\0\0S\37\31\0\0\0\0\0S\37\31"..., 32) = 32
read(6, "\1\257\35\0\0\0\0\0\343\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0"..., 32) = 32
write(6, "\22\0\t\0\1\0\240\2\343\0\0\0\341\0\0\0\10AME\v\0\0\0s"..., 96) = 96
read(6, "\34\365\36\0\1\0\240\2\343\0\0\0T\37\31\0\0\0\0\0T\37\31"..., 32) = 32
read(6, "\34\365\37\0\1\0\240\2%\0\0\0T\37\31\0\0\0\0\0T\37\31\0"..., 32) = 32
read(6, "\1\257 \0\0\0\0\0\344\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\20\0\6\0\r\0\240\2WM_TAKE_FOCUS\0\0\0", 24) = 24
read(6, "\1\0!\0\0\0\0\0\345\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0\30\340"..., 32) = 32
write(6, "\20\0\5\0\f\0\240\2_NET_WM_PING", 20) = 20
read(6, "\1\0\"\0\0\0\0\0\346\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\20\0\5\0\f\0\240\2WM_PROTOCOLS", 20) = 20
read(6, "\1\0#\0\0\0\0\0\347\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0\30\340"..., 32) = 32
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
write(6, "\22\0\t\0\1\0\240\2\347\0\0\0\4\0\0\0 OLS\3\0\0\0\344\0"..., 268) = 268
read(6, "\34\365$\0\1\0\240\2\347\0\0\0U\37\31\0\0\0\0\0U\37\31"..., 32) = 32
read(6, "\34\365(\0\1\0\240\2(\0\0\0U\37\31\0\0\0\240\2\22\0\0\0"..., 32) = 32
read(6, "\34\365)\0\1\0\240\2$\0\0\0U\37\31\0\0\0\0\0U\37\31\0X"..., 32) = 32
read(6, "\1\260*\0\0\0\0\0\350\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\22\0\t\0\1\0\240\2\350\0\0\0\37\0\0\0\10OLS\v\0\0\0en"..., 56) = 56
read(6, "\34\365+\0\1\0\240\2\350\0\0\0V\37\31\0\0\0\0\0V\37\31"..., 32) = 32
read(6, "\1\257,\0\0\0\0\0\351\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\22\0\7\0\1\0\240\2\351\0\0\0\6\0\0\0 OLS\1\0\0\0\245\23"..., 52) = 52
read(6, "\34\365-\0\1\0\240\2\351\0\0\0V\37\31\0\0\0\0\0V\37\31"..., 32) = 32
read(6, "\1\257.\0\0\0\0\0\352\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\22\0\7\0\1\0\240\2\352\0\0\0!\0\0\0 OLS\1\0\0\0\0\0\0"..., 384) = 384
read(6, "\34\365/\0\1\0\240\2\352\0\0\0V\37\31\0\0\0\0\0V\37\31"..., 32) = 32
read(6, "\1\2570\0\0\0\0\0\353\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2571\0\0\0\0\0\354\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2572\0\0\0\0\0\355\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2573\0\0\0\0\0\356\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2574\0\0\0\0\0\357\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2575\0\0\0\0\0\360\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2576\0\0\0\0\0\361\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2577\0\0\0\0\0\362\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2578\0\0\0\0\0\363\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\2579\0\0\0\0\0\364\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\257:\0\0\0\0\0\365\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
read(6, "\1\257;\0\0\0\0\0\366\0\0\0\0\0\0\0\0\0\0\0\35\0\0\0\30"..., 32) = 32
uname({sys="Linux", node="sch-laptop.pdx.osdl.net", ...}) = 0
write(6, "\22\0\23\0\1\0\240\2\"\0\0\0\37\0\0\0\10OLS4\0\0\0/opt"..., 280) = 280
read(6, "\34\365<\0\1\0\240\2\"\0\0\0X\37\31\0\0\0\0\0X\37\31\0"..., 32) = 32
read(6, "\34\365=\0\1\0\240\2$\0\0\0X\37\31\0\0\0\0\0X\37\31\0X"..., 32) = 32
read(6, "\34\365>\0\1\0\240\2C\0\0\0X\37\31\0\0\0\0\0X\37\31\0X"..., 32) = 32
read(6, "\34\365?\0\1\0\240\2\350\0\0\0X\37\31\0\0\0\0\0X\37\31"..., 32) = 32
read(6, "\34\365@\0\1\0\240\2\351\0\0\0X\37\31\0\0\0\0\0X\37\31"..., 32) = 32
read(6, "\1\0B\0\0\0\0\0\37\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0d\260\203"..., 32) = 32
writev(6, [{"b\0\3\0\4\0\240\2", 8}, {"SYNC", 4}], 2) = 12
read(6, "\1\0C\0\0\0\0\0\1\203A\200\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\203\0\2\0\3\0\240\2", 8)     = 8
read(6, "\1\0D\0\0\0\0\0\3\0\0\0\0\0\0\0\1\0\0\0\35\0\0\0\30\340"..., 32) = 32
writev(6, [{"b\0\4\0\7\0\240\2", 8}, {"MIT-SHM", 7}, {"\0", 1}], 3) = 16
read(6, "\1\0E\0\0\0\0\0\1\222^\251\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\222\0\1\0", 4)               = 4
read(6, "\1\1F\0\0\0\0\0\1\0\1\0\0\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0"..., 32) = 32
pipe([7, 8])                            = 0
writev(6, [{"b\0\6\0\17\0\240\2", 8}, {"XInputExtension", 15}, {"\0", 1}], 3) = 24
read(6, "\1\0G\0\0\0\0\0\1\223_\252\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
writev(6, [{"b\0\6\0\17\0\240\2", 8}, {"XInputExtension", 15}, {"\0", 1}], 3) = 24
read(6, "\1\0H\0\0\0\0\0\1\223_\252\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
writev(6, [{"\223\1\6\0\17\0\240\2", 8}, {"XInputExtension", 15}, {"\0", 1}], 3) = 24
read(6, "\1\1I\0\0\0\0\0\1\0\3\0\1\0\0\0\1\0\0\0\35\0\0\0\30\340"..., 32) = 32
write(6, "\223\2\1\0", 4)               = 4
read(6, "\1\2J\0!\0\0\0\3\20\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\0\0\0"..., 32) = 32
read(6, "p\0\0\0\0\1\1\0q\0\0\0\1\2\2\0r\0\0\0\2\2\0\0\0\10\10\377"..., 132) = 132
write(6, "\223\3\2\0\1\0\240\2", 8)     = 8
read(6, "\1\3K\0\2\0\0\0\4\0\0\0\320\'\16\10\35\0\0\0h\257\203\10"..., 32) = 32
read(6, "\1b\2d\3\0\6i", 8)             = 8
write(6, "c\3\1\0", 4)                  = 4
read(6, "\1\37L\0T\0\0\0\0\20\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\0\0\0"..., 32) = 32
readv(6, [{"\5SHAPE\26MIT-SUNDRY-NONSTANDARD\fBI"..., 336}, {"", 0}], 2) = 336
open("/opt/openoffice.org1.9.69/program/libGL.so", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libGL.so", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libGL.so", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libGL.so", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libGL.so", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libGL.so", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libGL.so", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 9
fstat64(9, {st_mode=S_IFREG|0644, st_size=57633, ...}) = 0
old_mmap(NULL, 57633, PROT_READ, MAP_PRIVATE, 9, 0) = 0xb62a1000
close(9)                                = 0
open("/usr/X11R6/lib/libGL.so", O_RDONLY) = 9
read(9, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\265"..., 512) = 512
fstat64(9, {st_mode=S_IFREG|0755, st_size=512716, ...}) = 0
old_mmap(0xcaf000, 515364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 9, 0) = 0xb6223000
old_mmap(0xb629d000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 9, 0x7a000) = 0xb629d000
old_mmap(0xb62a0000, 3364, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb62a0000
close(9)                                = 0
open("/opt/openoffice.org1.9.69/program/libXxf86vm.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/client/libXxf86vm.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/native_threads/libXxf86vm.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/java/jre1.5.0_01/lib/i386/libXxf86vm.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/opt/openoffice.org1.9.69/program/libXxf86vm.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/X11R6/lib/libXxf86vm.so.1", O_RDONLY) = 9
read(9, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\353"..., 512) = 512
fstat64(9, {st_mode=S_IFREG|0755, st_size=17632, ...}) = 0
old_mmap(0xa5e000, 19264, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 9, 0) = 0xa5e000
old_mmap(0xa62000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 9, 0x3000) = 0xa62000
close(9)                                = 0
mprotect(0xb6223000, 499712, PROT_READ|PROT_WRITE) = 0
mprotect(0xb6223000, 499712, PROT_READ|PROT_EXEC) = 0
munmap(0xb62a1000, 57633)               = 0
writev(6, [{"b\3\3\0\3\0\240\2", 8}, {"GLX", 3}, {"\0", 1}], 3) = 12
read(6, "\1\0M\0\0\0\0\0\1\217M\232\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\217\7\3\0\1\0\0\0\4\0\0\0", 12) = 12
read(6, "\1\0N\0\0\0\0\0\1\0\0\0\2\0\0\0\350\237\202\10\0\0\0\0"..., 32) = 32
writev(6, [{"b\7\5\0\v\0\0\0", 8}, {"XFree86-DRI", 11}, {"\0", 1}], 3) = 20
read(6, "\1\0O\0\0\0\0\0\1\221\0\247\0\0\0\0\1\0\0\0\35\0\0\0\30"..., 32) = 32
write(6, "\221\0\1\0", 4)               = 4
read(6, "\1XP\0\0\0\0\0\4\0\1\0\0\0\0\0\0\365\377\277\343~\224\000"..., 32) = 32
write(6, "\221\1\2\0\0\0\0\0", 8)       = 8
read(6, "\1\0Q\0\0\0\0\0\1\20\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\0\0\0"..., 32) = 32
write(6, "\221\4\2\0\0\0\0\0", 8)       = 8
read(6, "\1\0R\0\1\0\0\0\1\0\0\0\3\0\0\0\0\0\0\0\4\0\0\0(\0\0\0"..., 32) = 32
readv(6, [{"i915", 4}, {"", 0}], 2)     = 4
geteuid32()                             = 500
getuid32()                              = 500
open("/usr/X11R6/lib/modules/dri/i915_dri.so", O_RDONLY) = 9
read(9, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \246\2"..., 512) = 512
fstat64(9, {st_mode=S_IFREG|0444, st_size=1891048, ...}) = 0
old_mmap(NULL, 1756876, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 9, 0) = 0xb6076000
old_mmap(0xb6208000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 9, 0x191000) = 0xb6208000
old_mmap(0xb621a000, 36556, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb621a000
close(9)                                = 0
mprotect(0xb6076000, 1646592, PROT_READ|PROT_WRITE) = 0
mprotect(0xb6076000, 1646592, PROT_READ|PROT_EXEC) = 0
write(6, "\217\23\3\0\0\0\0\0\2\0\0\0", 12) = 12
read(6, "\1\0S\0\1\0\0\0\0\0\0\0\4\0\0\0\0\0\0\0\0\0\0\0\250\365"..., 32) = 32
read(6, "1.2\0", 4)                     = 4
write(6, "\217\23\3\0\0\0\0\0\3\0\0\0", 12) = 12
read(6, "\1\0T\0+\0\0\0\0\0\0\0\253\0\0\0\0\0\0\0\0\0\0\0\250\365"..., 32) = 32
read(6, "GLX_ARB_multisample GLX_EXT_visu"..., 171) = 171
read(6, "\0", 1)                        = 1
write(6, "\217\21\4\0\4\0\1\0\3\0\0\0\0\0\0\0", 16) = 16
read(6, "\1\0U\0\340\0\0\0\10\0\0\0\34\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32) = 32
read(6, "\v\200\0\0\"\0\0\0\23\200\0\0\"\0\0\0\22\200\0\0\1\0\0"..., 224) = 224
read(6, "\v\200\0\0#\0\0\0\23\200\0\0#\0\0\0\22\200\0\0\1\0\0\0"..., 224) = 224
read(6, "\v\200\0\0$\0\0\0\23\200\0\0$\0\0\0\22\200\0\0\1\0\0\0"..., 224) = 224
read(6, "\v\200\0\0%\0\0\0\23\200\0\0%\0\0\0\22\200\0\0\1\0\0\0"..., 224) = 224
read(6, "\v\200\0\0&\0\0\0\23\200\0\0&\0\0\0\22\200\0\0\1\0\0\0"..., 224) = 224
read(6, "\v\200\0\0\'\0\0\0\23\200\0\0\'\0\0\0\22\200\0\0\1\0\0"..., 224) = 224
read(6, "\v\200\0\0(\0\0\0\23\200\0\0(\0\0\0\22\200\0\0\1\0\0\0"..., 224) = 224
read(6, "\v\200\0\0)\0\0\0\23\200\0\0)\0\0\0\22\200\0\0\1\0\0\0"..., 224) = 224
write(6, "\221\1\2\0\0\0\0\0", 8)       = 8
read(6, "\1\0V\0\0\0\0\0\1\20\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\0\0\0"..., 32) = 32
write(6, "\221\2\2\0\0\0\0\0", 8)       = 8
read(6, "\1\0W\0\4\0\0\0\0@)\340\0\0\0\0\20\0\0\0\0\0\0\0(\0\0\0"..., 32) = 32
readv(6, [{"pci:0000:00:02.0", 16}, {"", 0}], 2) = 16
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card0", {st_mode=S_IFCHR|0660, st_rdev=makedev(226, 0), ...}) = 0
open("/dev/dri/card0", O_RDWR)          = -1 EACCES (Permission denied)
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/dev/dri/card0", O_RDWR)          = -1 EACCES (Permission denied)
unlink("/dev/dri/card0")                = -1 EACCES (Permission denied)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card1", {st_mode=S_IFCHR|0660, st_rdev=makedev(226, 1), ...}) = 0
open("/dev/dri/card1", O_RDWR)          = -1 EACCES (Permission denied)
open("/dev/dri/card1", O_RDWR)          = -1 EACCES (Permission denied)
unlink("/dev/dri/card1")                = -1 EACCES (Permission denied)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card2", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card3", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card4", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card5", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card6", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card7", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card8", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card9", 0xbfffeb78)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card10", 0xbfffeb78)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card11", 0xbfffeb78)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card12", 0xbfffeb78)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card13", 0xbfffeb78)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card14", 0xbfffeb78)   = -1 ENOENT (No such file or directory)
munmap(0x955838, 8192)                  = -1 EINVAL (Invalid argument)
munmap(0x80d7ff0, 3221222108)           = -1 EINVAL (Invalid argument)
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
