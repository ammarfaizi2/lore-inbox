Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUIMPxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUIMPxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUIMP2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:28:10 -0400
Received: from [209.88.178.130] ([209.88.178.130]:59124 "EHLO constg.qlusters")
	by vger.kernel.org with ESMTP id S267841AbUIMPUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:20:31 -0400
Message-ID: <4145BA28.5020702@qlusters.com>
Date: Mon, 13 Sep 2004 18:18:00 +0300
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: bugs@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron
 machines
References: <4145A8E1.8010409@qlusters.com> <200409131644.54441.arnd@arndb.de>
In-Reply-To: <200409131644.54441.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

>On Montag, 13. September 2004 16:04, Constantine Gavrilov wrote:
>  
>
>>We have a piece of kernel code that calls some system calls in kernel 
>>context (from a process with mm and a daemonized kernel thread that does 
>>not have mm). This works fine on IA64 and i386 architectures.
>>    
>>
>
>You can find the list of system calls that are supposed to work
>from kernel space in asm/unistd.h inside #ifdef __KERNEL__SYSCALLS__.
>On current kernels, that list only contains execve(), which should
>be avoided as well in favor of call_usermodehelper. Other calls
>might work on some architectures but that is not a supported
>interface any more.
>
>You could call the sys_* functions directly if they are exported,
>but it is unlikely that such code gets integrated in the mainline
>kernel.
>
>The real answer for your problem highly depends on which syscalls
>you want to use.
>
>	Arnd <><
>  
>
I can implement differently what I want, though it will be somewhat 
kludgy and kernel depenedent (depends on a version and distribution). I 
wanted to avoid that. Since what I write is really an application and 
not interface, it was very "native" to use application syscall approach.

My real problem is not how to implement it. I want to understand this 
specific x86_64 problem.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


