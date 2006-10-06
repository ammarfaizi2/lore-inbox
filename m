Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWJFQ2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWJFQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWJFQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:28:07 -0400
Received: from 8.ctyme.com ([69.50.231.8]:63634 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751570AbWJFQ2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:28:03 -0400
Message-ID: <45268412.3040400@perkel.com>
Date: Fri, 06 Oct 2006 09:28:02 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Read Only File System?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure where to ask this question so I'll try here. I have a Raid 0 
EXT3 file system that is coming up read only. I don't think it's raid 
related but not sure why it's stuck on read only.

When I run mount it shows:
/dev/md0 on /data type ext3 (rw,noatime)

But when I attempt (running as root) to change anything I get:
touch: cannot touch `x': Read-only file system

When I list the directory I get this:
drwxr-xr-x    8 root root  4096 Sep 29 15:15 .
drwxr-xr-x   45 root root  4096 Oct  4 10:42 ..
drwxr-xr-x    4 root root  4096 Sep 11 03:17 critical
drwx------    2 root root 16384 Sep 10 22:37 lost+found
drwxr-xr-x   19 root root  4096 Sep 11 02:07 mirror
dr-x------   14 root root  4096 Sep  9 09:52 Robin
drwxr-xr-x    7 root root  4096 Oct  5 02:16 snapshot
drwxrwxr-x+ 289 root root 12288 Oct  1 03:20 www

Note the weird permissions on Robin. This happened because I was trying 
to save data from a crashed Windows NT system and I used rsync to copy 
the data over. And I noticed the problem around the same time.

So - what can I do to fix this?

