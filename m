Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264835AbRF1Wuw>; Thu, 28 Jun 2001 18:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbRF1Wun>; Thu, 28 Jun 2001 18:50:43 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:23051 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S264829AbRF1Wuc>;
	Thu, 28 Jun 2001 18:50:32 -0400
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: linux-kernel@vger.kernel.org
Subject: AGP Question
Date: Thu, 28 Jun 2001 14:50:33 -0700
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_90UN8W27QZWDNVKBRFR4"
Message-Id: <20010629000227.4750C6E42@clueserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_90UN8W27QZWDNVKBRFR4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

It there a way to limit how much memory is allocatable by the AGPGART code?

The reason I am asking is I am seeing some odd behaviour that I suspect is 
related to that code.

When I boot the machine, it says something like "200 megs maximum available 
for AGP memory.  X seems to grab 3/4 of that number and then never quite let 
go of it. (The memory map under /proc shows big blocks of memory allocated 
and marked "deleted" for the X PID.)

I used to have a memory leak in another library that would push the system 
into a rather bad state because of the big chunk o' memory that seems to be 
eaten by X.

I have looked at the code, but I did not see anything obvious for that 
function. I could just be going blind though...

Is AGP memory limatable or do I have to look at the X side of things?

Attached is a memory mapp for the X process...

--------------Boundary-00=_90UN8W27QZWDNVKBRFR4
Content-Type: text/plain;
  charset="iso-8859-1";
  name="maps"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="maps"

