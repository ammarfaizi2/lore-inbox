Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267152AbSKXDCD>; Sat, 23 Nov 2002 22:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbSKXDCD>; Sat, 23 Nov 2002 22:02:03 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:51847 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S267152AbSKXDCC>;
	Sat, 23 Nov 2002 22:02:02 -0500
Message-ID: <3DE042DA.4040701@wmich.edu>
Date: Sat, 23 Nov 2002 22:09:14 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49-mm1 paging request error -> kernel panic
References: <3DE04028.5090007@wmich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't seem to have anything to do wtih the share pagetables 
option in mm1.  I get it when that option is disabled as well.


Ed Sweetman wrote:
> after finishing boot sequence, ntpd eventually does something bad.  i 
> get an "Unable to handle kernel paging request at virtual address 400413cc"
> I have that share bottom level page tables option enabled. Also preempt.
> 
> printing eip:
> 400085ca
> *pde = 0ec26067
> *pte = 0fc18065
> Oops: 0007
> CPU: 0
> EIP: 0023:[<400085ca>] Not tainted
> EFLAGS: 00010202
> eax: 0000003d ebx: 400114a8 ecx: 4004147a edx: 40041258
> esi: bffff0e0 edi: 00000000 ebp: bffff1a8 esp: bffff0d0
> ds: 002b es: 002b ss: 002b
> Process ntpd (pid: 385, theradinfo=ceb02000 task=cfc53380)
> <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


