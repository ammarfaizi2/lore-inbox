Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbTLFRfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTLFRfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:35:30 -0500
Received: from wlvh-3e35347b.pool.mediaWays.net ([62.53.52.123]:8434 "EHLO
	whs1.whs") by vger.kernel.org with ESMTP id S265214AbTLFRfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:35:23 -0500
Message-ID: <3FD21334.7090705@lrc.ruralwales.org>
Date: Sat, 06 Dec 2003 17:34:44 +0000
From: Bob Hutchinson <hutch@lrc.ruralwales.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.3.1) Gecko/20030514 Debian/1.3.1.x.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: server crashing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
hope this is the right list for this question...

We have a server running RH7.3 (patched with RHN to date apart from Kernel
which is 2.4.20-13.7). Apart from the software RAID being broken & the
machine running in degraded mode for several months) it has been reliable
until recently.

It has started crashing with a console screen full of kernel messages - for
the last 5 days - always at 4am, though we have been unable to see which of
the 4am cron jobs might be tipping it over (we HAVE looked and thought it
might be logwatch [5.0.1] which we are now turning off).

Messages are too long & hexy to copy all ... here are the gist:
<snip>
bread <kernel>
ext3_mark_iloc_dirty <kernel>
ext3_truncate   .....
.rodata   .....
__jbd_kmalloc  ....
start_this_handle   ....
journal_start  ...
start_transaction  ...
ext3_delete_inode  ...
iput  ...
notify_change  ...
d_delete  ...
vfs_unlink  ...
cached_lookup <kernel>
lookup_hash  ...
sys_unlink  ...
sys_close  ...
system_call ...

Code:    "strings of hex numbers all on one line ..."
</snip>

And that is it.

A hard RESET results in a reboot that hangs & drops into a shell - but
ANOTHER (second) hard RESET results in a successful & totally clean boot
(apart from the degraded raid messages and they appear on every boot).

We are baffled & do not know what is causing this or what we need to do.
Any help would be much appreciated as this is a busy server with over 1000
users on it.

Any help or pointers would be appreciated


