Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264321AbUEMR3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUEMR3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbUEMR3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:29:48 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:61202 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S264344AbUEMR3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:29:06 -0400
Date: Thu, 13 May 2004 19:28:49 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm1: nameif causes oops
Message-ID: <20040513172849.GA2188@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my untainted 2.6.6-mm1 kernel, I see an oops (the one with the turtle
graphics) when booting, caused by the usage of nameif (which renames
ethernet interfaces from 'eth0' to 'adsl' for example).

dmove+0xc0/02fd
show_stack
show_registers
die
do_page_rault
error_code
sysfs_rename
kobject_rename
class_device_rename
dev_change_name
dev_ioctl
inet_ioctl
sock_ioctl
sys_ioctl
syscall_call

This is a smp (hyperthreading, single cpu) Pentium/4 system running
Debian Unstable.
I hope this is enough information, if not, let me know please.

This didn't happen in 2.6.6-rc3-mm1, by the way, which is the latest
kernel I tested before this one.

Kind regards,
Jurriaan
-- 
"If you hoped to arouse my deep antipathy, you have succeeded," said
Carfilhiot. "Otherwise, the occasion has been time wasted."
	Jack Vance - Lyonesse
Debian (Unstable) GNU/Linux 2.6.6-rc3-mm1 2x6062 bogomips 0.08 0.03
