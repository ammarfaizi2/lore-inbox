Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269177AbUJQQJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269177AbUJQQJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUJQQJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:09:33 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:60637 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S269177AbUJQQJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:09:09 -0400
Subject: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in
	arch/i386 - intro
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098031764.3023.45.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:10:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm going to post a series of small janitorial patches focused on
1) replacing DPRINTK-style macros with pr_debug from kernel.h
2) replacing printk(KERN_INFO ...) with pr_info(...)
3) fixing _obvious_ inconsistencies of printk levels as:

printk(KERN_INFO "Start... ");
...
printk("Ok!\n");

The patches fix only obvious inconsistencies: seems that there has been
no policy about how a subsystem should print boot/log messages
(subsistem prefix, etc.) nor about the difference between printk(...)
and printk(KERN_WARNING ...), etc. So I did not touch those issues.

The patches regard (mainly) files in arch/i386/kernel.
The patches are based upon 2.6.9-rc4.
The patches have been compile and boot tested.
One file one patch.

Any comment is very welcome.

CC'ed to Ingo Molnar, hoping that's appropriate.

Bye
Daniele Pizzoni <auouo@tin.it>

