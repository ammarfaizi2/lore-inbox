Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVCHV7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVCHV7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVCHV7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:59:14 -0500
Received: from alog0447.analogic.com ([208.224.222.223]:33920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262139AbVCHV4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:56:52 -0500
Date: Tue, 8 Mar 2005 16:55:07 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Mount on Linux-2.6.10
Message-ID: <Pine.LNX.4.61.0503081643310.15389@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I mount the root file-system and the proc file-system on
an embedded system, I use MS_NOATIME|MS_NODIRTIME for the flags.
No errors are reported and the file-systems are mounted.

However, the (struct stat) st_mtime of the /proc directory
is updated at every access and the st_mtime of any special
files like terminals are also updated. In fact, the time
appears to be updated on every keystroke when a terminal
is active on the file-systems.

How do I prevent this from occurring? These files were
NOT modified and st_mtime is supposed to show the
modification times, not the time at which it was
accessed.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
