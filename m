Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVCNTnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVCNTnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCNTkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:40:53 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12929 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261772AbVCNTjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:39:54 -0500
Subject: 2.6.11-bk10 build problems
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kai@germaschewski.name, sam@ravnborg.org
Content-Type: text/plain
Date: Mon, 14 Mar 2005 11:39:37 -0800
Message-Id: <1110829177.19340.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some intermittent build problems on 2.6.11-bk10.  First of
all, doing a 'make -j8 O=... install' errors out not being able to find
a vmlinux:

$ make O=../mhp-build/i386-plain/ -j8 install
make[3]: *** No rule to make target `vmlinux', needed by
`arch/i386/boot/compressed/vmlinux.bin'.  Stop.
make[2]: *** [arch/i386/boot/compressed/vmlinux] Error 2
make[1]: *** [install] Error 2
make: *** [install] Error 2

Also, I just ran menuconfig, changed an option, and did another 'make
install', and it went straight to the install script with no
compiling.  

Note that these are with O=, so it might be just a separate build tree
problem.

Any ideas?

-- Dave

