Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286283AbSAAPmI>; Tue, 1 Jan 2002 10:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSAAPmA>; Tue, 1 Jan 2002 10:42:00 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:53144
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S286283AbSAAPlt>; Tue, 1 Jan 2002 10:41:49 -0500
Date: Tue, 1 Jan 2002 10:46:11 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 with es1370 pci
Message-ID: <20020101104611.A30843@animx.eu.org>
In-Reply-To: <20011231065544.A28966@animx.eu.org> <3C3065CE.1070608@wanadoo.fr> <20011231122440.B29342@animx.eu.org> <3C316C47.4080406@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C316C47.4080406@wanadoo.fr>; from Pierre Rousselet on Tue, Jan 01, 2002 at 08:59:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This was mpg123 v0.59q.  However, no player works (xmms, sound under wine,
> > bplay...)
> 
> Are you running at the same time some sounds server esd or artsd ?

Nope, they don't work well IMO and since this card has 2 DSPs I didn't see a
need in it.  I didn't mention that both DSPs stopped working.  I haven't
used the 2nd dsp on this card since this boot, but I know it works since I
used it the last boot.  When the first quits, they both are gone.  But
seeing how no interrupts are being delivered, makes sense (see below)

> your previous strace below doesn't show any read i/o. Could you strace 
> mpg123 -t and mpg123 -4 ?

I know,  I only pasted the what was for the sound card, it is working
properly.  mpg123 -a /dev/dsp2 works w/o any problem what so ever.

here's mpg123 -4:

