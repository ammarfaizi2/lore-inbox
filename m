Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUJHXtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUJHXtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUJHXtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:49:04 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:38727 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S266236AbUJHXs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:48:58 -0400
Message-ID: <41672768.8040002@blueyonder.co.uk>
Date: Sat, 09 Oct 2004 00:48:56 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2004 23:49:23.0131 (UTC) FILETIME=[6FD500B0:01C4AD91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Config for HPET not correctly set in arch/x86_64/Kconfig. 
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y are the only ones to appear and it doesn't 
build hpet.o, build also fails with # CONFIG_HPET_TIMER is not set.
     CHK     include/linux/version.h
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   GEN_INITRAMFS_LIST usr/initramfs_list
Using shipped usr/initramfs_list
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x1dc1): In function 
`late_hpet_init':
: undefined reference to `hpet_alloc'
--------------------------------------
x86 builds OK with:-

CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
