Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRBEAIA>; Sun, 4 Feb 2001 19:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132427AbRBEAHv>; Sun, 4 Feb 2001 19:07:51 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:8200 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132392AbRBEAHg>; Sun, 4 Feb 2001 19:07:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: modversions.h source pollution in 2.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Feb 2001 11:07:19 +1100
Message-ID: <26206.981331639@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following files explicitly include linux/modversions.h.  They
should not do this, the Makefiles are responsible for automatically
including modversions.h.  Since modversions.h will disappear in 2.5,
consider this advance warning that the offending sources can expect
problems.

Maintainers: please fix these sources by removing modversions.h.

arch/ia64/kernel/palinfo.c
drivers/char/amiserial.c
drivers/char/dtlk.c
drivers/char/ip2.c
drivers/char/ip2main.c
drivers/char/rocket.c
drivers/char/serial.c
drivers/md/lvm.c
drivers/net/eepro100.c
drivers/net/epic100.c
drivers/net/starfire.c
drivers/net/wan/lmc/lmc_main.c

The presence of symbols like foo__ver_foo is not a reason to explicitly
include modversions.h, see http://www.tux.org/lkml/#s8-8.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