08048000-0819a000 r-xp 00000000 03:01 4833355    /usr/X11R6/bin/XFree86
0819a000-081c9000 rw-p 00151000 03:01 4833355    /usr/X11R6/bin/XFree86
081c9000-0a5da000 rwxp 00000000 00:00 0
40000000-40016000 r-xp 00000000 03:01 4243460    /lib/ld-2.2.2.so
40016000-40017000 rw-p 00015000 03:01 4243460    /lib/ld-2.2.2.so
40017000-40018000 rw-p 00000000 00:00 0
40018000-40028000 rw-s 000a0000 03:01 181386     /dev/mem
40028000-40029000 rw-s ec680000 03:01 181386     /dev/mem
40029000-4002a000 rw-s ec601000 03:01 181386     /dev/mem
4002a000-4002b000 rw-s ec0c0000 03:01 181386     /dev/mem
4002b000-4002c000 rw-s ec681000 03:01 181386     /dev/mem
4002c000-4002d000 rw-s 40000000 03:01 185562     /dev/nvidia0
40030000-4003c000 r-xp 00000000 03:01 622887     /usr/lib/libz.so.1.1.3
4003c000-4003e000 rw-p 0000b000 03:01 622887     /usr/lib/libz.so.1.1.3
4003e000-40061000 r-xp 00000000 03:01 6684678    /lib/i686/libm-2.2.2.so
40061000-40062000 rw-p 00022000 03:01 6684678    /lib/i686/libm-2.2.2.so
40062000-40069000 r-xp 00000000 03:01 4243533    /lib/libpam.so.0.74
40069000-4006a000 rw-p 00006000 03:01 4243533    /lib/libpam.so.0.74
4006a000-4006d000 r-xp 00000000 03:01 4243473    /lib/libdl-2.2.2.so
4006d000-4006e000 rw-p 00002000 03:01 4243473    /lib/libdl-2.2.2.so
4006e000-40070000 r-xp 00000000 03:01 4243534    /lib/libpam_misc.so.0.74
40070000-40071000 rw-p 00001000 03:01 4243534    /lib/libpam_misc.so.0.74
40071000-40197000 r-xp 00000000 03:01 6684676    /lib/i686/libc-2.2.2.so
40197000-4019d000 rw-p 00125000 03:01 6684676    /lib/i686/libc-2.2.2.so
4019d000-401a2000 rw-p 00000000 00:00 0
401a2000-401ac000 r-xp 00000000 03:01 4243494    /lib/libnss_files-2.2.2.so
401ac000-401ad000 rw-p 00009000 03:01 4243494    /lib/libnss_files-2.2.2.so
401ad000-40231000 rwxp 00001000 03:01 1573394    /usr/X11R6/lib/modules/extensions/libglx.so.1.0.1251
40231000-40233000 rwxp 00000000 00:00 0
40233000-40579000 rwxp 00001000 03:01 622757     /usr/lib/libGLcore.so.1.0.1251
40579000-405d7000 rwxp 00000000 00:00 0
405d7000-40607000 rw-p 00000000 00:00 0
40607000-42607000 rw-s e0000000 03:01 181386     /dev/mem
42607000-46607000 rw-s 10000000 03:01 185562     /dev/nvidia0
46607000-46617000 rw-s 80000000 03:01 185562     /dev/nvidia0
46617000-46627000 rw-s 00800000 03:01 185562     /dev/nvidia0
46627000-4662f000 rw-s 40000000 03:01 185562     /dev/nvidia0
4662f000-46730000 rw-s 00000000 00:03 2057240576 /SYSV00000000 (deleted)
46730000-47730000 rw-s 00000000 03:01 185562     /dev/nvidia0
47730000-4b730000 rw-s 10000000 03:01 185562     /dev/nvidia0
4b730000-4b831000 rw-s 00000000 00:03 2057240576 /SYSV00000000 (deleted)
4b831000-4b891000 rw-s 00000000 00:03 2057404417 /SYSV00000000 (deleted)
4b891000-4b8f1000 rw-s 00000000 00:03 2058158082 /SYSV00000000 (deleted)
4b8f1000-4b951000 rw-s 00000000 00:03 2068709388 /SYSV00000000 (deleted)
4b951000-4b9b1000 rw-s 00000000 00:03 528941061  /SYSV00000000 (deleted)
4b9b1000-4ba11000 rw-s 00000000 00:03 2058289158 /SYSV00000000 (deleted)
4ba11000-4ba71000 rw-s 00000000 00:03 221806596  /SYSV00000000 (deleted)
4ba71000-4ba73000 rw-p 00000000 00:00 0
4ba73000-4ba8b000 rw-s 00000000 00:03 1488060424 /SYSV00000000 (deleted)
4ba8b000-4baa5000 rw-s 00000000 00:03 1488093195 /SYSV00000000 (deleted)
4baa5000-4baca000 rw-s 00000000 00:03 1488355346 /SYSV00000000 (deleted)
4bad1000-4bb31000 rw-s 00000000 00:03 2058551305 /SYSV00000000 (deleted)
4bb31000-4bbae000 rw-p 00000000 00:00 0
4bbc5000-4bc25000 rw-s 00000000 00:03 2068676611 /SYSV00000000 (deleted)
4bc2e000-4beaa000 rw-p 000ec000 00:00 0
4beaa000-4bf0a000 rw-s 00000000 00:03 1487929351 /SYSV00000000 (deleted)
4bf0e000-4bf66000 rw-p 00000000 00:00 0
4bf6a000-4c022000 rw-p 00000000 00:00 0
4c065000-4c0b9000 rw-p 000ec000 00:00 0
4c0d7000-4c353000 rw-p 00000000 00:00 0
4c35c000-4c482000 rw-p 000ec000 00:00 0
4c49e000-4c73e000 rw-p 00000000 00:00 0
4c73e000-4c7f9000 rw-s 00000000 00:03 1488257038 /SYSV00000000 (deleted)
4c825000-4c885000 rw-s 00000000 00:03 2090762268 /SYSV00000000 (deleted)
4c885000-4c996000 rw-p 00000000 00:00 0
4c9cc000-4cc78000 rw-p 00000000 00:00 0
4cc7b000-4dafc000 rw-p 00554000 00:00 0
4db46000-4dba4000 rw-p 00000000 00:00 0
4dba4000-4dc65000 rw-s 00000000 00:03 1488289808 /SYSV00000000 (deleted)
4dcb2000-4dcfc000 rw-p 00299000 00:00 0
4dd04000-4dd76000 rw-p 000ec000 00:00 0
4dd7f000-4e31a000 rw-p 000ec000 00:00 0
4e34e000-4ec02000 rw-p 000ec000 00:00 0
4ec02000-4ecbd000 rw-s 00000000 00:03 1488322577 /SYSV00000000 (deleted)
4ecf2000-4ed50000 rw-p 00a90000 00:00 0
4ed6b000-4efba000 rw-p 000ec000 00:00 0
4efc6000-4f081000 rw-p 00347000 00:00 0
4f084000-4f16a000 rw-p 000ec000 00:00 0
4f1b5000-4f48d000 rw-p 00183000 00:00 0
4f4ce000-500f1000 rw-p 000ec000 00:00 0
5012f000-5056e000 rw-p 00d4d000 00:00 0
505b8000-50a6d000 rw-p 00000000 00:00 0
50a8c000-50f56000 rw-p 00000000 00:00 0
50f5f000-5110f000 rw-p 000ec000 00:00 0
51118000-51d38000 rw-p 002a5000 00:00 0
51d4d000-524e7000 rw-p 000ec000 00:00 0
524e7000-525a2000 rw-s 00000000 00:03 1489698835 /SYSV00000000 (deleted)
52706000-52bd5000 rw-p 00000000 00:00 0
52f48000-53383000 rw-p 000ec000 00:00 0
535f3000-535fc000 rw-p 000e3000 00:00 0
bff95000-c0000000 rwxp fff96000 00:00 0

--------------Boundary-00=_90UN8W27QZWDNVKBRFR4--
