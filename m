Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTHWE11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 00:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbTHWE11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 00:27:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:3782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261362AbTHWE1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 00:27:25 -0400
Message-ID: <33070.4.4.25.4.1061612835.squirrel@www.osdl.org>
Date: Fri, 22 Aug 2003 21:27:15 -0700 (PDT)
Subject: selinux build failure
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <linux-ia64@vger.kernel.org>, <sds@epoch.ncsc.mil>, <jmorris@redhat.com>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selinux/hooks.c won't build on ia64.
2.6.0-test3 + ia64 patch or 2.6.0-test4.

security/selinux/hooks.c: In function `selinux_file_fcntl':
security/selinux/hooks.c:2032: error: `F_GETLK64' undeclared (first use in
this function) security/selinux/hooks.c:2033: error: `F_SETLK64' undeclared
(first use in this function) security/selinux/hooks.c:2034: error:
`F_SETLKW64' undeclared (first use in this function)

The __64 versions of these are defined in include/asm-ia64/compat.h. I don't
see a good way to #include asm/compat.h, nor is it available for all
processor architectures.

~Randy



