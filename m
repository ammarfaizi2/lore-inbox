Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSENCow>; Mon, 13 May 2002 22:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315130AbSENCov>; Mon, 13 May 2002 22:44:51 -0400
Received: from zok.SGI.COM ([204.94.215.101]:1718 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315119AbSENCou>;
	Mon, 13 May 2002 22:44:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thomas Duffy <tduffy@directvinternet.com>
Cc: Kbuild Devel <kbuild-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, Release 2.4 is available 
In-Reply-To: Your message of "13 May 2002 17:12:08 MST."
             <1021335128.25750.23.camel@tduffy-lnx.afara.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 May 2002 12:44:31 +1000
Message-ID: <6641.1021344271@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2002 17:12:08 -0700, 
Thomas Duffy <tduffy@directvinternet.com> wrote:
>ok, kbuild-2.5-sparc64-2.5.15-1 is ready.

Does it still need sparc64 hacks or is the base 2.5.15 kernel clean for
sparc64?

>  CC drivers/scsi/aic7xxx/aic7xxx_core.o
>pp_makefile5: stat (drivers/scsi/aic7xxx/aic7xxx_seq.h) failed: No such file or directory
>pp_makefile5: dependencies (pid 15566) returned 1

Did not show up in my testing, it was hidden by out of order compiles
with -j4.  Will be in common-2.5.15-3.

diff -ur 2.5.15-kbuild-2.5/drivers/scsi/aic7xxx/Makefile.in 2.5.15-kbuild-2.5.new/drivers/scsi/aic7xxx/Makefile.in
--- 2.5.15-kbuild-2.5/drivers/scsi/aic7xxx/Makefile.in	Tue May 14 12:38:47 2002
+++ 2.5.15-kbuild-2.5.new/drivers/scsi/aic7xxx/Makefile.in	Tue May 14 12:37:20 2002
@@ -19,9 +19,9 @@
 
 extra_cflags_all($(src_includelist /drivers/scsi))
 
-# Only aic7xxx.c includes aic7xxx_seq.h.
+# Only aic7xxx_core.c includes aic7xxx_seq.h.
 
-$(objfile aic7xxx.o): $(objfile aic7xxx_seq.h)
+$(objfile aic7xxx_core.o): $(objfile aic7xxx_seq.h)
 
 # aic7xxx_reg.h is messy.  It is included by aic7xxx.h which is included by
 # aic7xxx_osm.h which is included by several .c files.  Play safe and make all

