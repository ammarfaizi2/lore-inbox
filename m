Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131569AbRCQIQJ>; Sat, 17 Mar 2001 03:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131574AbRCQIQA>; Sat, 17 Mar 2001 03:16:00 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:21068 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131569AbRCQIPk>; Sat, 17 Mar 2001 03:15:40 -0500
Date: Sat, 17 Mar 2001 09:14:52 +0100
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre10: Does Reiserfs eat files?
Message-ID: <20010317091451.A16595@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when I came to my computer this morning, I noticed that the file
~/.netscape/history.dat was missing. So I tried to copy over a backup
copy from another computer and got "permission denied". I realized that
the file was still there but not accessible at all, even by root.
Here's an strace of "ls -l ~.netscape/history.dat":

3917  lstat(".netscape/history.dat", 0x804e9bc) = -1 EACCES (Permission denied)

Then I looked in the kernel log, and no suprise, I found these entries:

vs-13048: reiserfs_iget: bad_inode. Stat data of (381 3930411) not found
vs-13048: reiserfs_iget: bad_inode. Stat data of (12541 173718) not found

The system is a Dual-Celeron with ABIT mainboard (Intel BX chipset) and
IDE disk, recently upgraded to 256 MB of ECC RAM.

How can I recover from this problem without reformatting?

Regards,
hjb
-- 
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/
