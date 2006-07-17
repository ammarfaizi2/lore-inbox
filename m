Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWGQOLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWGQOLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWGQOLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:11:18 -0400
Received: from mail.smartlink.ee ([213.180.16.242]:65185 "EHLO
	mail.smartlink.ee") by vger.kernel.org with ESMTP id S1750776AbWGQOLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:11:17 -0400
Message-ID: <44BB9A7A.4060100@smartlink.ee>
Date: Mon, 17 Jul 2006 17:11:06 +0300
From: Kalev Lember <kalev@smartlink.ee>
User-Agent: Thunderbird 1.5.0.4 (X11/20060610)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kexec and framebuffer
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Kexec skips video initialization code and because of that framebuffer
does not work with relocated kernels.
Like Eric W. Biederman pointed out in
http://www.ussg.iu.edu/hypermail/linux/kernel/0508.0/1674.html ,
screen_info structure from include/linux/tty.h must be passed along to
maintain current video mode.

I made some testing and it's enough to dump screen_info structure from
running kernel and overwrite this info in kexec' x86-linux-setup.c.

I am wondering what would be the preferred method to extract screen_info
from running kernel. Should this be made available from sysfs or maybe a
new system call be created?

-- 
Kalev Lember
