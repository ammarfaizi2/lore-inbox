Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTI1MUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 08:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTI1MUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 08:20:39 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:6104 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S262525AbTI1MUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 08:20:37 -0400
Message-Id: <200309281216.h8SCGWsl026399@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.6.0-test6
Date: Sun, 28 Sep 2003 14:19:24 +0200
Organization: linux-kernel.at
X-Mailer: Oracle Connector for Outlook 9.0.4 50618 (10.0.4608)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information-linux-kernel.at: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner-linux-kernel.at: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks/Linus!

Linus Torvalds wrote:
> Ok, too long between test5 and test6 again, so the patch is 
> pretty big. Lots of driver updates and architectures fixed, 
> but also lots of merges from Andrew Morton. Most notably 
> perhaps Con's scheduler changes that have been discussed 
> extensively and made it into the -mm tree for testing.

It work's on my Intel machine, but on Alpha, I get this:
<snip>
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `try_to_wake_up':
kernel/built-in.o(.text+0x438): undefined reference to `sched_clock'
kernel/built-in.o(.text+0x43c): undefined reference to `sched_clock'
kernel/built-in.o: In function `schedule':
kernel/built-in.o(.text+0x13e4): undefined reference to `sched_clock'
kernel/built-in.o(.text+0x13ec): undefined reference to `sched_clock'
kernel/built-in.o: In function `copy_process':
kernel/built-in.o(.text+0x5014): undefined reference to `sched_clock'
kernel/built-in.o(.text+0x503c): more undefined references to `sched_clock' follow
fs/built-in.o: In function `smb_fill_super':
fs/built-in.o(.text+0xc9618): undefined reference to `low2highuid'
fs/built-in.o(.text+0xc9624): undefined reference to `low2highuid'
fs/built-in.o(.text+0xc963c): undefined reference to `low2highuid'
fs/built-in.o(.text+0xc9640): undefined reference to `low2highuid'
make: *** [.tmp_vmlinux1] Error 1

If you need more information please ask me (CC: me please).

Best,
 Oliver

