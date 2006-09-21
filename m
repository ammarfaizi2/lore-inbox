Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWIUVrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWIUVrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWIUVrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:47:10 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:55749 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750764AbWIUVrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:47:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NSCrmfdL7knbeQL5DK9UZGF4OllkCZgTI++heYZvxSFpvHvRzjHUO6SRI8vMRZPBL5Pr3EhaX988Kv65zJ3dvOGKAz2onSHuZh91mjdTA2GNv+X6u1gkXG2pr8w7j2hE+qd9URFeRmkxejcJE7Px58NQsXP1jhM7/PXZj/pOb3Y=
Message-ID: <a44ae5cd0609211447i41ae58f3xa59d2ae4c5dc5f65@mail.gmail.com>
Date: Thu, 21 Sep 2006 14:47:08 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.18 -- INFO: possible recursive locking detected
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
knodemgrd_1/13913 is trying to acquire lock:
 (&s->rwsem){..--}, at: [<f8960817>] nodemgr_probe_ne+0x22d/0x36c [ieee1394]

but task is already holding lock:
 (&s->rwsem){..--}, at: [<f89610d8>] nodemgr_host_thread+0x739/0x8a7 [ieee1394]

other info that might help us debug this:
1 lock held by knodemgrd_1/13913:
 #0:  (&s->rwsem){..--}, at: [<f89610d8>]
nodemgr_host_thread+0x739/0x8a7 [ieee1394]

stack backtrace:
 [<c1003ef5>] show_trace_log_lvl+0x58/0x16a
 [<c100506d>] show_trace+0xd/0x10
 [<c1005087>] dump_stack+0x17/0x1c
 [<c102e485>] __lock_acquire+0x79b/0x9ef
 [<c102e9b6>] lock_acquire+0x5e/0x80
 [<c102b73e>] down_read+0x28/0x3a
 [<f8960817>] nodemgr_probe_ne+0x22d/0x36c [ieee1394]
 [<f89610f7>] nodemgr_host_thread+0x758/0x8a7 [ieee1394]
 [<c1001005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c100506d>] show_trace+0xd/0x10
 [<c1005087>] dump_stack+0x17/0x1c
 [<c102e485>] __lock_acquire+0x79b/0x9ef
 [<c102e9b6>] lock_acquire+0x5e/0x80
 [<c102b73e>] down_read+0x28/0x3a
 [<f8960817>] nodemgr_probe_ne+0x22d/0x36c [ieee1394]
 [<f89610f7>] nodemgr_host_thread+0x758/0x8a7 [ieee1394]
 [<c1001005>] kernel_thread_helper+0x5/0xb
ieee1394: send packet at S400: ffc0a140 ffc1ffff f0000234
