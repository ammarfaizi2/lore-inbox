Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSGFIdU>; Sat, 6 Jul 2002 04:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSGFIdT>; Sat, 6 Jul 2002 04:33:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:58120 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317623AbSGFIdT>;
	Sat, 6 Jul 2002 04:33:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [Bug] 2.5.25 build as one user and install as root
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jul 2002 18:35:46 +1000
Message-ID: <29475.1025944546@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.25 existing build system has a nasty bug.  Build as one user then
make install as root.  It does supurious recompiles of some files and
leaves them owned as root.  All of these files are now owned by root
and cause problems when the build user wants to rebuild.

arch/i386/boot/compressed/vmlinux.bin
arch/i386/boot/compressed/piggy.o
arch/i386/boot/compressed/vmlinux
arch/i386/boot/.setup.o.cmd
arch/i386/boot/setup.o
arch/i386/boot/setup
arch/i386/boot/vmlinux.bin
include/linux/compile.h
init/.version.o.cmd
init/version.o
init/init.o
.version
vmlinux

Not a problem for kbuild 2.5 of course, it checks and aborts if
installing as root would require recompiles.

