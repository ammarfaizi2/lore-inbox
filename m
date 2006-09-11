Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWIKWp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWIKWp1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIKWp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:45:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751022AbWIKWp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:45:26 -0400
Date: Mon, 11 Sep 2006 15:45:20 -0700
From: Judith Lebzelter <judith@osdl.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: 2.6.18-rc6-mm1 'uio_read' redefined, breaks allyesconfig on i386
Message-ID: <20060911224520.GJ9335@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I noticed in the 'allyesconfig' build for i386 is not working for 2.6.18-rc6-mm1.
The function 'uio_read' in gregkh-driver-uio.patch has the same name as a 
function in fs/xfs/support/move.c.  Here is the error message:

  LD      drivers/w1/built-in.o
  LD      drivers/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x6eb597): In function `uio_read':
drivers/uio/uio_dev.c:59: multiple definition of `uio_read'
fs/built-in.o(.text+0x2f4ee8):fs/xfs/support/move.c:26: first defined here
i686-unknown-linux-gnu-ld: Warning: size of symbol `uio_read' changed from 123 in fs/built-in.o to 397 in drivers/built-in.o
make: [.tmp_vmlinux1] Error 1 (ignored)
  KSYM    .tmp_kallsyms1.S
i686-unknown-linux-gnu-nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: [.tmp_kallsyms1.S] Error 1 (ignored)

WKR,
Judith Lebzelter
OSDL
