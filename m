Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbTJHVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTJHVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:22:29 -0400
Received: from mx3.evanzo-server.de ([81.209.142.20]:10135 "EHLO
	mx3.evanzo-server.de") by vger.kernel.org with ESMTP
	id S261791AbTJHVW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:22:27 -0400
From: Markus Schoder <markus_schoder@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: crash with 2.6.0-test7
Date: Wed, 8 Oct 2003 23:22:20 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310082322.21024.markus_schoder@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running the nptl tests from nptl-0.60 my machine
regularly freezes (SysRq keys not working any more)
and/or panics and outputs the following (or similar)
on the console:


...
do_page_fault+0x12c/0x454
poke_blanked_console+0x5c/0x70
try_to_wake_up+0xa7/0x160
default_wake_function+0x2a/0x30
__wake_up_common+0x31/0x60
do_page_fault+0x0/0x454
error_code+0x2d/0x38
do_exit+0x1d2/0x350
do_page_fault+0x0/0x454
die+0xe1/0xf0
do_page_fault+0x12c/0x454
sys_exit+0x13/0x20
syscall_call+0x7/0xb

Code: 8b 5d 68 c7 44 24 20 01 00 03 00 8b 50 14 8b 00 81 e2 ff ff
<6>note: ld-linux.so.2[2069] exited with preempt_count 1


I have omitted the absolute addresses. The part between the
`do_page_fault+0x12c/0x454' entries repeats again and again
scrolling off the screen so I cannot see the beginning of the
message.

I experienced similar crashes with 2.6.0-test6 and 2.6.0-test6-mm4
also for 2.6.0-test6-mm4 the stacktrace looked different (see my
earlier post).

Machine is a single processor Athlon XP 2000+, 768MB RAM. Kernel was 
compiled with gcc-3.3.1. Preempt is enabled.

--
Markus

