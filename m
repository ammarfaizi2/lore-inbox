Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSJJTE1>; Thu, 10 Oct 2002 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJJTE1>; Thu, 10 Oct 2002 15:04:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9441 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262158AbSJJTEX>;
	Thu, 10 Oct 2002 15:04:23 -0400
Message-ID: <3DA5CF9A.8050702@us.ibm.com>
Date: Thu, 10 Oct 2002 12:06:02 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arjan van de Ven <arjanv@fenrus.demon.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, LSE <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com> 	<1034244381.3629.8.camel@localhost.localdomain> <1034248971.2044.118.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-10-10 at 11:06, Arjan van de Ven wrote:
> 
>>>+/**
>>>+ * sys_mem_setbinding - set the memory binding of a process
>>>+ * @pid: pid of the process
>>>+ * @memblks: new bitmask of memory blocks
>>>+ * @behavior: new behavior
>>>+ */
>>>+asmlinkage long sys_mem_setbinding(pid_t pid, unsigned long memblks, 
>>>+				    unsigned int behavior)
>>>+{
>>
>>Do you really think exposing low level internals as memory layout / zone
>>split up to userspace is a good idea ? (and worth it given that the VM
>>already has a cpu locality preference?)
> 
> At least in the embedded world that level is a good idea. I'm not sure
> about the syscall interface. An "unsigned long" mask of blocks sounds
> like a good way to ensure a broken syscall in the future
Agreed.  This is a first pass (well 3rd, but the first two were long ago),
and I'll probably immitate the sys_sched_(s|g)etaffinity calls (even more
than I already have ;) and add a 'length' argument in the next itteration.

Cheers!

-Matt

