Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUJJF3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUJJF3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 01:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUJJF3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 01:29:22 -0400
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:40893 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S268130AbUJJF3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 01:29:17 -0400
Subject: /proc/[number] special entries
From: Matthew Hindle <luminary@penguinmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1097386284.7715.3.camel@chiyo.azumanga>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 10 Oct 2004 15:31:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if anybody could help me with a hint or two...

I'm trying to add a sub-directory to each /proc/[number] directory
(where [number] is a process id). I think that I need to get a
proc_dir_entry* so that I can call:

proc_mkdir("mysubdir", (struct proc_dir_entry *) parent);

However, I can't work out how to get a reference to the proc_dir_entry*
I need. I can find the other entries in the proc directory (such as bus,
cpuinfo. misc, net...) by doing something like this:

struct proc_dir_entry * dp;
dp = &proc_root;
dp = dp->subdir;
while (dp != NULL) {
  printk("er... found: %s\n",dp->name);
  dp = dp->next;
}

However, the only entries that don't show up are the [number] entries.
Assistance please!

Please CC: any replies to <luminary@penguinmail.com>.

Kind regards,
Matt Hindle.


