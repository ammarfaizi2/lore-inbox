Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318144AbSGWQir>; Tue, 23 Jul 2002 12:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSGWQiq>; Tue, 23 Jul 2002 12:38:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51117 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318144AbSGWQip>; Tue, 23 Jul 2002 12:38:45 -0400
Message-ID: <3D3D872F.1040100@us.ibm.com>
Date: Tue, 23 Jul 2002 09:41:19 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@mvista.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Adam G Litke <aglitke@us.ibm.com>
Subject: Re: [PATCH] reduce code in generic spinlock.h
References: <3D3D8414.1040201@us.ibm.com> <1027442320.3581.100.camel@sinai>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Tue, 2002-07-23 at 09:28, Dave Hansen wrote:
> 
>>The last time lockmeter was ported to 2.5, it was getting a little
>>messy.  There were separate declarations for spin_*lock() for each
>>combination of lockmeter and preemption, which made four, plus the
>>no-smp definition.  While lockmeter's mess isn't the kernel's fault, 
>>we noticed some some simplifications which could be made to the 
>>generic spinlock code.  This patch uses a single definition for each 
>>of the macros, eliminating some redundant code.
> 
> I have no problems with this (assuming it is right and it looks so on
> first glance).
> 
> It will not apply to Linus's current tree, however, because of the IRQ
> rewrite that is now applied.  If you pull his BK tree and diff against
> that, you should be OK... most notably, the preemption code has moved to
> preempt.h.

D'oh.  Bad timing, I guess.  I'll rediff against current BK.


-- 
Dave Hansen
haveblue@us.ibm.com

