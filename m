Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFFMyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 08:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTFFMyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 08:54:20 -0400
Received: from node-d-5886.a2000.nl ([62.195.88.134]:38018 "HELO
	mail.alinoe.com") by vger.kernel.org with SMTP id S261365AbTFFMyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 08:54:18 -0400
Date: Fri, 6 Jun 2003 15:07:47 +0200
From: Carlo Wood <carlo@alinoe.com>
To: spse@secret.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Compile error blkmtd.c, v2.5.70 (and smaller)
Message-ID: <20030606130747.GA9861@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.5.70,

drivers/mtd/devices/blkmtd.c

still contains

#include <linux/iobuf.h>

reason enough not to compile...
that file was removed from 2.5.

I am suprised that this file was apparently never compiled by people :/



Commands used to backup/check my statement:

/usr/src/linux-2.5.69>grep -Hn iobuf.h drivers/mtd/devices/blkmtd.c
drivers/mtd/devices/blkmtd.c:52:#include <linux/iobuf.h>

/usr/src/linux-2.5.69>find . -type f -exec grep -H 'iobuf\.h' {} \;
./drivers/mtd/devices/blkmtd.c:#include <linux/iobuf.h>

/usr/src/linux-2.5.69>find . -name 'iobuf.h'
/usr/src/linux-2.5.69>find . -name '*iobuf*'
/usr/src/linux-2.5.69>

/usr/src/linux-2.5.69>locate iobuf.h | grep '2\.4'
/usr/src/jolan/linux-2.4.20/include/linux/iobuf.h
/usr/src/linux-2.4.20-tcore-akpm-preempt/include/linux/iobuf.h
/usr/src/linux-2.4.18-tcore-perfctr/include/linux/iobuf.h
/usr/src/linux-2.4.20-plain/include/linux/iobuf.h
/usr/src/linux-2.4.20-skas3/include/linux/iobuf.h

/usr/src/linux-2.5.69>tar tjf ../kernel/linux-2.5.69.tar.bz2 | grep 'iobuf\.h'
/usr/src/linux-2.5.69>

/usr/src/linux-2.5.69>tar tvjf ../kernel/linux-2.5.69.tar.bz2 | grep 'blkmtd\.c'
-rw-r--r-- torvalds/torvalds   36273 2003-05-05 01:52:59 linux-2.5.69/drivers/mtd/devices/blkmtd.c

/usr/src/linux-2.5.69>ls -l drivers/mtd/devices/blkmtd.c
-rw-r--r--    1 carlo    carlo       36273 May  5 01:52 drivers/mtd/devices/blkmtd.c

/usr/src/linux-2.5.69>bzcat ../kernel/patch-2.5.70.bz2 | grep blkmtd
/usr/src/linux-2.5.69>

-- 
Carlo Wood <carlo@alinoe.com>