execve("/usr/bin/mpg123", ["mpg123", "-4", "/sound/mp3/Aerosmith/Ain\'t_That_A_Bitch.mp3"], [/* 30 vars */]) = 0
uname({sys="Linux", node="ani", ...})   = 0
brk(0)                                  = 0x8083118
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20379, ...}) = 0
old_mmap(NULL, 20379, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 I\0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=134668, ...}) = 0
old_mmap(NULL, 137220, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
mprotect(0x4003c000, 2052, PROT_NONE)   = 0
old_mmap(0x4003c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x20000) = 0x4003c000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0(\327\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1171196, ...}) = 0
old_mmap(NULL, 1187968, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4003d000
mprotect(0x40155000, 41088, PROT_NONE)  = 0
old_mmap(0x40155000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x117000) = 0x40155000
old_mmap(0x4015b000, 16512, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015b000
close(3)                                = 0
munmap(0x40016000, 20379)               = 0
write(2, "High Performance MPEG 1.0/2.0/2."..., 69High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.
) = 69
write(2, "Version 0.59q (1999/Jan/26). Wri"..., 69Version 0.59q (1999/Jan/26). Written and copyrights by Michael Hipp.
) = 69
write(2, "Uses code from various people. S"..., 54Uses code from various people. See 'README' for more!
) = 54
write(2, "THIS SOFTWARE COMES WITH ABSOLUT"..., 71THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
) = 71
open("/dev/dsp", O_WRONLY)              = 3
ioctl(3, SNDCTL_DSP_GETBLKSIZE, 0x806ae1c) = 0
ioctl(3, SNDCTL_DSP_RESET, 0)           = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SNDCTL_DSP_STEREO, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_RATE, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
ioctl(3, SOUND_PCM_READ_BITS, 0xbffff8c0) = 0
close(3)                                = 0
rt_sigaction(SIGINT, {0x804b340, [], 0x4000000}, {SIG_DFL}, 8) = 0
open("/sound/mp3/Aerosmith/Ain\'t_That_A_Bitch.mp3", O_RDONLY) = 3
lseek(3, 0, SEEK_END)                   = 5204427
lseek(3, -128, SEEK_END)                = 5204299
read(3, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377"..., 128) = 128
lseek(3, 0, SEEK_SET)                   = 0
old_mmap(NULL, 5204427, PROT_READ, MAP_SHARED, 3, 0) = 0x40160000
brk(0)                                  = 0x8083118
brk(0x8083158)                          = 0x8083158
brk(0x8084000)                          = 0x8084000
write(2, "\nDirectory: /sound/mp3/Aerosmith"..., 33
Directory: /sound/mp3/Aerosmith/) = 33
write(2, "\nPlaying MPEG stream from Ain\'t_"..., 53
Playing MPEG stream from Ain't_That_A_Bitch.mp3 ...
) = 53
gettimeofday({1009899458, 822546}, NULL) = 0
write(2, "MPEG 1.0 layer III, 128 kbit/s, "..., 54MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
) = 54
brk(0x808d000)                          = 0x808d000
open("/dev/dsp", O_WRONLY)              = 4
ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x806ae1c) = 0
ioctl(4, SNDCTL_DSP_RESET, 0)           = 0
ioctl(4, SOUND_PCM_READ_BITS, 0xbffff79c) = 0
ioctl(4, SNDCTL_DSP_STEREO, 0xbffff798) = 0
ioctl(4, SOUND_PCM_READ_RATE, 0xbffff794) = 0
close(4)                                = 0
open("/dev/dsp", O_WRONLY)              = 4
ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x806ae1c) = 0
ioctl(4, SNDCTL_DSP_RESET, 0)           = 0
ioctl(4, SOUND_PCM_READ_BITS, 0xbffff8a0) = 0
ioctl(4, SNDCTL_DSP_STEREO, 0xbffff89c) = 0
ioctl(4, SOUND_PCM_READ_RATE, 0xbffff898) = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384) = 16384
write(4, "\374\377\3\0\373\377\4\0\367\377\1\0\373\377\7\0\377\377"..., 16384) = 16384
write(4, "\344\377\333\377\5\0\316\377\362\377\234\377\f\0\212\377"..., 16384) = 16384
write(4, "P\0\202\0\367\377\263\0\353\377\274\0\274\377\353\0\235"..., 16384) = 16384
write(4, "\23\377S\0I\377U\0\200\377\215\0Z\377\222\377\330\377\16"..., 16384) = 16384
write(4, "@\377\376\375\344\376\355\377\263\3769\0%\377Y\376\255"..., 16384) = 16384
write(4, "\0\0\274\1:\377\365\1\17\0\301\1\0\0\332\0\360\377%\377"..., 16384) = 16384
write(4, "\r\375_\372{\377\356\373W\374\230\370\'\1\220\0\26\371"..., 16384) = 16384
write(4, "k\5j\5\337\1E\370<\10\346\5{\377;\3776\4\374\4F\376\24"..., 16384
 <unfinished ...>
 
> > I assume so since this is a dual CPU machine.  Alan mentioned something
> > about unloading the usb modules, I don't even use them and haven't since
> > this machine was booted.
> 
> 
> What is showing cat /proc/interrupts ?

           CPU0       CPU1       
  0:   68416693   68502478    IO-APIC-edge  timer
  1:     400959     396781    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:  184224466  184748725    IO-APIC-edge  serial
  4:     803073     799856    IO-APIC-edge  serial
  5:     666537     667971   IO-APIC-level  aic7xxx
  7:        126        106    IO-APIC-edge  soundblaster
 10:   10271518   10263624   IO-APIC-level  eth0
 11:     236351     237359   IO-APIC-level  aic7xxx
 15:    4438445    4431067   IO-APIC-level  es1370
NMI:          0          0 
LOC:  136921268  136921264 
ERR:          0
MIS:          2

After attempting to play an mp3

           CPU0       CPU1       
  0:   68420347   68505506    IO-APIC-edge  timer
  1:     401392     397000    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:  184242407  184763513    IO-APIC-edge  serial
  4:     803633     800393    IO-APIC-edge  serial
  5:     666566     668012   IO-APIC-level  aic7xxx
  7:        126        106    IO-APIC-edge  soundblaster
 10:   10271726   10263824   IO-APIC-level  eth0
 11:     236351     237359   IO-APIC-level  aic7xxx
 15:    4438445    4431067   IO-APIC-level  es1370
NMI:          0          0 
LOC:  136927950  136927946 
ERR:          0
MIS:          2

> > System:
> > tyan s1832dl board
> > 2 pII 450 cpus
> > 4 128mb pc100 sticks (EEPROM /w SPD)
> > Matrox g400max dual (was a g200 before when I used 2.2.20)
> > 3com 3c905a
> > Adaptec aha-2940U/UW dual channel
> > Soundblaster PCI 64 (ES1370 which is having the problem)
> > Zoom 28.8k ISA modem (IRQ 9 IO 0x02E8)
> > Soundblaster 16 ISA (IRQ 7 IO 0x0220)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
