Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTIUVCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 17:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTIUVCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 17:02:24 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:1677 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262562AbTIUVCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 17:02:24 -0400
Subject: x86-64 and PA-RISC have broken WCHAN
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064177339.746.94.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Sep 2003 16:49:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PA-RISC port (2.4.xx) returns 0xdeadbeef.
The x86-64 port (2.6.0-test5) returns a 0.

i386, alpha, ppc, and IA-64 all work fine.
I think ARM works, but I didn't have a
System.map file on the system I was using.
I didn't check zSeries, ppc64, MIPS, or SPARC.

The following command is supposed to report
an instruction pointer ("nip" or "pc" or "rip"
or whatever), a stack pointer ("r2" or "sp" or
whatever), the kernel address where a process
is waiting, and the kernel function name where
a process is waiting:

ps -eo eip,esp,nwchan,wchan


