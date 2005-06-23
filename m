Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVFWSjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVFWSjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbVFWSdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:33:40 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:11495 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S262930AbVFWSbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:31:03 -0400
Message-ID: <5353647.1119551462209.JavaMail.root@web1.mail.adelphia.net>
Date: Thu, 23 Jun 2005 14:31:02 -0400
From: <cspalletta@adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: Re: namespace question
Cc: mikew@google.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Sensitivity: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
---- Mike Waychison <mikew@google.com> wrote: 
> cspalletta@adelphia.net wrote:
> > I don't believe the following to be an error, but I am curious how it occurs:
> > 
> > Running a kernel module using dpath iteratively on the mnt_mountpoint member ... I get a curious doubling of the mount point names:

>> proc /proc/proc proc
>> sysfs /sys/sys sysfs
>>  devpts /dev/pts/dev/pts devpts
>>  tmpfs /dev/shm/dev/shm tmpfs
>> /dev/hda1 /boot/boot ext2
>> usbfs /proc/bus/usb/bus/usb usbfs

>  Using the same algorithm with mnt_root produces correct results.  

> >                 dentry = dget(vfsmnt_ptr->mnt_mountpoint);
> 
> should be:
> 
> dentry = dget(vfsmnt_ptr->mnt_root);

Yes I pointed that out above - what I want to know is why the doubling of the names for mnt_mntpoint.  It must be used for something, I suppose.
