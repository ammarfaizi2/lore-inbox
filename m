Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUIVUXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUIVUXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUIVURY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:17:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23168 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267180AbUIVUOZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:14:25 -0400
Date: Wed, 22 Sep 2004 16:13:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stas Sergeev <stsp@aknet.ru>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ESP corruption bug - what CPUs are affected?
In-Reply-To: <4151DA79.7000804@aknet.ru>
Message-ID: <Pine.LNX.4.53.0409221608420.1368@chaos.analogic.com>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru>
 <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru>
 <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru>
 <Pine.LNX.4.53.0409221501440.1085@chaos.analogic.com> <4151DA79.7000804@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Stas Sergeev wrote:

> Hi,
>
> Richard B. Johnson wrote:
> > What problem is this supposed to fix?
> Richard, it will really help if you read the
> whole thread. I was answering this to Denis
> Vlasenko already - he agreed. Do I have to
> repeat the explanations?
>
> > ESP is __not__ corrupted
> Right, but is not properly restored either,
> while it have to be.
>
> > when returning to protected-mode or a different privilege level.
> It gets "corrupted" (not properly restored)
> exactly when returning to *protected mode*
> from another priv level. Please refer to the
> Intel docs I pointed to in that thread earlier.
>
> > You don't 'return' to protected mode from a virtual-8086 mode,
> Noone was speaking about v86. I don't see why
> you pick that up.
>
> > The so-called bug is that when in real mode or in virtual-8086
> > mode, the high word of ESP is not changed.
> In short: Wrong.
> The complete explanations are easily locateable
> in that thread. And it have nothing to do with
> the real mode either.
>
> > It is not a bug
> > because the high word doesn't even exist when in VM-86 mode!!
> Noone was speaking about v86, sorry. I am bypassing
> that part.
>
> > It is possible to use the 32-bit prefix, when in 16-bit mode,
> That's not about the prefixes either, sorry.
> We were talking about the 32bit PM code.
>
> > Please, somebody from Intel tell these guys to leave the thing
> > alone.
> Thanks many, they already left that alone once:)
> Maybe enough of leaving the bugs alone?
> I have lots of the DOS progs here that do not
> work under dosemu without that patch, and work
> perfectly with it. It should be enough. If
> you need an examples - well, OpenCubicPlayer
> for one. It will start, but crash as soon as
> the music is attempted to play. The patch fixes
> it. Other progs you'll have problems downloading
> anyway, but let me know if you need these.
>
> > I, for one, don't want a bunch of "fixes" that do nothing
> > except consume valuable RAM, making it near impossible to
> > use later versions of Linux in embedded systems.
> Well, my patch is purely in asm. How many
> valueable bytes does it take from you?
> As for performance - 8 asm insns on a generic
> path. Not too much either, as for me.
>

Well DOSEMU uses VM-86 mode. That's how it works. It
creates a virtual 8086 machine, complete with the
required "DOS compatible" virtual BIOS environment.

I use it all the time because I write, amongst other things,
the complete BIOS and startup code for many Intel based
machines.

I run compilers, assemblers, linkers, and editors in that
environment and it works.

Sombody mentions a completely unrelated so-called Intel
bug and next thing you know, there are patches to work-
around the bug???

The bug doesn't exist period. Here is a session in
VM-86 mode., using DOSEMU. It does one hell of a lot
more work than your games.



Script started on Wed Sep 22 16:00:02 2004
# godos
CPU speed set to 2793/1 MHz
Running on CPU=586, FPU=1, rdtsc=1
Linux DOS emulator 0.98.5.0 $Date: 99/01/15 $
Last configured at Wed Mar 24 12:44:16 EST 1999 on linux
This is work in progress.
Please test against a recent version before reporting bugs and problems.
Bugs, Patches & New Code to linux-msdos@vger.rutgers.edu

Starting MS-DOS...

