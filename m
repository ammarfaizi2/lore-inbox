Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTJGHte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 03:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJGHte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 03:49:34 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:6091 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S261873AbTJGHtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 03:49:32 -0400
Date: Tue, 07 Oct 2003 09:49:31 +0200
From: Domen Puncer <domen@coderock.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-reply-to: <Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200310070949.31220.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200310061529.56959.domen@coderock.org>
 <200310070144.47822.domen@coderock.org>
 <Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 of October 2003 02:18, Zwane Mwaikambo wrote:
> On Tue, 7 Oct 2003, Domen Puncer wrote:
> > On Tuesday 07 of October 2003 00:43, Zwane Mwaikambo wrote:
> > > On Tue, 7 Oct 2003, Domen Puncer wrote:
> > > > > Ok, could you send your .config too, i use the 3c59x driver and
> > > > > haven't noticed this in 2.6.0-test5-mm4. My card is;
> > > >
> > > > .config at the end of mail
> > >
> > > Sorry i forgot to ask for a dmesg too (from a kernel exhibiting the
> > > problem)
> >
> > 0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400. Vers LK1.1.19
> > eth0: no IPv6 routers present
> > eth0: Setting full-duplex based on MII #24 link partner capability of
> > 0141.
>
> What is your link peer?

Not native english speaker, but if "link peer"  is the remote end, then this is a
friend's computer. (and a hub is between computers)


> > Might be relevant... the last line is lagged a couple of seconds, and
> > network works fine before i see that line in dmesg.
>
> I'm also curious as to why mii-tool doesn't work, can you attach an strace
> mii-tool eth0?

# strace mii-tool eth0
execve("/sbin/mii-tool", ["mii-tool", "eth0"], [/* 37 vars */]) = 0
brk(0)                                  = 0x804c000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=74950, ...}) = 0
old_mmap(NULL, 74950, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300]\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1458907, ...}) = 0
old_mmap(NULL, 1268836, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40029000
mprotect(0x40158000, 27748, PROT_NONE)  = 0
old_mmap(0x40158000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12f000) = 0x40158000
old_mmap(0x4015d000, 7268, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015d000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4015f000
munmap(0x40016000, 74950)               = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 3
ioctl(3, 0x89f0, 0x804b460)             = -1 EOPNOTSUPP (Operation not supported)
write(2, "SIOCGMIIPHY on \'eth0\' failed: Op"..., 54SIOCGMIIPHY on 'eth0' failed: Operation not supported
) = 54
close(3)                                = 0
exit_group(1)                           = ?

