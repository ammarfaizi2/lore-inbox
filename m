Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVDSTJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDSTJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVDSTJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:09:50 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:61330 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261240AbVDSTJr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:09:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sv17K4FLhb8cK+kXZrMqDv0JguCQ+sJWE46gIzmEeXRjd46NiIlewuo8//j+7jTTKEpwXxh2y8kiKvRDWxMZMLuMGe0q+JHRTxMLM5QbuZCHQrLH690rBsvNWNkyqXbkyH5fxZNJPUO9gFjAVWCtwWyBhCoxfiBYK0GIUIPjEro=
Message-ID: <17d79880504191209295aec42@mail.gmail.com>
Date: Tue, 19 Apr 2005 19:09:45 +0000
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel page table and module text
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to do the following.

I want to find where each module is loaded in memory by traversing the
module list . Once I have the address and the size of the module, I
want to read the bytes in memory of the module and hash it to check
it's integrity.

How do I,
1. Traverse the module list and find it's address
2. Read the kernel page table to find the physical address of the
module location

thanks,
Allison


Allison wrote:
> Hi,
> 
> Since module is loaded in non-contiguous memory, there has to be an
> entry in the kernel page table for all modules that are loaded on the
> system. I am trying to find entries corresponding to my module text in
> the page tables.
> 
> I am not clear about how the kernel page table is organized after the
> system switches to protected mode.
> 
> I printed out the page starting with swapper_pg_dir . But I do not
> find the addresses for all the modules loaded in the system.
> 
> Do I still need to read the pg0 and pg1 pages ?
> 
> If somebody can explain how to traverse the kernel page tables, that
> would be very helpful.
> 
> thanks,
> Allison
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
