Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313096AbSDGLBx>; Sun, 7 Apr 2002 07:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313093AbSDGLBw>; Sun, 7 Apr 2002 07:01:52 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:42764 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313098AbSDGLBu>;
	Sun, 7 Apr 2002 07:01:50 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre6 dead Makefile entries
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Apr 2002 21:01:39 +1000
Message-ID: <27694.1018177299@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The more rigorous error checking in kbuild 2.5 found several Makefile
entries for objects that have no source.   kbuild 2.4 silently ignores
objects that it cannot build, allowing errors to sneak through.

These are typing errors or they are dead entries.  In either case they
need to be cleaned up, by removing the entry from the Makefile or by
supplying the missing source.  After removing the entries, also verify
if the CONFIG_ entry is still required and remove that as well if it is
obsolete.

Makefile			Object with no source

drivers/acorn/char/Makefile     keyb_l7200.o

drivers/acpi/Makefile           osconf.o

drivers/char/Makefile           serial_sa1100.o

drivers/ide/Makefile            pdcadma.o

drivers/isdn/Makefile           isdn_dwabc.o

drivers/net/Makefile            veth.o

drivers/usb/storage/Makefile    shuttle_sm.o
                                shuttle_cf.o

drivers/video/Makefile          dcfb.o
                                fbcon-iplan2p16.o

fs/nls/Makefile                 nls_cp1252.o
                                nls_cp1253.o
                                nls_cp1254.o
                                nls_cp1256.o
                                nls_cp1257.o
                                nls_cp1258.o
                                nls_iso8859_10.o
                                nls_abc.o

lib/Makefile                    crc32.o

net/decnet/Makefile             dn_fw.o

net/sched/Makefile              sch_hpfq.o
                                sch_hfsc.o

