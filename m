Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTIPP6g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbTIPP6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:58:35 -0400
Received: from web40020.mail.yahoo.com ([66.218.78.60]:15708 "HELO
	web40020.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261941AbTIPP6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:58:32 -0400
Message-ID: <20030916155831.67252.qmail@web40020.mail.yahoo.com>
Date: Tue, 16 Sep 2003 08:58:31 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: [BUG?] 2.6.0-test5-mm[1,2], CONFIG_SOFTWARE_SUSPEND=y, qconf and swapon -a
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently discovered a bug in the swsusp code in 2.6.0-test5-mm[1,2].

When CONFIG_SOFTWARE_SUSPEND=y, and the kernel is first started, doing a
swapon -a livelocks the machine (i.e. bootup stops, but Alt-SysRQ works fine).
I don't use swsusp and I don't want to at this time, and the swap partition
swapon was trying to activate is an ordinary 659MB swap partition (version 1,
priority -1) at the end of the disk.

qconf doesn't allow you to set CONFIG_SOFTWARE_SUSPEND=n, and modifying .config
doesn't work either (it gets set back to y). According to the range/data values
in qconf, there actually is no way to disable swsusp in 2.6.0-test5-mm[1,2].

Interesting part of .config:

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
# CONFIG_PM_DISK is not set
CONFIG_PM_DISK_PARTITION=""

What should I try now?

TIA

Brad Chapman

P.S: Please CC: me directly; I follow the ussg.iu.edu hypermail archive.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
