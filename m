Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUHUTqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUHUTqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUHUTqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:46:08 -0400
Received: from [138.15.108.3] ([138.15.108.3]:48100 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S267713AbUHUTpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:45:43 -0400
Message-ID: <4127A662.2090708@nec-labs.com>
Date: Sat, 21 Aug 2004 15:45:38 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
References: <4127A15C.1010905@nec-labs.com> <20040821214402.GA7266@mars.ravnborg.org>
In-Reply-To: <20040821214402.GA7266@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Aug 2004 19:45:30.0832 (UTC) FILETIME=[6A795D00:01C487B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sat, Aug 21, 2004 at 03:24:12PM -0400, Lei Yang wrote:
> 
>>Hi all,
>>
>>I was trying to compile a kernel module with kbuild. The module 'test.c' 
>>include a header file 'fred.h' and there is a "#include <stdio.h>" in 
>>'fred.h'.
>>
>>Makefile looks like:
>>
>>------------------------------------------------------------------------
>>ifneq ($(KERNELRELEASE),)
>>obj-m       := test.o
>>
>>else
>>KDIR        := /usr/src/linux
>>PWD         := $(shell pwd)
>>
>>default:
>>	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
>>	
>>
>>clean:
> 
> For 2.6.7 (or 2.6.6) you do not need to specify your own clean: rule.
> 
> 
>>But upon compiling, there would be errors like this:
>>In file included from /home/lei/test.c:49:
>>/home/lei/fred.h:4:19: stdio.h: No such file or directory
> 
> The kernel does not provide you with a stdio.h header, so therefore you
> cannot find it neither use functionality from it.

You mean I can't use stdio.h at all?

But what if I really need to? Is there anything I can do?

> 	Sam
