Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268136AbUHQHiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268136AbUHQHiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268137AbUHQHiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:38:20 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:10710 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268136AbUHQHiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:38:12 -0400
Message-ID: <877aabc4040817003841fadfbb@mail.gmail.com>
Date: Tue, 17 Aug 2004 13:08:09 +0530
From: Amit Shah <shahamit@gmail.com>
Reply-To: Amit Shah <shahamit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Excessive swapping on 2.6.8.1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've just switched from 2.6.5 to 2.6.8.1. I have 512MB of RAM. I have a
lot of apps running under KDE: several konqueror instances, firefox
with a couple of tabs, kontact (kmail + knode), music players, kopete,
etc. I'm running Debian Sid on this P4 1.7GHz.

When I leave this system running at nights, the system uses 100% of the
available swap space. swapd also starts adding swap files. Even after
this, my swap currently shows 100% usage. Just 63M is free:

$ free
total       used       free     shared    buffers
cached
Mem:        515584     508044       7540          0       3280
54088
-/+ buffers/cache:     450676      64908
Swap:       526160     526160          0


$ uptime
12:41:37 up 23:48,  2 users,  load average: 0.50, 0.55, 0.48

Swap usage just before I stopped working last night was definitely not
more than 50%, I'm sure.

I saw this behavior just once or twice with 2.6.5, that too when I had
some server processes running, and they were serving {web pages,
.debs}. Those servers I've moved to other machines since. 2.6.5 after
that, didn't show such swap usage or such an excessive slowdown.

I'm using the CFQ elevator. My config file for the current setup is at

http://amitshah.nav.to/kernel/config.txt

`dmesg` output is at

http://amitshah.nav.to/kernel/dmesg.txt

I'm also using the Reiser4 patches, but I was using them with 2.6.5 as
well, so there's nothing really I can think of that has changed besides
the kernel.

Any ideas as to why this could be happening?

Amit.
-- 
Amit Shah
http://amitshah.nav.to/
