Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTI1HFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 03:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbTI1HFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 03:05:37 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:38418 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262337AbTI1HFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 03:05:35 -0400
Date: Sun, 28 Sep 2003 09:05:12 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: 2.6.0-test6: keyboard rate is slow and can't be changed with kbdrate
Message-ID: <20030928070512.GA2180@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On booting 2.6.0-test6, my keyboard rate is slow, and kbdrate won't
change it.



CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y

Just a normal PS/2 keyboard. Worked fine in 2.6.0-test5

execve("/sbin/kbdrate", ["/sbin/kbdrate", "-r", "30", "-d", "250"], [/* 23 vars */]) = 0
uname({sys="Linux", node="middle", ...}) = 0
brk(0)                                  = 0x804b000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=41394, ...}) = 0
old_mmap(NULL, 41394, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/libctutils.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \26\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=18288, ...}) = 0
old_mmap(NULL, 17456, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40021000
old_mmap(0x40025000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x4000) = 0x40025000
close(3)                                = 0
open("/lib/libconsole.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360Z\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=60188, ...}) = 0
old_mmap(NULL, 63256, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40026000
old_mmap(0x40033000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xc000) = 0x40033000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200^\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1230832, ...}) = 0
old_mmap(NULL, 1236260, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40036000
old_mmap(0x4015d000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x127000) = 0x4015d000
old_mmap(0x40162000, 7460, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40162000
close(3)                                = 0
munmap(0x40016000, 41394)               = 0
brk(0)                                  = 0x804b000
brk(0x806c000)                          = 0x806c000
brk(0)                                  = 0x806c000
ioctl(0, 0x4b52, 0xbffffc18)            = 0
ioctl(0, 0x4b52, 0xbffffc18)            = 0
fstat64(1, {st_mode=S_IFREG|0600, st_size=2178, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
write(1, "Typematic Rate set to 33.3 cps ("..., 48Typematic Rate set to 33.3 cps (delay = 250 ms)
) = 48
munmap(0x40016000, 4096)                = 0
exit_group(0)                           = ?

It says the rate is set to 33.3 cps, but it isn't. Nothing has changed.
This is the kbdrate from debian unstable, updated this morning.

I searched the lkml-archives, and found no mention of the word
'kbdrate'. I did see some keyboard changes in 2.6.0-test6. I even
noticed the results :-)

Good luck,
Jurriaan
-- 
This, said Renie at last, is really, really strange.
	Tad Williams - Otherland II River of Blue Fire
Debian (Unstable) GNU/Linux 2.6.0-test5 4276 bogomips 0.28 0.65
