Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265582AbTFRWie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbTFRWie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:38:34 -0400
Received: from palrel11.hp.com ([156.153.255.246]:62693 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265582AbTFRWhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:37:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.60671.410179.275282@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 15:51:43 -0700
To: linux-kernel@vger.kernel.org
Cc: roland@redhat.com, Sam Ravnborg <sam@ravnborg.org>, davidm@hpl.hp.com
Subject: Re: common name for the kernel DSO
In-Reply-To: <20030618203247.GA14124@mars.ravnborg.org>
References: <16112.47509.643668.116939@napali.hpl.hp.com>
	<20030618203247.GA14124@mars.ravnborg.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 22:32:47 +0200, Sam Ravnborg <sam@ravnborg.org> said:

  Sam> so my vote goes for the gate name.

Attached is a small patch which will at least make sure that the DSO
name is the same across platforms.

Is someone willing to shepherd this patch into the official 2.5 tree?

	--david

===== arch/i386/kernel/Makefile 1.44 vs edited =====
--- 1.44/arch/i386/kernel/Makefile	Sun Jun  8 11:06:55 2003
+++ edited/arch/i386/kernel/Makefile	Wed Jun 18 15:47:48 2003
@@ -47,7 +47,7 @@
       cmd_syscall = $(CC) -nostdlib $(SYSCFLAGS_$(@F)) \
 		          -Wl,-T,$(filter-out FORCE,$^) -o $@
 
-vsyscall-flags = -shared -s -Wl,-soname=linux-vsyscall.so.1
+vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1
 SYSCFLAGS_vsyscall-sysenter.so	= $(vsyscall-flags)
 SYSCFLAGS_vsyscall-int80.so	= $(vsyscall-flags)
 
