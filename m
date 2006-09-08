Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWIHXyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWIHXyd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 19:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWIHXyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 19:54:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:28113 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751298AbWIHXyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 19:54:32 -0400
X-Authenticated: #24128601
Date: Sat, 9 Sep 2006 01:53:21 +0200
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17.2 doesn't compile: "In function `dm_put':: undefined reference to `idr_replace'" with gcc 4.1.1
Message-ID: <20060908235321.GA365@section_eight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

just wanted to be the first to mention this :-)

I use dm-crypt (luks), 2.6.17.11 compiled fine.

  AS      arch/i386/lib/putuser.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `dm_put':
: undefined reference to `idr_replace'
drivers/built-in.o: In function `create_aux':
dm.c:(.text+0x99e6e): undefined reference to `idr_replace'
make: *** [.tmp_vmlinux1] Error 1

section_eight scripts # ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux section_eight 2.6.17.11 #1 Wed Sep 6 14:40:42 CEST 2006 i686 AMD
Sempron(tm)   2400+ GNU/Linux

Gnu C                  4.1.1
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         rt61 lirc_serial lirc_dev

It's the first time a kernel doesn't compile for me :) Keep up the good
work!

Cheers
Sebastian
