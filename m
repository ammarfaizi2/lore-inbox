Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264967AbUELE2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264967AbUELE2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 00:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264969AbUELE2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 00:28:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:12265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264967AbUELE2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 00:28:34 -0400
Date: Tue, 11 May 2004 21:26:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: fastboot@lists.osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] kexec for linux 2.6.6
Message-Id: <20040511212625.28ac33ef.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kexec for Linux 2.6.6 is now available at:
http://developer.osdl.org/rddunlap/kexec/2.6.6/


kexec userspace tools are at:
http://developer.osdl.org/rddunlap/kexec/kexec-tools/


For 2.6.6, the kexec_load syscall number had to move due to
some new syscall additions in 2.6.6.  However, I didn't
update the kexec userspace program for that 1-line change.
The change is in kexec-syscall.c, line 46:

change
#define __NR_kexec_load 274
to
#define __NR_kexec_load 283

(for i386).

There is one outstanding patch from Albert Herranz
that I will review and possibly use/merge soon.
His email is here:
  http://lists.osdl.org/pipermail/fastboot/2004-May/000290.html


And if anyone has suggestions for handling a variable/moving
syscall number (target), I'm interested in hearing them.

--
~Randy
