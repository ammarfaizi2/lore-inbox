Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271237AbRHOPj5>; Wed, 15 Aug 2001 11:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271236AbRHOPjr>; Wed, 15 Aug 2001 11:39:47 -0400
Received: from dsl254-089-216.nyc1.dsl.speakeasy.net ([216.254.89.216]:16382
	"EHLO dragon") by vger.kernel.org with ESMTP id <S271233AbRHOPjh>;
	Wed, 15 Aug 2001 11:39:37 -0400
Message-ID: <3B7A97C5.9090207@infiniconsys.com>
Date: Wed, 15 Aug 2001 11:39:49 -0400
From: Michael Heinz <mheinz@infiniconsys.com>
Organization: InfiniCon Systems
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ics i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Implications of PG_locked and reference count in page structures....
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of porting a driver to Linux. The author of the 
driver conveniently broke it into os-dependent and independent sections.

One of the things in the "OS" dependent section is a routine to lock a 
section of memory presumably to be used for DMA.

So, what I want to do is this: given a pointer to a previously 
kmalloc'ed block, and the length of that block, I want to (a) identify 
each page associated with the block and (b) lock each page. It appears 
that I can lock the page either by incrementing it's reference count, or 
by setting the PG_locked flag for the page.

Which method is preferred? Is there another method I should be using 
instead?


