Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265018AbSKANh5>; Fri, 1 Nov 2002 08:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbSKANh5>; Fri, 1 Nov 2002 08:37:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:5357 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265018AbSKANhO>;
	Fri, 1 Nov 2002 08:37:14 -0500
Date: Fri, 1 Nov 2002 13:42:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David C. Hansen" <haveblue@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (3/3) stack overflow checking for x86
Message-ID: <20021101134238.GA23904@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David C. Hansen" <haveblue@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <1036091906.4272.87.camel@nighthawk> <1036092052.4272.96.camel@nighthawk> <20021031213032.GA25685@suse.de> <1036155546.12551.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036155546.12551.3.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 12:59:06PM +0000, Alan Cox wrote:
 > On Thu, 2002-10-31 at 21:30, Dave Jones wrote:
 > >  > This won't apply cleanly without the irqstack patch, but the conflict is
 > >  > easy to resolve.  It requires the thread_info cleanup.
 > > 
 > > I'm wondering about interaction between this patch and the
 > > already merged CONFIG_DEBUG_STACKOVERFLOW ?
 > 
 > It replaces it and actually makes it useful since IRQ usage is now
 > bounded and defined relative to non IRQ usage. Without IRQ stacks you
 > don't have a hope in hell of catching overflows that depend on an irq
 > occuring at the right moment

 Yeah, I figured it worked better, but wondered why the patch didn't
 remove the existing implementation.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
