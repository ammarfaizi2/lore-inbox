Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWBUPYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWBUPYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWBUPYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:24:03 -0500
Received: from postage-due.permabit.com ([66.228.95.230]:27268 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S1161130AbWBUPYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:24:02 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.31 hangs, no information on console or serial port
From: David Golombek <daveg@permabit.com>
Date: 21 Feb 2006 10:23:56 -0500
Message-ID: <7yirr8hh0z.fsf@questionably-configured.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box running a modified Debian/woody system and 2.4.31.  It is
intermittently hanging such that:

* All logging to /var/log ceases.
* Machine is still pingable.
* Machine can be telneted to on time port, but no time is echoed.
* After attaching a console+keyboard, console would not unblank.
* Nothing responded when attaching a serial console.
* Machine does not respond to Ctrl-Alt-Del
* No DMI messages are logged.
* Hang is persistent until physical reboot.

This has happened 4 times, on 2 separate machines (under roughly
similar conditions).  Machines are up variable amounts of time before
crashing, between many weeks and less than 1 day.  Nothing unusual is
logged in /var/log/{deamon.log,kern.log,messages,syslog} prior the
hang, except that /var/log/messages includes the "TCP: Treason
uncloaked!" warnings that are fixed in 2.4.32.  No users were logged
on at the time of 3 of the 4 crashes, and no local user activity was
present at the time of the 4th.

The machines are Intel P4's with 2GB of memory

The machine is under relatively high load and has a custom userspace
nfs server running on it (which is potentially to blame, but we've
been unable to determine how).  The custom userspace nfs server and
tomcat4 are the primary applications running.

Any suggestions as to how we might debug this or possible causes would
be greatly appreciated.

Thanks,
Dave

