Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933156AbWKSUWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbWKSUWA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933157AbWKSUWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:22:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:16349 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S933156AbWKSUV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:21:59 -0500
Date: Sun, 19 Nov 2006 20:21:51 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.34-pre6
Message-ID: <20061119202151.GA25104@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's Linux 2.4.34-pre6.

Location: ftp://ftp.kernel.org/pub/linux/kernel/v2.4/testing/

Mostly cleanupts this time, as well as fixes for a few "&& 0xff"
typos. As I receivedthe RAM for my Alpha, I could attempt a few
builds with gcc-4.1 and fix 4 obvious problems (lvalue casts).
However, there are other problems somewhere else as the system
seems to hang on a pipe within the init scripts. I merged the
build fixes anyway so that people with more time can try to
chase the bugs down if they want.

Next version will be -rc1 and if everything goes well, I expect
to release 2.4.34 by the end of the year.

Regards,
Willy

Summary of changes from v2.4.34-pre5 to v2.4.34-pre6
============================================

Jean Delvare (5):
      [PATCH][I2C] update web site address and contacts
      [PATCH][I2C] do not ignore error when returning from i2c_add_adapter()
      [PATCH][I2C] i2c-matroxfb: Struct init conversion
      [PATCH][I2C] Fix copy-n-paste error in i2c Config.in.
      [PATCH][I2C] remove non-existing functions declarations.

NeilBrown (1):
      knfsd: Fix race that can disable NFS server.

Willy Tarreau (12):
      [PATCH-2.4] i2c-elv: fix erroneous '&&' operator
      fix "&& 0xffff" typo in gdth.c
      fix obvious "&& 0xFFFFFF" typo in cpqfcTSworker
      fix "&& 0xff" typo in qeth_qdio_input_handler
      fix two "&& 0x03" in usbnet
      EXT3: avoid crashing by not dividing by zero.
      EXT2: avoid crashing by not dividing by zero.
      [GCC4] fix build error in arch/alpha/kernel/osf_sys.c
      [GCC4] fix build error in arch/alpha/kernel/irq.c
      [GCC4] fix build error in arch/alpha/lib/io.c
      [GCC4] fix build error in arch/alpha/math-emu/math.c
      Change VERSION to 2.4.34-pre6

