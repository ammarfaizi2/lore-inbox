Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSKAMcY>; Fri, 1 Nov 2002 07:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSKAMcY>; Fri, 1 Nov 2002 07:32:24 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:6023 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264954AbSKAMcY>; Fri, 1 Nov 2002 07:32:24 -0500
Subject: Re: [PATCH] (3/3) stack overflow checking for x86
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "David C. Hansen" <haveblue@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031213032.GA25685@suse.de>
References: <1036091906.4272.87.camel@nighthawk>
	<1036092052.4272.96.camel@nighthawk>  <20021031213032.GA25685@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 12:59:06 +0000
Message-Id: <1036155546.12551.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 21:30, Dave Jones wrote:
>  > This won't apply cleanly without the irqstack patch, but the conflict is
>  > easy to resolve.  It requires the thread_info cleanup.
> 
> I'm wondering about interaction between this patch and the
> already merged CONFIG_DEBUG_STACKOVERFLOW ?

It replaces it and actually makes it useful since IRQ usage is now
bounded and defined relative to non IRQ usage. Without IRQ stacks you
don't have a hope in hell of catching overflows that depend on an irq
occuring at the right moment

