Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTGAUIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTGAUIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:08:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27844 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263496AbTGAUII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:08:08 -0400
Date: Tue, 01 Jul 2003 13:10:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Daniel Phillips <phillips@arcor.de>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <445820000.1057090239@flay>
In-Reply-To: <200306301943.04326.phillips@arcor.de>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <200306301943.04326.phillips@arcor.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>    In 2.4, Page Table Entries (PTEs) must be allocated from ZONE_ NORMAL as
>>    the kernel needs to address them directly for page table traversal. In a
>>    system with many tasks or with large mapped memory regions, this can
>>    place significant pressure on ZONE_ NORMAL so 2.6 has the option of
>>    allocating PTEs from high memory.
> 
> You probably ought to mention that this is only needed by 32 bit architectures 
> with silly amounts of memory installed. 

Actually, it has more to do with the number of processes sharing data,
than the amount of memory in the machine. And that's only because we 
insist on making duplicates of identical pagetables all over the place ...

M.

