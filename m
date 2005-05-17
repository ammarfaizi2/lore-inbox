Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVEQWEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVEQWEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVEQWC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:02:57 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:1920 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261953AbVEQVqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:46:10 -0400
Message-ID: <428A661C.1030100@ammasso.com>
Date: Tue, 17 May 2005 16:46:04 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sparse error: unable to open 'stdarg.h'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to run sparse on my external module, but sparse complains about not being able 
to find stdarg.h.  I know this bug was supposed to have been fixed back in January, but 
I'm using the latest code, so I can't explain what's wrong.  I've tried this on a couple 
different 2.6 kernels.

Here's the output I get:

make -C /lib/modules/2.6.8-24-smp/source 
SUBDIRS=/root/AMSO1100/software/host/linux/sys/devccil  C=1 V=2
make[2]: Entering directory `/usr/src/linux-2.6.8-24'
   CHECK   /root/AMSO1100/software/host/linux/sys/devccil/devnet.c
include/linux/kernel.h:10:11: error: unable to open 'stdarg.h'
make[3]: *** [/root/AMSO1100/software/host/linux/sys/devccil/devnet.o] Error 1
make[2]: *** [_module_/root/AMSO1100/software/host/linux/sys/devccil] Error 2
make[2]: Leaving directory `/usr/src/linux-2.6.8-24'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/AMSO1100/software/host/linux/sys/devccil'
make: *** [build] Error 2

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
