Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWCBUG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWCBUG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCBUG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:06:56 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:52124 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751294AbWCBUG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:06:56 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5-mm1: inotify BUG warnings
Date: Thu, 2 Mar 2006 21:04:13 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603022104.14073.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a number of those when running KDE 3.5.1 on a 2.6.16-rc5-mm1 box:

Mar  2 20:51:44 ch kernel: BUG: warning at 
fs/inotify.c:533/inotify_d_instantiate()
Mar  2 20:51:44 ch kernel:  [<b0187017>] inotify_d_instantiate+0x57/0x60
Mar  2 20:51:44 ch kernel:  [<b0176da2>] d_instantiate+0x42/0x90
Mar  2 20:51:44 ch kernel:  [<b01a761c>] ext3_add_nondir+0x3c/0x60
Mar  2 20:51:44 ch kernel:  [<b01a8016>] ext3_link+0xa6/0xf0
Mar  2 20:51:44 ch kernel:  [<b016c67e>] vfs_link+0x14e/0x1b0
Mar  2 20:51:44 ch kernel:  [<b016fa8e>] sys_linkat+0x11e/0x140
Mar  2 20:51:44 ch kernel:  [<b014b2ec>] __handle_mm_fault+0x66c/0x820
Mar  2 20:51:44 ch kernel:  [<b0114650>] do_page_fault+0x420/0x6ce
Mar  2 20:51:44 ch kernel:  [<b016fadf>] sys_link+0x2f/0x40
Mar  2 20:51:44 ch kernel:  [<b0102e13>] sysenter_past_esp+0x54/0x75

Other than these, the system seems to run perfectly.
