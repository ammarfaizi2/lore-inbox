Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264036AbTIBSNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTIBSL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:11:26 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:21428 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264036AbTIBSJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:09:55 -0400
Message-ID: <3F54A4AC.1020709@wmich.edu>
Date: Tue, 02 Sep 2003 10:09:48 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: greg@kroah.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: devfs to be obsloted by udev?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that devfs is to be replaced by the use of udev in the not so 
distant future.  I'm not sure how it's supposed to replace a static /dev 
situaton seeing as how it is a userspace daemon.  Is it not supposed to 
replace /dev even when it's completed?  I dont see the real benefit in 
having two directories that basically give the same info.  Right now we 
have something like that with proc and sysfs although not everything in 
proc makes sense to be in sysfs and both are virtual fs's where as /dev 
is a static fs on the disk that takes up space and inodes and includes 
way too many files that a system may not use.  If udev is to take over 
the job of devfs, how will modules and drivers work that require device 
files to be present in order to work since undoubtedly the udev daemon 
will have to wait until the kernel is done booting before being run.

I'm just not following how it is going to replace devfs and thus why 
devfs is being abandoned as mentioned in akpm's patchset. Or as it 
seems, already has been abandoned.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
It appears that devfs is to be replaced by the use of udev in the not so 
distant future.  I'm not sure how it's supposed to replace a static /dev 
situaton seeing as how it is a userspace daemon.  Is it not supposed to 
replace /dev even when it's completed?  I dont see the real benefit in 
having two directories that basically give the same info.  Right now we 
have something like that with proc and sysfs although not everything in 
proc makes sense to be in sysfs and both are virtual fs's where as /dev 
is a static fs on the disk that takes up space and inodes and includes 
way too many files that a system may not use.  If udev is to take over 
the job of devfs, how will modules and drivers work that require device 
files to be present in order to work since undoubtedly the udev daemon 
will have to wait until the kernel is done booting before being run.

I'm just not following how it is going to replace devfs and thus why 
devfs is being abandoned as mentioned in akpm's patchset. Or as it 
seems, already has been abandoned.

