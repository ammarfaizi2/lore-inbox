Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbULaRjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbULaRjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbULaRjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:39:09 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:39834 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262125AbULaRip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:38:45 -0500
From: William <wh@designed4u.net>
Organization: Designed4u.net
To: linux-kernel@vger.kernel.org
Subject: the umount() saga for regular linux desktop users
Date: Fri, 31 Dec 2004 17:41:02 +0000
User-Agent: KMail/1.7.2
Cc: wh@designed4u.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311741.02864.wh@designed4u.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am a linux desktop user. I love linux and all the wonderfull 
open-source/free software that comes with it... blah, blah, blah :). The 
following comments and suggestions about umount() stem from personal 
experience and are meant as friendly feedback for all you clever people. (I 
wish I understook how the kernel works)

Regularly, when attempting to umount() a filesystem I receive 'device is busy' 
errors. The only way (that I have found) to solve these problems is to go on 
a journey into processland and kill all the guilty ones that have tied 
themselves to the filesystem concerned.

In order to help solve this problem is it possible to modify the behaviour of 
the linux kernel.

In my opinion, in order for linux to be trully user friendly, "a umount() 
should NEVER fail" (even if the device containing the filesystem is no 
longuer attached to the system). The kernel should do it's best to satisfy 
the umount request and cleanup. Maybe the kernel could try some of the 
following:

1) if the device containing the filesystem (for local filesystems) is no 
longer physicaly attached to the system: revoke all process access to the 
filesystem and umount. Notify umount that the filesystem was not cleanly 
umounted.

2) notify all processes attached to the filesystem that they must release 
control of it.

3) the processes may respond to the notifications and request time to clean up 
in order to read/write any remaining data.

4) processes that do not respond within a given time-frame should have their 
filesystem access revoked.

5) once all the clean up has finnished...  umount the filesystem.....

I am not subscribed to the list so please email me on wh@designed4u.net

Kind Regards
      William Heyland

the new "a umount() should NEVER fail" campaign launched by me on december the 
31 of 2004.  Just in time for new year ;-)

PS:  I am currently teaching myself about kernels in general and am hoping to 
start contributing to linux soon. But until then... if the kernel can't 
handle a umount() then nothing in userspace can do any better... rant, rant, 
rant, ...  make umount() smarter.... Please?
