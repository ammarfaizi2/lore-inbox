Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUHZORD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUHZORD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUHZOOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:14:30 -0400
Received: from [195.23.16.24] ([195.23.16.24]:44254 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268928AbUHZOI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:08:58 -0400
Message-ID: <412DEEF3.2010408@grupopie.com>
Date: Thu, 26 Aug 2004 15:08:51 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arne Henrichsen <ahenric@yahoo.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sys_sem* undefined
References: <20040826090508.79320.qmail@web41508.mail.yahoo.com>
In-Reply-To: <20040826090508.79320.qmail@web41508.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.32; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arne Henrichsen wrote:
> Hi Randy,
> 
> thanks for the help. I am very new to Linux
> programming, and I do not understand what you mean
> with  'syscalls are not called by name'. 
> 
> I did find the header file syscalls.h, recompiled my
> code but it still says the following:
> 
> *** Warning: "sys_semop"
> [/prj/builds/host/linux/prj.ko] undefined!
> *** Warning: "sys_semctl"
> [/prj/builds/host/linux/prj.ko] undefined!
> *** Warning: "sys_semget"
> [/prj/builds/host/linux/prj.ko] undefined!
> 
> And when I load the module, then it tells me:
> 
> insmod: error inserting './prj.ko': -1 Unknown symbol
> in module
> 
> So, I call sys_sem* functions from my code. What else
> must I do?

Syscalls are supposed to be called from userspace, so that the kernel 
does something on behalf of an application.

Some syscalls have their do_<syscall name> equivalent because it makes 
sense to call them from inside the kernel, but others don't.

If you want to use semaphores inside the kernel I suggest you read the 
Rusty Rusell's Unreliable Guide to Kernel Locking first:

http://wwwos.inf.tu-dresden.de/~ch12/diplom/DocBook/kernel-locking/

I hope this helps,

-- 
Paulo Marques - www.grupopie.com
