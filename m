Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271244AbRHOPs5>; Wed, 15 Aug 2001 11:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271241AbRHOPsh>; Wed, 15 Aug 2001 11:48:37 -0400
Received: from dsl254-096-012.nyc1.dsl.speakeasy.net ([216.254.96.12]:55447
	"HELO") by vger.kernel.org with SMTP id <S271233AbRHOPsa>;
	Wed, 15 Aug 2001 11:48:30 -0400
From: <mheinz@infiniconsys.com>
Subject: Reference counts versus PG_locked and memory management....
Message-Id: <20010815154837Z271233-761+1477@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Date: Wed, 15 Aug 2001 11:48:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of porting a driver to Linux. The author of the driver conveniently broke it into os-dependent and independent sections.

One of the things in the "OS" dependent section is a routine to lock a section of memory presumably to be used for DMA.

So, what I want to do is this: given a pointer to a previously kmalloc'ed block, and the length of that block, I want to (a) identify each page associated with the block and (b) lock each page. It appears that I can lock the page either by incrementing it's reference count, or by setting the PG_locked flag for the page.

Which method is preferred? Is there another method I should be using instead?
