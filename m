Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbTBWGzi>; Sun, 23 Feb 2003 01:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268046AbTBWGzi>; Sun, 23 Feb 2003 01:55:38 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:32473 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S268045AbTBWGzh>; Sun, 23 Feb 2003 01:55:37 -0500
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, rddunlap@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Feb 2003 02:02:01 -0500
Message-Id: <1045983722.32116.8.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> On Wed, 2003-02-19 at 09:28, Ion Badulescu wrote:

>> then you're probably debugging, not performance-tuning,
>> so the cast to u64 is acceptable.
>
> Not true, you must cast to 'long long' as there is no
> appropriate printf format string for u64 that works
> warning-free on all systems.

Casts are ugly and they hide bugs. There is a fix
for this problem: make u64 be "unsigned long long"
for every arch. That works for both 32-bit and 64-bit
systems. Likewise, choose "unsigned" for u32 even
if an "unsigned long" would work for a given arch.


