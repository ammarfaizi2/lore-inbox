Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131355AbRAaUsX>; Wed, 31 Jan 2001 15:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132670AbRAaUsO>; Wed, 31 Jan 2001 15:48:14 -0500
Received: from tiger.nscl.msu.edu ([35.8.33.207]:49794 "EHLO
	tiger.nscl.msu.edu") by vger.kernel.org with ESMTP
	id <S131355AbRAaUsG>; Wed, 31 Jan 2001 15:48:06 -0500
From: Eric Kasten <kasten@nscl.msu.edu>
Message-Id: <200101312044.PAA11405@tiger.nscl.msu.edu>
Subject: BUG: v2.4.1 missing EXPORT_SYMBOL
To: linux-kernel@vger.kernel.org
Date: Wed, 31 Jan 2001 15:44:29 -0500 (EST)
Reply-To: kasten@nscl.msu.edu
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quick bug report for kernel 2.4.1.  There needs to be a
EXPORT_SYMBOL(name_to_kdev_t); at the bottom of linux/init/main.c.
name_to_kdev_t is used by the md driver (and maybe others).  If the
driver is built as a module it won't load due to the missing symbol.

...Eric

Eric Kasten
kasten@nscl.msu.edu
National Superconducting Cyclotron Lab
(517) 333-6412
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
