Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUBBAEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 19:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbUBBAEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 19:04:42 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:39847 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265531AbUBBAEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 19:04:41 -0500
Subject: load average calculation in linux 2.6
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075680277.8818.38.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 01:04:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed my web server reboot while doing an rsync because the load was
too high (and my watchdog decided that something was wrong...).

The CPU was mostly idle but /proc/loadavg showed a load average of over
40.

I assume that the iowait is also used for the load average calculation.
Every process that's waiting for IO contributes a load average of one.
Right?

So rsync kept the disk busy and a lot of mail and apache processes were
waiting for it.

Is this the desired behavior or wrong?


