Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUACV3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbUACV3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:29:21 -0500
Received: from 64-52-142-65.client.cypresscom.net ([64.52.142.65]:60069 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id S264300AbUACV3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:29:17 -0500
Date: Sat, 3 Jan 2004 13:26:38 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1-mm1 - KGDB fails to breakpoint in Serial Mode
Message-ID: <Pine.LNX.4.58.0401031251020.22438@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.6.1-rc1-mm1, KGDB fails to generate breakpoints after the
initial one, in either built-in code or in modules.

I started the debug session as usual w
  gdb vmlinux

The target then halts as expected in bootup

  target remote /dev/ttyS0
  c

causes boot to continue as expects

However, once running, the gdb break command against
the running kernel or a loaded module fails to result in a break.
The module start address was set as usual w add-symbol-file
which in turn matches   cat /proc/modules.

I'll debug this myself if need be, but hopefully
there is some simple solution?

Thnx much,
johnh

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------
