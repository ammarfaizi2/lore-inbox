Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVBDSeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVBDSeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbVBDSYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:24:55 -0500
Received: from alog0217.analogic.com ([208.224.220.232]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264398AbVBDSVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:21:22 -0500
Date: Fri, 4 Feb 2005 13:21:29 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Can't remove a module because of new policy
Message-ID: <Pine.LNX.4.61.0502041311400.5242@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is more and more policy being put into the kernel
and utilities. Now I can't remove a module because whoever
made the new module-init-tools decided that they didn't like
its name even though it was installed and running.

In the following I explicitly tell `rmmod` to remove a module
with the name "DAS-Link". The "(!@$*!@#^(" program decides
that I don't know what I am doing and attempts to
remove "DAS_Link" which I never typed, never called for,
and should never have even been even guessed.

Script started on Fri 04 Feb 2005 01:07:41 PM EST
# lsmod | grep DAS
DAS-Link                6788  0 
# grep DAS /proc/modules
DAS-Link 6788 0 - Live 0xf0a95000
# rmmod DAS-Link
ERROR: Module DAS_Link does not exist in /proc/modules
# lsmod --version module-init-tools version 3.0-pre10 
# exit
Script done on Fri 04 Feb 2005 01:08:51 PM EST

So, I suppose this name is no longer valid?? If so, this
means that hundreds of installed machines can't be updated
in the field.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
