Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbTLZJ7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 04:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTLZJ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 04:59:38 -0500
Received: from sina187-156.sina.com.cn ([202.106.187.156]:61700 "HELO sina.com")
	by vger.kernel.org with SMTP id S265160AbTLZJ7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 04:59:35 -0500
Date: Fri, 26 Dec 2003 17:59:05 +0800
From: dlion <dlion2004@sina.com.cn>
X-Mailer: The Bat! (v2.00)
Reply-To: dlion2004@sina.com.cn
X-Priority: 3 (Normal)
Message-ID: <7624288781.20031226175905@sina.com.cn>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
In-Reply-To: <3FDD7DFD.7020306@labs.fujitsu.com>
References: <3FDD7DFD.7020306@labs.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tsuchiya,

Monday, December 15, 2003, 5:25:17 PM, you wrote:

TY> Hi,

TY> Ext2 and Ext3 filesystem go to inconsistent status by
TY> simple test program on my system.

TY> My test program is a script that extract a tar+gzip archive
TY> twice and compare them, and remove one of the tree, and then
TY> another extracting, and compare them again. A very simple test.

I tried your script on ext2 and ext3 filesystem on a ramdisk. I got errors,
too. It seems that this problem is unrelated to device driver or
hardware.

The mozilla tarball is too big for a ramdisk. I use a
zhcon-0.2.1.tar.gz (4,991,350 bytes) instead.

I only got one kind of error on ext2 filesystem. That is, the script
 said the read-only directory zhcon-0.2.1 is missing, but it _is_ there.
I used e2fsck to check the ramdisk and found no error.

I got other errors on ext3 filesystem include:
1. missing file
2. corrupted file
but when I used fsck.ext3 to check the ramdisk, the result was clean.

My system is:
CPU:  AMD Athlon XP 1800+
RAM:  256M DDR333
Chipset: VIA KT400A
Linux Distribution: Fedora Core 1
Linux Kernel: kernel-2.4.22-1.2115.nptl.athlon.rpm

-- 
Best regards,
 dlion                            mailto:dlion2004_at_sina.com.cn


