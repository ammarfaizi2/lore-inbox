Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWJKL0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWJKL0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWJKL0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:26:00 -0400
Received: from [195.171.73.133] ([195.171.73.133]:6867 "EHLO
	pelagius.h-e-r-e-s-y.com") by vger.kernel.org with ESMTP
	id S1030341AbWJKLZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:25:59 -0400
Date: Wed, 11 Oct 2006 11:25:58 +0000
From: andrew@walrond.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 intermittent parallel build failure
Message-ID: <20061011112558.GA23147@pelagius.h-e-r-e-s-y.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the kernel on a Sun T1000 ( Niagra - 6 cores/24
threads) with

	make -j12

I occasionally see failures like:

  CC      drivers/net/pppox.mod.o
  CC      drivers/net/r8169.mod.o
  CC      drivers/net/sk98lin/sk98lin.mod.o
  CC      drivers/net/skge.mod.o
  CC      drivers/net/slhc.mod.o
gcc: no input files
make[1]: *** [drivers/net/slhc.mod.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [modules] Error 2

Restarting the make command completes the build successfully.

I am using the latest make 3.81 (which had a scary list of BACKWARDS
COMPATIBILITY warnings in the NEWS file) in case that might be
relevant.

Hope thats useful

Andrew Walrond
