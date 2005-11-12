Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVKLRqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVKLRqW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKLRqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:46:22 -0500
Received: from cse-mail.unl.edu ([129.93.165.11]:35019 "EHLO cse-mail.unl.edu")
	by vger.kernel.org with ESMTP id S932434AbVKLRqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:46:21 -0500
Date: Sat, 12 Nov 2005 11:45:54 -0600 (CST)
From: Hui Cheng <hcheng@cse.unl.edu>
To: kernelnewbies@nl.linux.org
cc: linux-kernel@vger.kernel.org
Subject: How to quickly detect the mode change of a hard disk?
In-Reply-To: <200511102334.10926.cloud.of.andor@gmail.com>
Message-ID: <Pine.GSO.4.44.0511121122430.15078-100000@cse.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (cse-mail.unl.edu [129.93.165.11]); Sat, 12 Nov 2005 11:46:00 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently doing a kernel module involves detecting/changing
disk mode among STANDBY and ACTIVE/IDLE. I used ide_cmd_wait() to issue
commands like WIN_IDLEIMMEDIATELY and WIN_STANDBYNOW1. The problem is, a
drive in standby mode will automatically awake whenever a disk operation
is requested and I need to know the mode change as soon as possible. (So I
donot want to periodically use the WIN_CHECKPOWERMODE to detect it). I was
wondering if the standby disk is waken by the kernel or by the disk
firmware? If it is not in the kernel, is there any good way to detect it?
Thanks,

Hui


