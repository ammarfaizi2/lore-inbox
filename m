Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269249AbRHLOiN>; Sun, 12 Aug 2001 10:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269250AbRHLOiF>; Sun, 12 Aug 2001 10:38:05 -0400
Received: from femail29.sdc1.sfba.home.com ([24.254.60.19]:3256 "EHLO
	femail29.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269249AbRHLOhy>; Sun, 12 Aug 2001 10:37:54 -0400
Date: Sun, 12 Aug 2001 10:40:47 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Q3A segfaults with 2.4.8
In-Reply-To: <Pine.LNX.4.10.10108120314450.5761-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33L2.0108121038560.971-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Mark Hahn wrote:
> in cases like this, you need to run strace around the app,
> and see what it's doing that's failing.  all the system config
> stuff is fairly irrelevant...

$ strace quake3

execve("/usr/local/bin/quake3", ["quake3"], [/* 50 vars */]) = 0
uname({sys="Linux", node="localhost.localdomain", ...}) = 0
brk(0)                                  = 0x80da050
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=36055, ...}) = 0
old_mmap(NULL, 36055, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/libtermcap.so.2", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\r\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=11608, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001f000
old_mmap(NULL, 14696, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40020000
mprotect(0x40023000, 2408, PROT_NONE)   = 0
old_mmap(0x40023000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0x40023000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000 \0\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=10764, ...}) = 0
old_mmap(NULL, 13644, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40024000
mprotect(0x40027000, 1356, PROT_NONE)   = 0
old_mmap(0x40027000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0x40027000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\302"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1222404, ...}) = 0
old_mmap(NULL, 1237800, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40028000
mprotect(0x4014d000, 37672, PROT_NONE)  = 0
old_mmap(0x4014d000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x124000) = 0x4014d000
old_mmap(0x40153000, 13096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40153000
close(3)                                = 0
munmap(0x40016000, 36055)               = 0
getpid()                                = 2245
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
close(3)                                = 0
brk(0)                                  = 0x80da050
brk(0x80db000)                          = 0x80db000
brk(0x80dc000)                          = 0x80dc000
brk(0x80dd000)                          = 0x80dd000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
brk(0x80de000)                          = 0x80de000
brk(0x80df000)                          = 0x80df000
brk(0x80e0000)                          = 0x80e0000
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40016000, 4096)                = 0
open("/usr/share/locale/en/LC_IDENTIFICATION", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=244, ...}) = 0
old_mmap(NULL, 244, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
brk(0x80e1000)                          = 0x80e1000
open("/usr/share/locale/en/LC_MEASUREMENT", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=13, ...}) = 0
old_mmap(NULL, 13, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/usr/share/locale/en/LC_TELEPHONE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=49, ...}) = 0
old_mmap(NULL, 49, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
open("/usr/share/locale/en/LC_ADDRESS", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=145, ...}) = 0
old_mmap(NULL, 145, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40019000
close(3)                                = 0
open("/usr/share/locale/en/LC_NAME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=67, ...}) = 0
old_mmap(NULL, 67, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001a000
close(3)                                = 0
open("/usr/share/locale/en/LC_PAPER", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=24, ...}) = 0
old_mmap(NULL, 24, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001b000
close(3)                                = 0
open("/usr/share/locale/en_US/LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
close(3)                                = 0
open("/usr/share/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=42, ...}) = 0
old_mmap(NULL, 42, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001c000
close(3)                                = 0
open("/usr/share/locale/en_US/LC_MONETARY", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=276, ...}) = 0
old_mmap(NULL, 276, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001d000
close(3)                                = 0
open("/usr/share/locale/en_US/LC_COLLATE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=21484, ...}) = 0
old_mmap(NULL, 21484, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40157000
close(3)                                = 0
open("/usr/share/locale/en_US/LC_TIME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2441, ...}) = 0
old_mmap(NULL, 2441, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001e000
close(3)                                = 0
open("/usr/share/locale/en_US/LC_NUMERIC", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
old_mmap(NULL, 44, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4015d000
close(3)                                = 0
open("/usr/share/locale/en_US/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=110304, ...}) = 0
old_mmap(NULL, 110304, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4015e000
close(3)                                = 0
SYS_199(0x401516ec, 0, 0x40152320, 0x40150170, 0xbffff804) = 501
ipc_subcall(0x401516ec, 0, 0x40152320, 0x40150170) = 501
semop(1075123948, 0x40150170, 0)        = 501
semget(1075123948, 0, IPC_CREAT|0x40152120|0440) = 501
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
time(NULL)                              = 997627058
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=349, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40179000
read(3, "/dev/hda5 / reiserfs rw 0 0\nnone"..., 4096) = 349
close(3)                                = 0
munmap(0x40179000, 4096)                = 0
open("/proc/meminfo", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40179000
read(3, "        total:    used:    free:"..., 4096) = 573
close(3)                                = 0
munmap(0x40179000, 4096)                = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
uname({sys="Linux", node="localhost.localdomain", ...}) = 0
brk(0x80e2000)                          = 0x80e2000
brk(0x80e3000)                          = 0x80e3000
stat64("/usr/local/games/quake3", {st_mode=S_IFDIR|0755, st_size=496, ...}) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=496, ...}) = 0
getpid()                                = 2245
getppid()                               = 2244
brk(0x80e4000)                          = 0x80e4000
getpgrp()                               = 2244
rt_sigaction(SIGCHLD, {0x8074f60, [], 0x4000000}, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/usr/local/bin/quake3", O_RDONLY|O_LARGEFILE) = 3
_llseek(3, 0, [0], SEEK_CUR)            = 0
read(3, "#!/bin/sh\n# Needed to make symli"..., 80) = 80
_llseek(3, 0, [0], SEEK_SET)            = 0
getrlimit(0x7, 0xbffff648, 0, 0x3, 0xbffff648) = 0
dup2(3, 255)                            = 255
close(3)                                = 0
shmat(255, 0xbffff700, 0x2ptrace: umoven: Input/output error
)             = ?
shmat(255, 0x80e038c, 0x3ptrace: umoven: Input/output error
)              = ?
fstat64(255, {st_mode=S_IFREG|0755, st_size=151, ...}) = 0
_llseek(255, 0, [0], SEEK_CUR)          = 0
brk(0x80e5000)                          = 0x80e5000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "#!/bin/sh\n# Needed to make symli"..., 151) = 151
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=40582, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40179000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
brk(0x80e6000)                          = 0x80e6000
brk(0x80e7000)                          = 0x80e7000
read(3, "dule\tJUS_I.B1.002//\t\tINTERNAL\t\tI"..., 4096) = 4096
brk(0x80e8000)                          = 0x80e8000
brk(0x80e9000)                          = 0x80e9000
brk(0x80ea000)                          = 0x80ea000
read(3, "e\tISO-8859-4//\t\tINTERNAL\t\tISO885"..., 4096) = 4096
brk(0x80eb000)                          = 0x80eb000
brk(0x80ec000)                          = 0x80ec000
brk(0x80ed000)                          = 0x80ed000
brk(0x80ee000)                          = 0x80ee000
read(3, "\tISO-IR-103//\t\tT.61-8BIT//\nalias"..., 4096) = 4096
brk(0x80ef000)                          = 0x80ef000
read(3, "1\n\n#\tfrom\t\t\tto\t\t\tmodule\t\tcost\nal"..., 4096) = 4096
brk(0x80f0000)                          = 0x80f0000
brk(0x80f1000)                          = 0x80f1000
read(3, "RNAL\t\tIBM500\t\t1\nmodule\tINTERNAL\t"..., 4096) = 4096
brk(0x80f2000)                          = 0x80f2000
brk(0x80f3000)                          = 0x80f3000
brk(0x80f4000)                          = 0x80f4000
brk(0x80f5000)                          = 0x80f5000
brk(0x80f6000)                          = 0x80f6000
read(3, "odule\tINTERNAL\t\tIBM891//\t\tIBM891"..., 4096) = 4096
brk(0x80f7000)                          = 0x80f7000
brk(0x80f8000)                          = 0x80f8000
read(3, "\tBIG5//\nalias\tCN-BIG5//\t\tBIG5//\n"..., 4096) = 4096
brk(0x80f9000)                          = 0x80f9000
brk(0x80fa000)                          = 0x80fa000
brk(0x80fb000)                          = 0x80fb000
read(3, "ost\nalias\tISO_9036//\t\tASMO_449//"..., 4096) = 4096
brk(0x80fc000)                          = 0x80fc000
read(3, "-IR-8-1//\t\tNATS-SEFI//\nalias\tCSN"..., 4096) = 3718
brk(0x80fd000)                          = 0x80fd000
brk(0x80fe000)                          = 0x80fe000
brk(0x80ff000)                          = 0x80ff000
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40179000, 4096)                = 0
brk(0x8100000)                          = 0x8100000
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\10"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=6412, ...}) = 0
old_mmap(NULL, 9372, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40179000
mprotect(0x4017b000, 1180, PROT_NONE)   = 0
old_mmap(0x4017b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x4017b000
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x8101000)                          = 0x8101000
stat64("/usr", {st_mode=S_IFDIR|0755, st_size=408, ...}) = 0
stat64("/usr/local", {st_mode=S_IFDIR|0755, st_size=320, ...}) = 0
stat64("/usr/local/games", {st_mode=S_IFDIR|0755, st_size=96, ...}) = 0
stat64("/usr/local/games/quake3", {st_mode=S_IFDIR|0755, st_size=496, ...}) = 0
chdir("/usr/local/games/quake3")        = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -9, [142], SEEK_CUR)       = 0
fork()                                  = 2246
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x8075120, [], 0x4000000}, {SIG_DFL}, 8) = 0
wait4(-1, Q3 1.29h linux-i386 Aug  2 2001
----- FS_Startup -----
Current search path:
/home/gspen/.q3a/baseq3
/usr/local/games/quake3/baseq3/pak6.pk3 (64 files)
/usr/local/games/quake3/baseq3/pak5.pk3 (7 files)
/usr/local/games/quake3/baseq3/pak4.pk3 (272 files)
/usr/local/games/quake3/baseq3/pak3.pk3 (4 files)
/usr/local/games/quake3/baseq3/pak2.pk3 (148 files)
/usr/local/games/quake3/baseq3/pak1.pk3 (26 files)
/usr/local/games/quake3/baseq3/pak0.pk3 (3539 files)
/usr/local/games/quake3/baseq3
./quake3.x86/baseq3

----------------------
4060 files in pk3 files
execing default.cfg
couldn't exec q3config.cfg
couldn't exec autoexec.cfg
Hunk_Clear: reset the hunk ok
Joystick is not active.
----- Client Initialization -----
----- Initializing Renderer ----
-------------------------------
----- Client Initialization Complete -----
----- R_Init -----
...loading libGL.so: Initializing OpenGL display
...setting mode 3: 640 480
Using XFree86-VidModeExtension Version 2.1
Xlib:  extension "XFree86-DGA" missing on display ":0.0".
Failed to detect XF86DGA Mouse
XFree86-VidModeExtension Activated at 640x480
Using 4/4/4 Color bits, 16 depth, 0 stencil display.
GL_RENDERER: Mesa DRI Voodoo3 20010501 x86/MMX/3DNow!
Initializing OpenGL extensions
...GL_S3_s3tc not found
...ignoring GL_EXT_texture_env_add
...using GL_ARB_multitexture
...using GL_EXT_compiled_vertex_array
XF86 Gamma extension initialized

GL_VENDOR: VA Linux Systems, Inc.
GL_RENDERER: Mesa DRI Voodoo3 20010501 x86/MMX/3DNow!
GL_VERSION: 1.2 Mesa 3.4.2
GL_EXTENSIONS: GL_ARB_multitexture GL_ARB_transpose_matrix GL_EXT_abgr GL_EXT_clip_volume_hint GL_EXT_compiled_vertex_array GL_EXT_histogram GL_EXT_packed_pixels GL_EXT_paletted_texture GL_EXT_polygon_offset GL_EXT_rescale_normal GL_EXT_stencil_wrap GL_EXT_texture3D GL_EXT_texture_env_add GL_EXT_texture_object GL_EXT_texture_lod_bias GL_EXT_vertex_array GL_HP_occlusion_test GL_MESA_window_pos GL_MESA_resize_buffers GL_NV_texgen_reflection GL_PGI_misc_hints GL_SGI_color_matrix GL_SGI_color_table GL_SGIS_pixel_texture GL_SGIS_texture_edge_clamp GL_SGIX_pixel_texture
GL_MAX_TEXTURE_SIZE: 256
GL_MAX_ACTIVE_TEXTURES_ARB: 2

PIXELFORMAT: color(16-bits) Z(16-bit) stencil(0-bits)
MODE: 3, 640 x 480 fullscreen hz:N/A
GAMMA: hardware w/ 0 overbright bits
CPU:
rendering primitives: single glDrawElements
texturemode: GL_LINEAR_MIPMAP_NEAREST
picmip: 1
texture bits: 0
multitexture: enabled
compiled vertex arrays: enabled
texenv add: disabled
compressed textures: disabled
Initializing Shaders
...loading 'scripts/lightningnew.shader'
...loading 'scripts/explode1.shader'
...loading 'scripts/gfx.shader'
...loading 'scripts/tim.shader'
...loading 'scripts/base.shader'
...loading 'scripts/base_button.shader'
...loading 'scripts/base_floor.shader'
...loading 'scripts/base_light.shader'
...loading 'scripts/base_object.shader'
...loading 'scripts/base_support.shader'
...loading 'scripts/base_trim.shader'
...loading 'scripts/base_wall.shader'
...loading 'scripts/common.shader'
...loading 'scripts/ctf.shader'
...loading 'scripts/eerie.shader'
...loading 'scripts/gothic_block.shader'
...loading 'scripts/gothic_floor.shader'
...loading 'scripts/gothic_light.shader'
...loading 'scripts/gothic_trim.shader'
...loading 'scripts/gothic_wall.shader'
...loading 'scripts/hell.shader'
...loading 'scripts/liquid.shader'
...loading 'scripts/menu.shader'
...loading 'scripts/models.shader'
...loading 'scripts/organics.shader'
...loading 'scripts/sfx.shader'
...loading 'scripts/shrine.shader'
...loading 'scripts/skin.shader'
...loading 'scripts/sky.shader'
...loading 'scripts/test.shader'
----- finished R_Init -----

------- sound initialization -------
------------------------------------
[WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 2246
rt_sigprocmask(SIG_BLOCK, [CHLD TTOU], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) ---
wait4(-1, 0xbffff210, WNOHANG, NULL)    = -1 ECHILD (No child processes)
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

