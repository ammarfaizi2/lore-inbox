Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTJLNKh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 09:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTJLNKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 09:10:36 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:22997 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263448AbTJLNKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 09:10:36 -0400
Date: Sun, 12 Oct 2003 15:10:28 +0200 (MEST)
Message-Id: <200310121310.h9CDASEI006119@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: non-modular 2.6 ppc kernels miscompiled by gcc-3.3.1?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I compile a non-modular 2.6 kernel for ppc with gcc-3.3.1,
it oopses in __copy_tofrom_user() [copy_mount_options()] in
user-space's first mount /proc call. User-space limps along
for a while, oopsing in every mount call, and then hangs.

This occurs with 2.6.0-test5, test6, and the test7-based
linuxppc-2.5 tree (rsync:ed today).

Enabling CONFIG_MODULES=y but still keeping everything built-in
prevents the oopses.

With gcc-3.2.3 there are no problems.

I don't have a serial console to the ppc box (weird mac serial
port), but I can try to manually type down and decode the first
oops if necessary.

/Mikael
