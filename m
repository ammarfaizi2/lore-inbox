Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265728AbSJTBhX>; Sat, 19 Oct 2002 21:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265730AbSJTBhX>; Sat, 19 Oct 2002 21:37:23 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:37063 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S265728AbSJTBhW>; Sat, 19 Oct 2002 21:37:22 -0400
Message-ID: <4916202.1035077984025.JavaMail.nobody@web155>
Date: Sat, 19 Oct 2002 17:39:44 -0800 (GMT-08:00)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: problemn when shutting down, drivers/base/power.c and the global_device_list
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I shut my system down, the last line I saw was
>
> Shutting down devices.
> I've hacked drivers/base/power.c:device_shutdown() like this:

[snip]

My own system (Dell Latitude CPx750J laptop, RH7.3 base) has 'reboot'
 segfaulting and (thanks to kksymoops :) this info, hand copied from the
 dead monitor:

EFLAGS: 00010286
EIP is at device_shutdown + 0x6d/0xa2

(didn't write registers down - call trace w/o addresses follows)

sys_reboot
handle_mm_fault
do_page_fault
sock_destroy_inode
destroy_inode
dput
__fput
filp_close
sys_close
syscall_call

I can provide further info / try debugging (but I won't necessarily be
 speedy in responding, sorry). This 2.5.44 is built with GCC 3.2.


Thanks,

--alessandro
