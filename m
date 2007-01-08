Return-Path: <linux-kernel-owner+w=401wt.eu-S932142AbXAHVih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbXAHVih (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXAHVih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:38:37 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:47568 "EHLO ns2.lanforge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932142AbXAHVig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:38:36 -0500
Message-ID: <45A2B9DA.20104@candelatech.com>
Date: Mon, 08 Jan 2007 13:38:34 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ext3 file system went read-only in 2.6.18.2 (plus hacks)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, this kernel is tainted by one of my proprietary patches
and also has my other non-proprietary patches applied, so please
ignore as you wish.  My patches do not (purposefully) affect the file-system.

The system is a via/c3 system running a fairly stripped down FC5
installation on a 1GB CF disk.  We've been using this platform
for over a year and this is the first file system error we've
seen.  It could easily be that the CF is funky, but I thought
I'd post the message in case it proves to be something else.


eth1: Promiscuous mode enabled.
eth1: Promiscuous mode enabled.
EXT3-fs error (device hda1): ext3_find_entry: bad entry in directory #99247: rec_len % 4 1
Aborting journal on device hda1.
EXT3-fs error (device hda1): ext3_find_entry: bad entry in directory #99254: rec_len % 4 1
ext3_abort called.
EXT3-fs error (device hda1): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
EXT3-fs error (device hda1): ext3_find_entry: bad entry in directory #99048: rec_len % 4 1
EXT3-fs error (device hda1): ext3_find_entry: bad entry in directory #99041: directory en1
   syslogd: /var/log/messages: Read-only file system
   syslogd: /var/log/secure: Read-only file system
   syslogd: /var/log/maillog: Read-only file system
   syslogd: /var/log/cron: Read-only file system
   syslogd: /var/log/spooler: Read-only file system
   syslogd: /var/log/boot.log: Read-only file system
   syslogd: /var/log/messages: Read-only file system
   syslogd: /var/log/secure: Read-only file system
   syslogd: /var/log/maillog: Read-only file system
   syslogd: /var/log/cron: Read-only file system
   syslogd: /var/log/spooler: Read-only file system
   syslogd: /var/log/boot.log: Read-only file system
pktgen: pktgen_mark_device marking eth0#5 for removal
pktgen: pktgen_mark_device marking eth0#0 for removal
.....

After restarting and a manual fsck, the system appears to
be back to normal.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

