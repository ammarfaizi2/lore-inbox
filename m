Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266814AbUG1Iec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266814AbUG1Iec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 04:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUG1Iec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 04:34:32 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:28353 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S266814AbUG1Iea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 04:34:30 -0400
Date: Wed, 28 Jul 2004 11:34:19 +0300 (EEST)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Jeff Dike <jdike@addtoit.com>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml-patch-2.6.7-1
In-Reply-To: <200407280422.i6S4M7fL008720@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0407281131020.23608@hosting.rdsbv.ro>
References: <200407280422.i6S4M7fL008720@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Jeff Dike wrote:

> Here is a belated patch that updates UML to 2.6.7.  The update was the only
> change from the 2.6.6 UML.

One problem with debugging. I ran 2.6.7-1 like this:
./K2.6.7 debug ubd0=ROOT1 mem=32M

In xterm shows:
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 14253

Then, in the debugging xterm:
GNU gdb 6.1.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you 
are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for 
details.
This GDB was configured as "i486-slackware-linux"...Using host 
libthread_db library "/lib/libthread_db.so.1".

0xa01c4a71 in kill () at sock.h:805
805     sock.h: No such file or directory.
         in sock.h
Error accessing memory address 0xa0034c20: No such process.
Error accessing memory address 0xa001c530: No such process.
Error accessing memory address 0xa00022a0: No such process.
/tmp/gdb_init-ziuYCQ:6: Error in sourced command file:
ptrace: Operation not permitted.
0xa01c4a71 in kill () at sock.h:805
805     in sock.h
(gdb) Quit
(gdb)

This is a Slackware 10.

No patches on host (also 2.6.7).

How can I help debugging this problem?

Thanks!
---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
