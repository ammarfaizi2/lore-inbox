Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWFNJ1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWFNJ1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWFNJ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:27:09 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7563 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932095AbWFNJ1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:27:08 -0400
Date: Wed, 14 Jun 2006 11:27:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Markus Biermaier <mbier@office-m.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS:
 Cannot open root device
In-Reply-To: <24986DCE-B4DF-4A43-B6B4-C3FE2BE477F0@office-m.at>
Message-ID: <Pine.LNX.4.61.0606141125150.5349@yvahk01.tjqt.qr>
References: <6137A58D-963C-4379-A836-DCD28C3E88EE@office-m.at>
 <24986DCE-B4DF-4A43-B6B4-C3FE2BE477F0@office-m.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ------------------------- [ BEGIN Cxxxxxx ] -------------------------
>> DEFAULT standard
>> LABEL standard
>> KERNEL vmlinuz
>> # APPEND initrd=initrd ramdisk_size=32768 root=/dev/hde1 udev acpi=off
>> rootdelay=5
>> APPEND initrd=initrd ramdisk_size=32768 root=2101 udev acpi=off
>> rootdelay=5
>> ------------------------- [ END   Cxxxxxx ] -------------------------
>> 
>> so the right root-string is: "root=2101".
>
> Ok, the solution for *this problem* seems to be to write "root=2101".
> But why can't I write "root=/dev/hde1" as in kernel 2.4.25?
> Is this a kernel bug?
> Or have I done an error somewhere?
>

Let me take a wild guess: By using /proc/.../real_root_dev, you make the 
kernel try to locate "/dev/hde1" (to find out major/minor number) on the 
device you wrote in real_root_dev, rather than (the default) make it look 
for /dev/hde1 in the initrd image.


Jan Engelhardt
-- 
