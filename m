Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbVLQSjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVLQSjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVLQSjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:39:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26819 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932650AbVLQSjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:39:48 -0500
Subject: Re: Dianogsing a hard lockup
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512171655390.2227@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0512171655390.2227@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 13:41:23 -0500
Message-Id: <1134844883.11227.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 17:09 +0100, Jan Engelhardt wrote:
> Hi list,
> 
> 
> some time after I load drivers (any, rt2500 or via ndiswrap) for a 
> rt2500-based wlan card, the box locks up hard. Sysrq does not work, so I 
> suppose it is during irq-disabled context. How could I find out where this 
> happens?


First, stick to rt2500 as you won't get help with binary only drivers
here.

Try to reproduce the problem from the console, you're more likely to get
a usable Oops.

Check the driver code & make sure it can't get stuck looping in the
interrupt handler due to an unhandled IRQ.  Add printks.

Finally report it to the rt2500 maintainer.

Lee

