Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSKEAbF>; Mon, 4 Nov 2002 19:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263081AbSKEAbF>; Mon, 4 Nov 2002 19:31:05 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:61325 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262937AbSKEAbD>; Mon, 4 Nov 2002 19:31:03 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 4 Nov 2002 16:43:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
In-Reply-To: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211041642530.1745-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just FYI :


[root@blue1 linux-2.5.46.epoll]# make bzImage
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (unchanged)
make -f scripts/Makefile.build obj=usr
objcopy -I binary -O elf32-i386 -B i386 \
        --rename-section .data=.init.initramfs \
        usr/initramfs_data.cpio.gz usr/initramfs_data.o
objcopy: invalid option -- B
Usage: objcopy <switches> in-file [out-file]
 The switches are:
  -I --input-target <bfdname>      Assume input file is in format
<bfdname>
  -O --output-target <bfdname>     Create an output file in format
<bfdname>
  -F --target <bfdname>            Set both input and output format to
<bfdname>
     --debugging                   Convert debugging information, if
possible
  -p --preserve-dates              Copy modified/access timestamps to the
output
  -j --only-section <name>         Only copy section <name> into the
output
  -R --remove-section <name>       Remove section <name> from the output
  -S --strip-all                   Remove all symbol and relocation
information
  -g --strip-debug                 Remove all debugging symbols
     --strip-unneeded              Remove all symbols not needed by
relocations
  -N --strip-symbol <name>         Do not copy symbol <name>
  -K --keep-symbol <name>          Only copy symbol <name>
  -L --localize-symbol <name>      Force symbol <name> to be marked as a
local
  -W --weaken-symbol <name>        Force symbol <name> to be marked as a
weak
     --weaken                      Force all global symbols to be marked
as weak
  -x --discard-all                 Remove all non-global symbols
  -X --discard-locals              Remove any compiler-generated symbols
  -i --interleave <number>         Only copy one out of every <number>
bytes
  -b --byte <num>                  Select byte <num> in every interleaved
block
     --gap-fill <val>              Fill gaps between sections with <val>
     --pad-to <addr>               Pad the last section up to address
<addr>
     --set-start <addr>            Set the start address to <addr>
    {--change-start|--adjust-start} <incr>
                                   Add <incr> to the start address
    {--change-addresses|--adjust-vma} <incr>
                                   Add <incr> to LMA, VMA and start
addresses
    {--change-section-address|--adjust-section-vma} <name>{=|+|-}<val>
                                   Change LMA and VMA of section <name> by
<val>
     --change-section-lma <name>{=|+|-}<val>
                                   Change the LMA of section <name> by
<val>
     --change-section-vma <name>{=|+|-}<val>
                                   Change the VMA of section <name> by
<val>
    {--[no-]change-warnings|--[no-]adjust-warnings}
                                   Warn if a named section does not exist
     --set-section-flags <name>=<flags>
                                   Set section <name>'s properties to
<flags>
     --add-section <name>=<file>   Add section <name> found in <file> to
output
     --change-leading-char         Force output format's leading character
style
     --remove-leading-char         Remove leading character from global
symbols
     --redefine-sym <old>=<new>    Redefine symbol name <old> to <new>
     --srec-len <number>           Restrict the length of generated
Srecords
     --srec-forceS3                Restrict the type of generated Srecords
to S3
  -v --verbose                     List all object files modified
  -V --version                     Display this program's version number
  -h --help                        Display this output
objcopy: supported targets: elf32-i386 a.out-i386-linux efi-app-ia32
elf32-little elf32-big srec symbolsrec tekhex binary ihex trad-core
make[1]: *** [usr/initramfs_data.o] Error 1
make: *** [usr] Error 2




- Davide


