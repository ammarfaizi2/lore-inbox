Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbUKROVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbUKROVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUKROVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:21:22 -0500
Received: from alog0668.analogic.com ([208.224.223.205]:37504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262061AbUKROVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:21:18 -0500
Date: Thu, 18 Nov 2004 09:21:04 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Signal handler deadlock
Message-ID: <Pine.LNX.4.61.0411180916510.6160@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If I have a MUTEX in a driver and the driver can
also be called from a signal handler, will the
MUTEX deadlock when the signal handler calls the
driver?

Code --->----> driver-->MUTEX-taken-->***SIGNAL***

Signal handler --->driver--->MUTEX-waiting (will it deadlock?)

I use 'down()' and 'up()' in the driver. With Linux-2.4.22 the
code does not deadlock. With Linux-2.6.9, it does.

Is this the expected behavior? FYI I wrote the driver, not the
dumb code that calls it from a signal handler. I would never
have called anything by printf() from such a handler, so
don't preach to the choir. I just need to know if it should
work, before I tell somebody to rewrite some code.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
