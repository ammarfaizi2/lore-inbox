Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUBUNEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 08:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUBUNEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 08:04:33 -0500
Received: from scil.sinp.msu.ru ([213.131.0.130]:49638 "EHLO scil.sinp.msu.ru")
	by vger.kernel.org with ESMTP id S261415AbUBUNEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 08:04:32 -0500
Date: Sat, 21 Feb 2004 16:09:18 +0300 (MSK)
From: slack@slackware.ru
X-X-Sender: slack@scil.sinp.msu.ru
To: torvalds@home.osdl.org
Message-ID: <Pine.LNX.4.58.0402211600020.2924@scil.sinp.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As I can see, file was changed by a strange (great?) idea from 2.6.3-rc2
to 2.6.3. Such chages kill any compilation of daemons and progs with
netdb.h and other includes.
As an example, You can try to compile iproute2 package under 2.6.3
(released).

Changed code:
-----------------------------------------------------
diff -r -c include.old/linux/compiler.h include.new/linux/compiler.h
*** include.old/linux/compiler.h        2004-02-10 06:01:02.000000000
+0300
--- include.new/linux/compiler.h        2004-02-18 06:58:34.000000000
+0300
***************
*** 9,14 ****
--- 9,16 ----
  # define __kernel
  #endif

+ #ifdef __KERNEL__
+
  #ifndef __ASSEMBLY__
  #if __GNUC__ > 3
  # include <linux/compiler-gcc+.h>     /* catch-all for GCC 4, 5, etc. */

