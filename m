Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269351AbRHLP6d>; Sun, 12 Aug 2001 11:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269353AbRHLP6X>; Sun, 12 Aug 2001 11:58:23 -0400
Received: from femail40.sdc1.sfba.home.com ([24.254.60.34]:8617 "EHLO
	femail40.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269351AbRHLP6T>; Sun, 12 Aug 2001 11:58:19 -0400
Date: Sun, 12 Aug 2001 12:01:12 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Q3A segfaults with 2.4.8
In-Reply-To: <Pine.LNX.4.33.0108121643020.9470-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.33L2.0108121156550.971-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Tobias Ringstrom wrote:

> I think you need to use strace -f, or you will only thace the shell
> script.
>
> /Tobias

Oops sorry. I can't believe I did that. Here's the _real_ strace (where
it segfaults).

$ strace ./quake3.x86

[pid 18349] write(2, "\n------- sound initialization --"..., 38
------- sound initialization -------
) = 38
[pid 18349] ipc_subcall(0xffffffff, 0x1f5, 0xffffffff, 0x4026b170) = 0
[pid 18349] open("/dev/dsp", O_RDWR)    = 12
[pid 18349] SYS_199(0x4026c6ec, 0x2, 0x4026d320, 0x4026b170, 0) = 501
[pid 18349] ipc_subcall(0xffffffff, 0x1f5, 0xffffffff, 0x4026b170) = 0
[pid 18349] ioctl(12, SNDCTL_DSP_GETCAPS, 0xbffff6c4) = 0
[pid 18349] ioctl(12, SNDCTL_DSP_SPEED, 0x8161e0c) = 0
[pid 18349] ioctl(12, SNDCTL_DSP_STEREO, 0xbffff6bc) = 0
[pid 18349] ioctl(12, SNDCTL_DSP_SPEED, 0x878c174) = 0
[pid 18349] ioctl(12, SNDCTL_DSP_SETFMT, 0xbffff6b8) = 0
[pid 18349] ioctl(12, SNDCTL_DSP_GETOSPACE, 0xbffff6d0) = 0
[pid 18349] old_mmap(NULL, 65536, PROT_WRITE, MAP_SHARED, 12, 0) = 0x48ef6000
[pid 18349] ioctl(12, SNDCTL_DSP_SETTRIGGER, 0xbffff6bc) = 0
[pid 18349] ioctl(12, SNDCTL_DSP_SETTRIGGER, 0xbffff6bc) = 0
[pid 18349] write(2, "--------------------------------"..., 37------------------------------------
) = 37
[pid 18349] --- SIGSEGV (Segmentation fault) ---
[pid 18349] fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
[pid 18349] old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001e000
[pid 18349] ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
[pid 18349] write(1, "Received signal 11, exiting...\n", 31) = 31
[pid 18349] write(10, "\211\17\10\0\0\0\0\0\20\'\0\0\20\'\0\0\20\'\0\0\1B_m+l"..., 44) = 44
[pid 18349] read(10, "\1\0.\0\0\0\0\0\37\0\0\0h\365b\10X\353b\10@\0\0\0\350\214"..., 32) = 32
[pid 18349] write(10, "+\17\1\0", 4)    = 4
[pid 18349] read(10, "\1\2/\0\0\0\0\0\4\0\240\1\0\0\0\0\1\0\0\0\0\0\0\0\240\222"..., 32) = 32
[pid 18349] write(10, "\3\17\2\0\2\0\200\1\16\'\2\0\2\0\200\1", 16) = 16
[pid 18349] read(10, "\1\0000\0\3\0\0\0/\0\0\0\1\0\0\1\377\377\377\377\0\0\0"..., 32) = 32
[pid 18349] read(10, "O \3\0O \3\0\0\0~\10", 12) = 12
[pid 18349] read(10, "\1\0201\0\0\0\0\0M\0\0\0\0\0\0\0\200\2\340\1\0\0\0\0\240"..., 32) = 32
[pid 18349] ioctl(11, 0x4008642a, 0xbffff224) = 0
[pid 18349] munmap(0x48ed5000, 135168)  = 0
[pid 18349] munmap(0x48e82000, 339968)  = 0
[pid 18349] write(10, "\202\6\3\0\0\0\0\0\3\0\200\1\201\4\2\0\4\0\200\1\4B\2\0"..., 32) = 32
[pid 18349] read(10, "\22c4\0\2\0\200\1\2\0\200\1\0\3\16@\0\0\16\5\0\5\377\7"..., 32) = 32
[pid 18349] read(10, "\21E4\0\2\0\200\1\2\0\200\1\354\266\30@\220D\220\10@\234"..., 32) = 32
[pid 18349] read(10, "\1\0005\0\0\0\0\0\2\0\1\0\0\350\220\10\254\253\225\10\320"..., 32) = 32
[pid 18349] write(10, "\211\16\2\0\2\0\0\0\211\n\r\0\0\0\0\0\340\245\1\0\0\005"..., 104) = 104
[pid 18349] read(10, "\1\2:\0\0\0\0\0\4\0\240\1\0\0\0\0\0\0\0\0\0\0\0\0\240\222"..., 32) = 32
[pid 18349] munmap(0x48e41000, 266240)  = 0
[pid 18349] shutdown(10, 2 /* send and receive */) = 0
[pid 18349] close(10)                   = 0
[pid 18349] munmap(0x46e41000, 33554432) = 0
[pid 18349] munmap(0x4001d000, 4096)    = 0
[pid 18349] munmap(0x44e41000, 33554432) = 0
[pid 18349] fstat64(11, {st_mode=S_IFCHR|0666, st_rdev=makedev(226, 0), ...}) = 0
[pid 18349] fstat64(11, {st_mode=S_IFCHR|0666, st_rdev=makedev(226, 0), ...}) = 0
[pid 18349] close(11)                   = 0
[pid 18349] _exit(0)                    = ?
<... wait4 resumed> [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 18349
rt_sigprocmask(SIG_BLOCK, [CHLD TTOU], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) ---
wait4(-1, 0xbffff200, WNOHANG, NULL)    = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {SIG_DFL}, {0x8075120, [], 0x4000000}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, [CHLD TTOU], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
read(255, "exit 0 \n\n", 151)           = 9
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
_exit(0)                                = ?

-- 
Garett Spencley

I encourage you to encrypt e-mail sent to me using PGP
My public key is available on PGP key servers (http://keyservers.net)
Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9

