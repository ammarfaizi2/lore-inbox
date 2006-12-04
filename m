Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758383AbWLDDZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383AbWLDDZc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 22:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759217AbWLDDZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 22:25:32 -0500
Received: from havoc.gtf.org ([69.61.125.42]:1159 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1758383AbWLDDZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 22:25:31 -0500
Date: Sun, 3 Dec 2006 22:25:26 -0500
From: Jeff Garzik <jeff@garzik.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [git patch] remove ftape
Message-ID: <20061204032526.GA14766@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[just pushed this to Andrew and Linus]

As scheduled, remove long-unmaintained ftape driver subsystem.

It's bitrotten, long unmaintained, long hidden under BROKEN_ON_SMP,
etc.  As scheduled in feature-removal-schedule.txt, and ack'd several
times on lkml.

Please pull from 'ftape-remove' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git ftape-remove

to receive the following updates:

 Documentation/00-INDEX                          |    2 
 Documentation/feature-removal-schedule.txt      |    8 
 Documentation/ftape.txt                         |  307 -----
 Documentation/kernel-parameters.txt             |    3 
 MAINTAINERS                                     |    5 
 drivers/char/Kconfig                            |   33 -
 drivers/char/Makefile                           |    1 
 drivers/char/ftape/Kconfig                      |  330 -----
 drivers/char/ftape/Makefile                     |   28 
 drivers/char/ftape/README.PCI                   |   81 -
 drivers/char/ftape/RELEASE-NOTES                |  966 ----------------
 drivers/char/ftape/compressor/Makefile          |   31 -
 drivers/char/ftape/compressor/lzrw3.c           |  743 ------------
 drivers/char/ftape/compressor/lzrw3.h           |  253 ----
 drivers/char/ftape/compressor/zftape-compress.c | 1203 --------------------
 drivers/char/ftape/compressor/zftape-compress.h |   83 -
 drivers/char/ftape/lowlevel/Makefile            |   43 -
 drivers/char/ftape/lowlevel/fc-10.c             |  175 ---
 drivers/char/ftape/lowlevel/fc-10.h             |   39 -
 drivers/char/ftape/lowlevel/fdc-io.c            | 1349 ----------------------
 drivers/char/ftape/lowlevel/fdc-io.h            |  252 ----
 drivers/char/ftape/lowlevel/fdc-isr.c           | 1170 -------------------
 drivers/char/ftape/lowlevel/fdc-isr.h           |   55 -
 drivers/char/ftape/lowlevel/ftape-bsm.c         |  491 --------
 drivers/char/ftape/lowlevel/ftape-bsm.h         |   66 -
 drivers/char/ftape/lowlevel/ftape-buffer.c      |  130 --
 drivers/char/ftape/lowlevel/ftape-buffer.h      |   32 -
 drivers/char/ftape/lowlevel/ftape-calibr.c      |  275 ----
 drivers/char/ftape/lowlevel/ftape-calibr.h      |   37 -
 drivers/char/ftape/lowlevel/ftape-ctl.c         |  896 ---------------
 drivers/char/ftape/lowlevel/ftape-ctl.h         |  162 ---
 drivers/char/ftape/lowlevel/ftape-ecc.c         |  853 --------------
 drivers/char/ftape/lowlevel/ftape-ecc.h         |   84 -
 drivers/char/ftape/lowlevel/ftape-format.c      |  344 ------
 drivers/char/ftape/lowlevel/ftape-format.h      |   37 -
 drivers/char/ftape/lowlevel/ftape-init.c        |  160 ---
 drivers/char/ftape/lowlevel/ftape-init.h        |   43 -
 drivers/char/ftape/lowlevel/ftape-io.c          |  992 ----------------
 drivers/char/ftape/lowlevel/ftape-io.h          |   90 -
 drivers/char/ftape/lowlevel/ftape-proc.c        |  214 ---
 drivers/char/ftape/lowlevel/ftape-proc.h        |   35 -
 drivers/char/ftape/lowlevel/ftape-read.c        |  621 ----------
 drivers/char/ftape/lowlevel/ftape-read.h        |   51 -
 drivers/char/ftape/lowlevel/ftape-rw.c          | 1092 ------------------
 drivers/char/ftape/lowlevel/ftape-rw.h          |  111 --
 drivers/char/ftape/lowlevel/ftape-setup.c       |  104 --
 drivers/char/ftape/lowlevel/ftape-tracing.c     |  118 --
 drivers/char/ftape/lowlevel/ftape-tracing.h     |  179 ---
 drivers/char/ftape/lowlevel/ftape-write.c       |  336 -----
 drivers/char/ftape/lowlevel/ftape-write.h       |   53 -
 drivers/char/ftape/lowlevel/ftape_syms.c        |   87 -
 drivers/char/ftape/zftape/Makefile              |   36 -
 drivers/char/ftape/zftape/zftape-buffers.c      |  149 --
 drivers/char/ftape/zftape/zftape-buffers.h      |   55 -
 drivers/char/ftape/zftape/zftape-ctl.c          | 1417 -----------------------
 drivers/char/ftape/zftape/zftape-ctl.h          |   58 -
 drivers/char/ftape/zftape/zftape-eof.c          |  199 ---
 drivers/char/ftape/zftape/zftape-eof.h          |   52 -
 drivers/char/ftape/zftape/zftape-init.c         |  377 ------
 drivers/char/ftape/zftape/zftape-init.h         |   77 -
 drivers/char/ftape/zftape/zftape-read.c         |  377 ------
 drivers/char/ftape/zftape/zftape-read.h         |   53 -
 drivers/char/ftape/zftape/zftape-rw.c           |  375 ------
 drivers/char/ftape/zftape/zftape-rw.h           |  101 --
 drivers/char/ftape/zftape/zftape-vtbl.c         |  757 ------------
 drivers/char/ftape/zftape/zftape-vtbl.h         |  227 ----
 drivers/char/ftape/zftape/zftape-write.c        |  483 --------
 drivers/char/ftape/zftape/zftape-write.h        |   38 -
 drivers/char/ftape/zftape/zftape_syms.c         |   43 -
 include/linux/Kbuild                            |    4 
 include/linux/ftape-header-segment.h            |  122 --
 include/linux/ftape-vendors.h                   |  137 --
 include/linux/ftape.h                           |  201 ---
 include/linux/zftape.h                          |   87 -
 74 files changed, 0 insertions(+), 20278 deletions(-)
 delete mode 100644 Documentation/ftape.txt
 delete mode 100644 drivers/char/ftape/Kconfig
 delete mode 100644 drivers/char/ftape/Makefile
 delete mode 100644 drivers/char/ftape/README.PCI
 delete mode 100644 drivers/char/ftape/RELEASE-NOTES
 delete mode 100644 drivers/char/ftape/compressor/Makefile
 delete mode 100644 drivers/char/ftape/compressor/lzrw3.c
 delete mode 100644 drivers/char/ftape/compressor/lzrw3.h
 delete mode 100644 drivers/char/ftape/compressor/zftape-compress.c
 delete mode 100644 drivers/char/ftape/compressor/zftape-compress.h
 delete mode 100644 drivers/char/ftape/lowlevel/Makefile
 delete mode 100644 drivers/char/ftape/lowlevel/fc-10.c
 delete mode 100644 drivers/char/ftape/lowlevel/fc-10.h
 delete mode 100644 drivers/char/ftape/lowlevel/fdc-io.c
 delete mode 100644 drivers/char/ftape/lowlevel/fdc-io.h
 delete mode 100644 drivers/char/ftape/lowlevel/fdc-isr.c
 delete mode 100644 drivers/char/ftape/lowlevel/fdc-isr.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-bsm.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-bsm.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-buffer.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-buffer.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-calibr.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-calibr.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-ctl.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-ctl.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-ecc.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-ecc.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-format.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-format.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-init.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-init.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-io.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-io.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-proc.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-proc.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-read.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-read.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-rw.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-rw.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-setup.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-tracing.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-tracing.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-write.c
 delete mode 100644 drivers/char/ftape/lowlevel/ftape-write.h
 delete mode 100644 drivers/char/ftape/lowlevel/ftape_syms.c
 delete mode 100644 drivers/char/ftape/zftape/Makefile
 delete mode 100644 drivers/char/ftape/zftape/zftape-buffers.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-buffers.h
 delete mode 100644 drivers/char/ftape/zftape/zftape-ctl.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-ctl.h
 delete mode 100644 drivers/char/ftape/zftape/zftape-eof.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-eof.h
 delete mode 100644 drivers/char/ftape/zftape/zftape-init.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-init.h
 delete mode 100644 drivers/char/ftape/zftape/zftape-read.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-read.h
 delete mode 100644 drivers/char/ftape/zftape/zftape-rw.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-rw.h
 delete mode 100644 drivers/char/ftape/zftape/zftape-vtbl.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-vtbl.h
 delete mode 100644 drivers/char/ftape/zftape/zftape-write.c
 delete mode 100644 drivers/char/ftape/zftape/zftape-write.h
 delete mode 100644 drivers/char/ftape/zftape/zftape_syms.c
 delete mode 100644 include/linux/ftape-header-segment.h
 delete mode 100644 include/linux/ftape-vendors.h
 delete mode 100644 include/linux/ftape.h
 delete mode 100644 include/linux/zftape.h

Jeff Garzik:
      Remove long-unmaintained ftape driver subsystem.

