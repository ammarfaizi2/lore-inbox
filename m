Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbRBWDhy>; Thu, 22 Feb 2001 22:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130863AbRBWDho>; Thu, 22 Feb 2001 22:37:44 -0500
Received: from smtppop3pub.gte.net ([206.46.170.22]:62023 "EHLO
	smtppop3pub.verizon.net") by vger.kernel.org with ESMTP
	id <S131009AbRBWDhf>; Thu, 22 Feb 2001 22:37:35 -0500
From: "Kurt V. Hindenburg" <k.hindenburg@gte.net>
Date: Thu, 22 Feb 2001 22:43:22 -0500
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: __buggy_fxsr_alignment error 2.4.1 and 2.4.2
Message-ID: <20010222224322.A15511@amdk7.gte.net>
Reply-To: k.hindenburg@gte.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asm-i386:
init/main.o(.text.init+0x63): undefined reference to `__buggy_fxsr_alignment'

I don't recall this error in 2.4.0, but it is present in 2.4.1 and was not
fixed in 2.4.2.

 >sh scripts/ver_linux 
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux amdk7 2.4.1 #3 Sat Feb 3 18:50:44 EST 2001 i686 unknown
Kernel modules         2.4.1
Gnu C                  pgcc-2.95.2.1
Gnu Make               3.79.1
Binutils               2.10.1
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.7
Mount                  2.10q
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ppp_deflate bsd_comp ppp_async

Fix: Comment out line 217 in include/asm-i386/bugs.h
/*    __buggy_fxsr_alignment(); */

It compiles after this change.

