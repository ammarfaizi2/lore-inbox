Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVDGPQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVDGPQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVDGPQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:16:59 -0400
Received: from alog0250.analogic.com ([208.224.222.26]:60086 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262486AbVDGPQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:16:52 -0400
Date: Thu, 7 Apr 2005 11:16:14 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.11 can't disable CAD
Message-ID: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the not-too distant past, one could disable Ctl-Alt-DEL.
Can't do it anymore.

Script started on Thu 07 Apr 2005 10:58:11 AM EDT
[SNIPPED leading stuff...]

mprotect(0xb7fe4000, 28672, PROT_READ|PROT_EXEC) = 0
brk(0)                                  = 0x804a000
brk(0x8053000)                          = 0x8053000
reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_CAD_OFF) = 0
pause( <unfinished ...>
_exit(0)                                = ?
# exit
Script done on Thu 07 Apr 2005 10:58:21 AM EDT

Observe that reboot() returns 0 and `strace` understands what
parameters were passed. The result is that, if I hit Ctl-Alt-Del,
`init` will still execute the shutdown-order (INIT 0).

A side note, while researching this problem, I think I found
that LINUX_REBOOT_MAGIC2 is Linus' birthday (in hex). Maybe
the problem is that he no longer observes his birthday?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
