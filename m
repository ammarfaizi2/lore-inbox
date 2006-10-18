Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWJRPvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWJRPvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWJRPvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:51:00 -0400
Received: from mail.pentek.com ([12.35.250.145]:58102 "HELO
	mailhost.pentek.com") by vger.kernel.org with SMTP id S1161217AbWJRPu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:50:58 -0400
Message-ID: <45364D3C.3070204@pentek.com>
Date: Wed, 18 Oct 2006 11:50:20 -0400
From: Steve Rottinger <steve@pentek.com>
Organization: Pentek, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 Hard lockup advice needed: do_IRQ: stack overflow 508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a small Pentium 4 file server set up using version 2.6.18 of the Kernel.  The system contains a 
SiI 3124 based SATA controller, and I have a software RAID set up, with LVM enabled.   During normal daily operation, the system is stable.    However, when I perform nightly backups, and there is a lot of disk and network activity, as the data is transferred to a backup server, the system eventually locks up.   Unfortunately, there is no indication of a failure in the system logs.   I also enabled the NMI_Watchdog without any additional visibility.    By disabling the screen blanking on the console windows,  I do get a single message reported before the lockup:

do_IRQ: stack overflow 508
do_IRQ+0x69/0xbc 0xc0104ce4

If I downgrade to 2.6.17 of the Kernel, I see the same problem, but it takes longer for it to occur.

-Steve