[1;1H[37m[44m
                [2;1H
                      [3;1H
                            [4;1H
                                  [5;1H     1. Start the TCP/IP Network  (NE* B
radley's code)                          [6;1H     2. Start the TCP/IP Network  (3COM Board PCTCP)                            [7;1H     3. Start the TCP/IP Network  (3COM Board ANALOGIC)                         [8;1H     4. Load NDIS driver only     (3COM Board)                                  [9;1H     [1m[37m[47m5. Do not load any network[m[37m[44m                                                 [10;1H     6. Do not execute any AUTOEXEC.BAT commands                                [11;1H     7. Start RCCS Host Software                                                [12;1H MS-DOS 6.22 Startup Menu                                                       [13;1H  Enter a choice: 5ออออออ                                                       [14;1H                                                                                [15;1H                                                                                [16;1H                                                                                [17;1H                                                                                [18;1H                                                                                [19;1H                                                                                [20;1H                                                                                [21;1H                                                                                [22;1H                                                                                [23;1H                                                                                [24;1H                                                                                [25;1HF5=Bypass startup files F8=Confirm each line of CONFIG.SYS and AUTOEXEC.BAT [N][13;19H[13;27HTime remaining: 04[13;19H[13;20H                         [25;1H                                                                               [15;1H
MS-DOS Version 6.22

C:\>cd pbios

C:\PBIOS>make clean

Microsoft (R) Program Maintenance Utility  Version 4.07
Copyright (C) Microsoft Corp 1984-1988.  All rights reserved.

[37m[40m[3;24r[3;1H[3;24r[24;1H

[3;24r[5;1H[1;25r[23;1H[37m[44m                                                                                [24;1H  if exist *.obj del *.obj                                                      [25;1H[37m[40m[1;24r[1;1H[1;24r[24;1H


[1;24r[1;1H[1;25r[22;1H[37m[44m  if exist *.bin del *.bin                                                      [23;1H  if exist *.rom del *.rom                                                      [24;1H  if exist *.hex del *.hex                                                      [25;1H[37m[40m[1;24r[1;1H[1;24r[24;1H






[1;24r[1;1H[1;25r[18;1H[37m[44m  if exist *.lis del *.lis                                                      [19;1H  if exist *.com del *.com                                                      [20;1H  if exist *.exe del *.exe                                                      [21;1H  if exist *.oe0 del *.oe0                                                      [22;1H  if exist *.oe1 del *.oe1                                                      [23;1H  cd tools                                                                      [24;1H  if exist *.obj del *.obj                                                      [25;1H[37m[40m[3;24r[3;1H[3;24r[24;1H






[3;24r[5;1H[1;25r[1;1H[37m[44mC:\PBIOS> make clean[18;1H  if exist *.bin del *.bin                                                      [19;1H  if exist *.rom del *.rom                                                      [20;1H  if exist *.hex del *.hex                                                      [21;1H  if exist *.com del *.com                                                      [22;1H  if exist *.exe del *.exe                                                      [23;1H  cd ..                                                                         [24;1H                                                                                [25;1HC:\PBIOS>[25;11Hmake[25;16Hpbios[37m[40m[2;20r[2;1HMMMMMMMMMMMMMMMM[1;25r[1;1H[37m[44m  if exist *.obj del *.obj
  if exist *.bin del *.bin                                                      [3;1H  if exist *.rom del *.rom                                                      [4;1H  if exist *.hex del *.hex                                                      [5;1H  if exist *.com del *.com                                                      [6;1H  if exist *.exe del *.exe                                                      [7;1H  cd ..                                                                         [8;1H                                                                                [9;1HC:\PBIOS> make pbios                                                            [10;1H                                                                                [11;1HMicrosoft (R) Program Maintenance Utility  Version 4.07                         [12;1HCopyright (C) Microsoft Corp 1984-1988.  All rights reserved.                   [13;1H                                                                                [14;1H                                                                                [15;1HMAKE : warning U4000: 'TOOLS\IHEX.EXE' : target does not exist                  [16;1H  CD TOOLS                                                                      [17;1H  MAKE TOOLS                                                                    [21;3H                        [22;3H
MAKE : warning U4000: 'odeven.exe' : target does not exist[24;3Hcl -W3 odeven.c
                    [37m[40m[10;16r[10;1HMMMM[1;25r[1;14H[37m[44mcom[7Ccom[2;14Hexe[7Cexe[3;3Hcd ..                   [4;3H
C:\PBIOS> make pbios      [6;3H
Microsoft (R) Program Maintenance Utility  Version 4.07
Copyright (C) Microsoft Corp 1984-1988.  All rights reserved.

                                                                                [11;1HMAKE : warning U4000: 'TOOLS\IHEX.EXE' : target does not exist                  [12;1H  CD TOOLS                                                                      [13;1H  MAKE TOOLS                                                                    [17;3H          [19;2HAKE : warning U4000: 'odeven.exe' : target does not exist
  cl -W3 odeven.c
Microsoft (R) C Optimizing Compiler Version 6.00A
Copyright (c) Microsoft Corp 1984-1990. All rights reserved.

odeven.c
[37m[40m[2;24r[2;1H[2;24r[24;1H








[2;24r[3;1H[1;25r[1;3H[37m[44m                        [16;1H                                                                                [17;1HMicrosoft (R) Segmented-Executable Linker  Version 5.13                         [18;1HCopyright (C) Microsoft Corp 1984-1991.  All rights reserved.                   [19;1H                                                                                [20;1HObject Modules [.OBJ]: odeven.obj /farcall                                      [21;1HRun File [odeven.exe]: "odeven.exe" /noi                                        [22;1HList File [NUL.MAP]: NUL                                                        [23;1HLibraries [.LIB]:                                                               [24;1HDefinitions File [NUL.DEF]: ;                                                   [25;1H[37m[40m[3;24r[3;1H[3;24r[24;1H






[3;24r[5;1H[1;25r[2;1H[37m[44m                                                              [18;1H                                                                                [19;1HMAKE : warning U4000: 'fixup.exe' : target does not exist                       [20;1H  cl -W3 fixup.c                                                                [21;1HMicrosoft (R) C Optimizing Compiler Version 6.00A                               [22;1HCopyright (c) Microsoft Corp 1984-1990. All rights reserved.                    [23;1H                                                                                [24;1Hfixup.c                                                                         [25;1H[1;1HDefinitions File [NUL.DEF]: ;[3;24Hfixup.exe' : target does not exist [4;10Hfixup.c



fixup.c [13;24Hfixup.obj /farcall [14;11Hfixup.exe]: "fixup.exe" /noi  [19;24Hgetall.exe' : target does not exist[20;10Hgetall.c



getall.c
[3;24Hgetall.exe' : target does not exist[4;10Hgetall.c



getall.c[13;24Hgetall.obj /farcall[14;11Hgetall.exe]: "getall.exe" /noi[19;24Hpci.obj' : target does not exist   [20;7HAL -c -W3 -o pci.obj pci.c



pci.c
[37m[40m[2;22r[2;1H[2;22r[22;1H





[2;22r[3;1H[1;25r[1;1H[37m[44m                             [17;1H                                                                                [18;1Hpci.c                                                                           [19;1H                                                                                [20;1HMAKE : warning U4000: 'pcireg.obj' : target does not exist                      [21;1H  tasm pcireg;                                                                  [22;1HTurbo Assembler  Version 2.0  Copyright (c) 1988, 1990 Borland International    [24;1HAssembling file:   pcireg.ASM
[37m[40m[3;23r[3;1HMMMMMMMMMMMMMMMMMM[1;25r[1;1H[37m[44mMAKE : warning U4000: 'pci.obj' : target does not exist
  cl -AL -c -W3 -o pci.obj pci.c
Microsoft (R) C Optimizing Compiler Version 6.00A                               [4;1HCopyright (c) Microsoft Corp 1984-1990. All rights reserved.                    [5;1H                                                                                [6;1Hpci.c                                                                           [7;1H                                                                                [8;1HMAKE : warning U4000: 'pcireg.obj' : target does not exist                      [9;1H  tasm pcireg;                                                                  [10;1HTurbo Assembler  Version 2.0  Copyright (c) 1988, 1990 Borland International    [11;1H                                                                                [12;1HAssembling file:   pcireg.ASM                                                   [13;1HError messages:    None                                                         [14;1HWarning messages:  None                                                         [15;1HPasses:            1                                                            [16;1HRemaining memory:  324k                                                         [17;1H                                                                                [18;1H                                                                                [19;1HMAKE : warning U4000: 'pci.exe' : target does not exist                         [20;1H  link pci pcireg;                                                              [24;1H
[37m[40m[1;24r[1;1H[1;24r[24;1H






[1;24r[1;1H[1;25r[18;1H[37m[44m                                                                                [19;1HMAKE : warning U4000: 'ihex.exe' : target does not exist                        [20;1H  cl -W3 ihex.c                                                                 [21;1HMicrosoft (R) C Optimizing Compiler Version 6.00A                               [22;1HCopyright (c) Microsoft Corp 1984-1990. All rights reserved.                    [23;1H                                                                                [24;1Hihex.c                                                                          [25;1H[37m[40m[14;18r[14;1HMM[1;25r[1;1H[37m[44m                                                          [2;3H
MAKE : warning U4000: 'pci.exe' : target does not exist                     [4;3Hlink pci pcireg;

Microsoft (R) Segmented-Executable Linker  Version 5.13
Copyright (C) Microsoft Corp 1984-1991.  All rights reserved.
       [12C

MAKE : warning U4000: 'ihex.exe' : target does not exist[11;3Hcl -W3 ihex.c[12;2Hicrosoft (R) C Optimizing Compiler Version 6.00A
Copyright (c) Microsoft Corp 1984-1990. All rights reserved.
                                                                                [15;1Hihex.c                                                                          [19;1H
Object Modules [.OBJ]: ihex.obj /farcall
Run File [ihex.exe]: "ihex.exe" /noi
List File [NUL.MAP]: NUL
Libraries [.LIB]:
Definitions File [NUL.DEF]: ;
[37m[40m[5;11r[5;1HMMMM[1;25r[3;24H[37m[44mihex.exe' : target does not exist[4;3Hcl -W3 ihex.c
Microsoft (R) C Optimizing Compiler Version 6.00A                               [6;1HCopyright (c) Microsoft Corp 1984-1990. All rights reserved.                    [7;1H                                                                                [8;1Hihex.c                                                                          [12;1H
Object Modules [.OBJ]: ihex.obj /farcall
Run File [ihex.exe]: "ihex.exe" /noi
List File [NUL.MAP]: NUL
Libraries [.LIB]:
Definitions File [NUL.DEF]: ;
  CD ..

MAKE : warning U4000: 'ABIOS.OBJ' : target does not exist
  TASM /ml /p /w2 /m2 PBIOS, ABIOS.OBJ, PBIOS.LIS;
Turbo Assembler  Version 2.0  Copyright (c) 1988, 1990 Borland International

Assembling file:   PBIOS.ASM  to  ABIOS.OBJ
[37m[40m[2;21r[2;1H[2;21r[21;1H



[2;21r[3;1H[1;25r[11;1H[37m[44mTurbo Assembler  Version 2.0  Copyright (c) 1988, 1990 Borland International    [12;1H                                                                                [13;1HAssembling file:   PBIOS.ASM  to  ABIOS.OBJ                                     [14;1HError messages:    None                                                         [15;1HWarning messages:  None                                                         [16;1HPasses:            2                                                            [17;1HRemaining memory:  258k                                                         [18;1H                                                                                [19;1H                                                                                [20;1HMAKE : warning U4000: 'BBIOS.OBJ' : target does not exist                       [21;1H  TASM /ml /p /w2 /m2 /DCOM=1 PBIOS, BBIOS.OBJ;                                 [24;35HB
[37m[40m[1;24r[1;1H[1;24r[24;1H







[1;24r[1;1H[1;25r[17;1H[37m[44mError messages:    None                                                         [18;1HWarning messages:  None                                                         [19;1HPasses:            2                                                            [20;1HRemaining memory:  262k                                                         [21;1H                                                                                [22;1H                                                                                [23;1HMAKE : warning U4000: 'ABIOS.BIN' : target does not exist                       [24;1H  LINK/T ABIOS.OBJ, ABIOS.BIN;                                                  [25;1H[37m[40m[6;15r[6;1HMMMMMMM[1;25r[1;1H[37m[44mAssembling file:   PBIOS.ASM  to  ABIOS.OBJ
Error messages:    None
Warning messages:  None
Passes:[12C2
Remaining memory:  258k
                                                                                [7;1H                                                                                [8;1HMAKE : warning U4000: 'BBIOS.OBJ' : target does not exist                       [9;1H  TASM /ml /p /w2 /m2 /DCOM=1 PBIOS, BBIOS.OBJ;                                 [10;1HTurbo Assembler  Version 2.0  Copyright (c) 1988, 1990 Borland International    [11;1H                                                                                [12;1HAssembling file:   PBIOS.ASM  to  BBIOS.OBJ                                     [16;1HRemaining memory:  262k


MAKE : warning U4000: 'ABIOS.BIN' : target does not exist
  LINK/T ABIOS.OBJ, ABIOS.BIN;

Microsoft (R) Segmented-Executable Linker  Version 5.13
Copyright (C) Microsoft Corp 1984-1991.  All rights reserved.[24;3H
[37m[40m[2;5r[2;1HM[1;25r[1;1H[37m[44m
Assembling file:   PBIOS.ASM  to  BBIOS.OBJ                                     [6;1HRemaining memory:  262k


MAKE : warning U4000: 'ABIOS.BIN' : target does not exist
  LINK/T ABIOS.OBJ, ABIOS.BIN;

Microsoft (R) Segmented-Executable Linker  Version 5.13
Copyright (C) Microsoft Corp 1984-1991.  All rights reserved.

       [12C
MAKE : warning U4000: 'PBIOS.COM' : target does not exist[17;3HLINK/T BBIOS.OBJ, PBIOS.COM;[19;2Hicrosoft (R) Segmented-Executable Linker  Version 5.13
Copyright (C) Microsoft Corp 1984-1991.  All rights reserved.


MAKE : warning U4000: 'PBIOS.ROM' : target does not exist    [24;3HTOOLS\FIXUP ABIOS.BIN PBIOS.ROM
[37m[40m[2;24r[2;1H[2;24r[24;1H






[2;24r[3;1H[1;25r[18;1H[37m[44m                                                                                [19;1HMAKE : warning U4000: 'PBIOS.HEX' : target does not exist                       [20;1H  TOOLS\IHEX PBIOS.ROM PBIOS.HEX 0 20 Y                                         [21;1HIHEX V2.00                              Analogic Software Tools                 [22;1H                                                                                [23;1HReading from file PBIOS.ROM,  writing to file PBIOS.HEX ...                     [24;1HStarting address (hex) 0000, block length (hex) 20                              [25;1H[37m[40m[1;25r[1;1H[1;25r[25;1H
[1;25r[1;1H[1;25r[25;1H[37m[44mC:\PBIOS>                                                                      [25;11Hback[37m[40m[m[0m[m[K
(B(B         #
#
#
#
# exit
Script done on Wed Sep 22 16:00:39 2004

Even Linux 32-bit `script` works when I am in VM-86 mode.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

