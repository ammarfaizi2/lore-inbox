Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281506AbRKQAVa>; Fri, 16 Nov 2001 19:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281525AbRKQAVU>; Fri, 16 Nov 2001 19:21:20 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:49164 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281506AbRKQAVL>;
	Fri, 16 Nov 2001 19:21:11 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: andrew.grover@intel.com, zippel@linux-m68k.org
Subject: 2.4.15-pre5 conflict between acpi and a.out, affs is implicated
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Nov 2001 11:20:59 +1100
Message-ID: <8705.1005956459@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-*/a.out.h defines STACK_TOP.  So does
drivers/acpi/include/acinterp.h, with a different value.  The conflict
occurs if you compile with acpi and a.out, or with acpi and affs.  For
reasons that are beyond me, include/linux/affs_fs_i.h contains #include
<linux/a.out.h>.

ACPI needs to use a different name.

Why does affs_fs_i.h include a.out.h?

