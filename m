Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSLARjy>; Sun, 1 Dec 2002 12:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbSLARjx>; Sun, 1 Dec 2002 12:39:53 -0500
Received: from gbmail.cc.gettysburg.edu ([138.234.4.100]:41691 "EHLO
	gettysburg.edu") by vger.kernel.org with ESMTP id <S262296AbSLARjw>;
	Sun, 1 Dec 2002 12:39:52 -0500
Date: Sun, 1 Dec 2002 12:47:06 -0500
To: linux-kernel@vger.kernel.org
Cc: venom@sns.it
Subject: Re: asm/io_apic.h is missing in drivers/pci/quirks.c with kernel 2.5.50
Message-ID: <20021201174706.GA595@perseus.homeunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan's patch:

+ extern int sis_apic_bug;

will work; however, adding #include <asm/io_apic.h> will cause the
following on 2.5.50:

include/asm/mpspec.h:203: error: `NR_CPUS' undeclared here (not in a
function)
include/asm/io_apic.h:51: error: `MAX_IO_APICS' undeclared here (not in
a function)
include/asm/fixmap.h:49: error: `FIX_IO_APIC_BASE_0' used prior to
declaration.

Just wanted to be sure people applied the right patch.

Justin
