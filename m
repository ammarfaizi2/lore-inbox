Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUBJQAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUBJQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:00:06 -0500
Received: from [193.16.218.66] ([193.16.218.66]:7893 "EHLO
	msa31a.ms.sapientia.ro") by vger.kernel.org with ESMTP
	id S265944AbUBJQAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:00:00 -0500
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: msa31a.ms.sapientia.ro
Message-ID: <4028FFD6.2060006@ms.sapientia.ro>
Date: Tue, 10 Feb 2004 17:59:18 +0200
From: Budai Laszlo <lbudai@ms.sapientia.ro>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Cannot mount root device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get into trouble when I try to compile a new kernel on a 
Fujitsu-Siemens B120 computer with Fedora Core 1. The problem was the 
same with Redhat Linux 9 too.

So, I'm doing make mrproper, make menuconfig (select the options I 
need), make, make bzImage, make modules, make modules_install, make 
install. I got no errors during the compile.
When I reboot the machine with the new kernel I get the following message:

VFS: Cannot open root device "sda3" or unknown-block (0,0)
Please append a correct "root=" option
Kernel panic: VFS: unable to mount root fs on unknown-block (0,0)

the same problem is happening if I try a binary kernel downloaded from 
rawhide.

what can be done?

Thank you,
Laszlo


my lilo.conf looks like:

prompt
timeout=50
default=linux
boot=/dev/sda
map=/boot/map
install=/boot/boot.b
linear

image=/boot/vmlinuz-2.6.2
         label=linux-2.6.2
         initrd=/boot/initrd-2.6.2.img
         read-only
         append="root=/dev/sda3"

image=/boot/vmlinuz-2.4.22-1.2115.nptl
         label=linux
         initrd=/boot/initrd-2.4.22-1.2115.nptl.img
         read-only
         append="rhgb root=LABEL=/"

image=/boot/vmlinuz-2.6.1-1.65
         label=2.6.1-1.65
         initrd=/boot/initrd-2.6.1-1.65.img
         read-only
         append="rhgb root=LABEL=/"

