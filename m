Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTHVPxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTHVPxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:53:12 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:16795 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263343AbTHVPxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:53:08 -0400
Date: Fri, 22 Aug 2003 08:52:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: michal-bugzilla@logix.cz
Subject: [Bug 1131] New: Unable to compile without "Software Suspend" (AMD 64)
Message-ID: <18140000.1061567551@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1131

           Summary: Unable to compile without "Software Suspend"
    Kernel Version: 2.6.0-test3-bk9
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: michal-bugzilla@logix.cz


Hardware Environment: AMD64
Software Environment: gcc-3.3
Problem Description:

It's impossible to compile kernel without "Software Suspend" on AMD64. At the
linking time it complains:
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.text+0xc6bf): In function `do_suspend_lowlevel':
: undefined reference to `save_processor_state'
arch/x86_64/kernel/built-in.o(.text+0xc6c6): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/x86_64/kernel/built-in.o(.text+0xc6cd): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eax'

Steps to reproduce:
On AMD64 deselect "Power management options" -> "Software Suspend" and compile.


