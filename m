Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUCVMeB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUCVMeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:34:00 -0500
Received: from web.ngs.ru ([212.164.71.11]:60690 "EHLO mx1.intranet.ru")
	by vger.kernel.org with ESMTP id S261946AbUCVMd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:33:56 -0500
Message-ID: <405EDE3D.6050805@ngs.ru>
Date: Mon, 22 Mar 2004 18:38:21 +0600
From: Stepan Yakovenko <yakovenko@ngs.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: =?KOI8-R?Q?=E1_trouble_with_2=2E4=2E25_linux_kernel?=
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I want to get linux 2.4.25 running on my server, whitch currently uses 
2.2.20.
I've read /linux-2.4.25/Documentation/Changes and it seems
that everything required is ok.

But.

My server has Pentium MMX in it. So when I compile the 2.4.25 kernel 
with all defaults (i use menuconfig), it fails on startup. Just reboots 
the PC, and I can't see anything. I've googled through linux-kernel 
archives and got the idea that I've not configured the Processor type 
correctly. Ok, I choose Pentium MMX from menu (as my old 2.2.20 reports 
in /proc/cpuinfo) and try to compile the kernel. All the other kernel 
settings are default.

It fails ! Here's the log. I've tested that on my workstation with some 
new cool fast processor and it says the same:

In file included from 
/root/linux-2.4.25/include/linux/modversions.h:69,       
                 from 
/root/linux-2.4.25/include/linux/module.h:21,            
                 from 
ksyms.c:14:                                              
/root/linux-2.4.25/include/linux/modules/dec_and_lock.ver:2: warning: 
`atomic_de
c_and_lock' 
redefined                                                          
/root/linux-2.4.25/include/linux/spinlock.h:67: warning: this is the 
location of
 the previous 
definition                                                       
In file included from 
/root/linux-2.4.25/include/linux/modversions.h:135,      
                 from 
/root/linux-2.4.25/include/linux/module.h:21,            
                 from 
ksyms.c:14:                                              
/root/linux-2.4.25/include/linux/modules/i386_ksyms.ver:84: warning: 
`cpu_data'
redefined

.... and so on.....

I can send the whole stderr output if that's not enough.
It seems to me that one can easily reproduce all this error and 
warning messages that I've got. Just set Pentinum MMX processor and 
leave all the other settings default.

So, how should I understand this ? Have I done something wrong ? Is that 
a bug in kernel ? Can I run 2.4.25 on Pentium MMX?

Please, advice me something, hope you can easily reproduce the bug.

Thanx in advance !

Stepan Yakovenko

