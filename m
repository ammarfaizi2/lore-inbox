Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUHGVn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUHGVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHGVn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 17:43:59 -0400
Received: from 23-88.ipact.nl ([82.210.88.23]:20893 "EHLO vt.shuis.tudelft.nl")
	by vger.kernel.org with ESMTP id S264297AbUHGVnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:43:52 -0400
From: Remon <noreply@vt.shuis.tudelft.nl>
Reply-To: noreply@vt.shuis.tudelft.nl
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O3
Date: Sat, 7 Aug 2004 23:43:53 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408072343.53852.noreply@vt.shuis.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/psaux is deprecated.  Use /dev/input/mice.  On Debian, you can do
> this with `dpkg-reconfigure xserver-xfree86'.  Otherwise, use your
> distro's X configurator, or edit /etc/X11/XF86Config-4 and replace
> /dev/psaux with /dev/input/mice.


I compiled mouse support statically instead of a module and it worked. But I 
will try this also.

However, I still have problems, especially with the mouse. I used my computer 
for a while and suddenly the mouse got wild so to say.
It jumped back and forth, starting applications, kinda funny to see actually.

I looked at dmesg, and it gave messages like:
Lost sync of mouse, throwing away 1 (and also 2 / 3) bytes.
I couldn't find the IRQ thread which is used by the mouse, but after disabling 
all of them it worked as normal, making IRQ threaded again made the mouse go 
north/south/west/east again.

I was only getting xruns, using 0.3 ms latency with my sound application when 
using the mouse, otherwise ALSA remained silent (not long tested due mouse 
problems)

Thanks,


Remon
