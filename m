Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269616AbTGOTzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269636AbTGOTzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:55:07 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:57092 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S269616AbTGOTzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:55:03 -0400
To: linux-kernel@vger.kernel.org
Subject: /sys/class/tty bugglet in 2.6.0-test1 +
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 15 Jul 2003 16:09:45 -0400
Message-ID: <m3brvvzh4m.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like sysfs is creating a dir in class/tty by the name of
usb/acm/0 for my acm modem:

:; ls -AF /sys/class/tty
total 0
   0 console/
   0 ptmx/
   0 tty/
   0 tty0/
[ tty1 to tty63 elided ]
   0 ttyS0/
   0 ttyS1/
   0 ttyS2/
   0 ttyS3/
   0 usb/acm/0/

A [TAB] in bash will autocomplete /sys/class/tty/usb/acm/0.

W/ devfs the modem is at /dev/usb/acm/0, so it may be a sysfs
vs. devfs conflict.  (Box is gentoo; devfs is required for the 
init scripts to work.)

I think I'm at bk current, but may be off by a couple of csets.

-JimC

