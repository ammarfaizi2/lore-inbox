Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVJQQm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVJQQm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVJQQm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:42:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14557 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750790AbVJQQmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:42:55 -0400
Date: Mon, 17 Oct 2005 09:42:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <200510171826.40711.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0510170938240.23590@g5.osdl.org>
References: <20051017093654.GA7652@localhost.localdomain> <200510171740.57614.ak@suse.de>
 <Pine.LNX.4.64.0510170901460.23590@g5.osdl.org> <200510171826.40711.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Andi Kleen wrote:
> 
> That's completely new terminology. We always called all of ZONE_NORMAL low 
> memory.

We call it "low" memory because it happens to have "low" addresses. In 
other words, it's not "terminology", it's "English".

None of the allocators that allocate stuff in ZONE_NORMAL is called "low" 
normally. It's _normal_ memory. It's not ZONE_LOW. 

We don't say "kmalloc_low()". We say "kmalloc()". 

A function that is called "xyz_low()" means something else than normal to 
me. If it was normal memory, we'd call it just "xyz()". And if it did high 
memory, we'd call it "xyz_highmem()" (or, preferably, we'd just have a 
generic function that accepted GFP_HIGHMEM as a parameter).

			Linus
