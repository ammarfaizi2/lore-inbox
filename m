Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUI2RZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUI2RZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUI2RZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:25:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:5838 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268652AbUI2RWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:22:42 -0400
Subject: 1 New compile/sparse warning (overnight build)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096478522.20465.11.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 29 Sep 2004 10:22:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sparse warning was introduced with patch 1.2000 (axboe).
In fs/bio.c (line 509),

	if (copy_from_user(addr, (char *) p, bvec->bv_len))

should probably be

	if (copy_from_user(addr, (char __user *) p, bvec->bv_len))

John

--------------------------------------------------------------

Compiler: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Arch: i386


Summary:
   New warnings = 1
   Fixed warnings = 3

New warnings:
-------------
fs/bio.c:509:30: warning: incorrect type in argument 2 (different
address spaces)
fs/bio.c:509:30:    expected void const [noderef] *from<asn:1>
fs/bio.c:509:30:    got char *<noident>


Fixed warnings:
---------------
fs/bio.c:392:20: warning: incorrect type in argument 1 (different
address spaces)
fs/bio.c:392:20:    expected void [noderef] *to<asn:1>
fs/bio.c:392:20:    got char *uaddr

fs/bio.c:462:31: warning: incorrect type in argument 2 (different
address spaces)
fs/bio.c:462:31:    expected void const [noderef] *from<asn:1>
fs/bio.c:462:31:    got char *<noident>

kernel/sys.c:1737:34: warning: incorrect type in argument 2 (different
address spaces)
kernel/sys.c:1737:34:    expected char const [noderef] *src<asn:1>
kernel/sys.c:1737:34:    got char *<noident>



