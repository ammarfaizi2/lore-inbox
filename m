Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbUCAIMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbUCAIMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:12:17 -0500
Received: from is.magroup.ru ([213.33.179.242]:56317 "EHLO is.magroup.ru")
	by vger.kernel.org with ESMTP id S261910AbUCAIMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:12:16 -0500
Date: Mon, 1 Mar 2004 11:11:51 +0300
From: Antony Dovgal <tony2001@phpclub.net>
To: linux-kernel@vger.kernel.org
Subject: APM & device_power_up/down
Message-Id: <20040301111151.28fa0240.tony2001@phpclub.net>
X-Mailer: Sylpheed version 0.9.9cvs10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2004 08:11:51.0312 (UTC) FILETIME=[D9D7D900:01C3FF64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I've tried to contact Pavel Machek directly, but got no response from him, so I'm forwarding the letter to the list.

The problem is: 
the patch, that was provided here: http://marc.theaimsgroup.com/?l=linux-kernel&m=107540713415651&w=2, prevents my laptop from suspending.
Laptop is: Compaq Armada M700 and I'm using APM.
Tailing /var/log/messages I can see only 'User Suspend' and no error messages.
After pushing the suspend button my laptop turns off the screen and just freezes instead of suspending (the power is still on). 
The only thing I can do after that is to turn the power down.

This behaviuor was firstly noticed after upgrade from 2.6.1 to 2.6.2 (and 2.6.3 doesn't fix it).
So I decided to do a small investigation and discovered that when I remove calls to device_power_*() from apm.c, it works well.
Of course, the problem can be in my laptop's BIOS or wherever, but, I repeat, it works well with 2.4.x & 2.6.1 and it doesn't with 2.6.2 & 2.6.3.

At this moment I can hardly understand why there is need to power down devices after suspend (shouldn't they be powered down in the suspend process?), but I'm not a kernel hacker.
So, any help is appreciated.

---
WBR,
Antony Dovgal aka tony2001
tony2001@phpclub.net || antony@dovgal.com
