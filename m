Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUCGBl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 20:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbUCGBlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 20:41:51 -0500
Received: from florence.buici.com ([206.124.142.26]:25216 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261715AbUCGBlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 20:41:49 -0500
Date: Sat, 6 Mar 2004 17:41:47 -0800
From: Marc Singer <elf@buici.com>
To: linux-kernel@vger.kernel.org
Subject: persistent 2.6.[13] filesystem corruptions
Message-ID: <20040307014147.GA2214@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system has 2 CPUs as well as four SCSI disks in a RAID5
configuration.  On top of this, there are several LVM/device-mapper
volumes with ext3 filesystems on them.  The system was running this
way for almost a year on the 2.4 kernel.  I switched to 2.6.1 when it
was available.  Periodically, I login in the morning to find that
several of the LVM volumes were mounted RO.  Never did I find out why
though I suspected that there was a FS corruption and the kernel was
remounting the volumes RO.  Remounting them RW usually worked, but
ext3 filesystems often had errors requiring an fsck.

I switched to 2.6.3 to see if the problems would go away.  No luck.
In fact, it's worse because the corruptions are more frequent.  On one
occasion, the system froze.

This message, too, is new:

  EXT3-fs error (device dm-5): ext3_readdir: bad entry in directory #11: directory entry across blocks - offset=0, inode=808464430, rec_len=12336, name_len=48
  Remounting filesystem read-only

Any ideas what might be the culprit or where to look?
 
 

