Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265287AbSJaVZ3>; Thu, 31 Oct 2002 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265284AbSJaVZ3>; Thu, 31 Oct 2002 16:25:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:7908 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265287AbSJaVZ2>;
	Thu, 31 Oct 2002 16:25:28 -0500
Date: Thu, 31 Oct 2002 21:30:32 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.COM>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (3/3) stack overflow checking for x86
Message-ID: <20021031213032.GA25685@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"David C. Hansen" <haveblue@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.COM>,
	lkml <linux-kernel@vger.kernel.org>
References: <1036091906.4272.87.camel@nighthawk> <1036092052.4272.96.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036092052.4272.96.camel@nighthawk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 11:20:52AM -0800, David C. Hansen wrote:
 > * stack checking (3/3)
 >    - use gcc's profiling features to check for stack overflows upon
 >      entry to functions.
 >    - Warn if the task goes over 4k.
 >    - Panic if the stack gets within 512 bytes of overflowing.
 >    - use kksymoops information, if available
 > 
 > This won't apply cleanly without the irqstack patch, but the conflict is
 > easy to resolve.  It requires the thread_info cleanup.

I'm wondering about interaction between this patch and the
already merged CONFIG_DEBUG_STACKOVERFLOW ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
