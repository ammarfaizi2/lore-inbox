Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTDRVBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTDRVBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:01:05 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:19986
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263250AbTDRVBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:01:01 -0400
Subject: mknod64(1)
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com
Content-Type: text/plain
Message-Id: <1050700383.745.48.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 18 Apr 2003 17:13:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I wrote a mknod64(1) tool, so we can play with 64-bit device
numbers.  It is available at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/mknod64

for testing.  And that is really its whole purpose because I see no
reason why the mknod in coreutils will not eventually support
mknod64(2).

But for now this version works and supports the 64-bit dev_t with a
32:32 split.  It is also identical in functionality to mknod(1), except
it does not support an initial mode other than the default (i.e., no
--mode option).

Installation is simple but RPM packages are also available.

Usage is the same as mknod, except you may specify a 32-bit value for
the major and the minor device number.

This currently requires 2.5.67-mm4, but I suspect the 64-bit dev_t work
will eventually make its way into Linus's tree.

Note that most utilities cannot see the 64-bit device numbers, i.e.
ls(1) only displays 8-bits of each.  You can do a homemade stat64() or
just trust the code.

With the above kernel and this utility, you can play with 64-bit device
numbers.  Enjoy.

	Robert Love


