Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbTDZFDu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 01:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264614AbTDZFDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 01:03:50 -0400
Received: from franka.aracnet.com ([216.99.193.44]:35531 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264609AbTDZFDt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 01:03:49 -0400
Date: Fri, 25 Apr 2003 22:15:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Timothy Miller <miller@techsource.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <13080000.1051334155@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0304260138380.1229-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304260138380.1229-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> 128Mb of it? The bottom page, or even a few Mb, sure ... 
>> >> but 128Mb seems somewhat excessive ..
> 
> Yes.
> 
>> > Considering that your process space is 4gig, and that that 128Mb
>> > doesn't really exist anywhere (no RAM, no page table entries,
>> > nothing), it's really not excessive.  
>> 
>> I need the virtual space.
> 
> Plus you would (very often) get more physical.  i386 ELF text typically
> begins at 0x08048000: putting stack just below text in many cases shares
> page table between stack+text+data, and saves the page table at top of
> user address space.

A fine point - I hadn't thought of that. 
It just seems tidier all around ....

M.

