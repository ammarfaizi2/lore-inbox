Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTIBRwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTIBRuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:50:05 -0400
Received: from ns.suse.de ([195.135.220.2]:25317 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263833AbTIBRfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:35:20 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_64_BIT
References: <20030902143424.GO13467@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Sep 2003 19:35:11 +0200
In-Reply-To: <20030902143424.GO13467@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
Message-ID: <p73wucrm6uo.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> What do people think of CONFIG_64_BIT?  It saves us from using
> !(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
> the X86_64 people deciding their architecture is more important.
> 
> I also considered CONFIG_ILP32 vs CONFIG_LP64 (since that's the real
> problem with, eg, megaraid), but that requires more explanation and
> offers people several ways to get it wrong (should I depend on ILP32
> or !LP64?)

At least for code BITS_PER_LONG == 64 is already good enough.

For Kconfigs it may make sense, but is there any Config rule that 
checks for all 64bit archs (opposed to checking for specific archs)?
I cannot thinkg of any.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Matthew Wilcox <willy@debian.org> writes:

> What do people think of CONFIG_64_BIT?  It saves us from using
> !(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
> the X86_64 people deciding their architecture is more important.
> 
> I also considered CONFIG_ILP32 vs CONFIG_LP64 (since that's the real
> problem with, eg, megaraid), but that requires more explanation and
> offers people several ways to get it wrong (should I depend on ILP32
> or !LP64?)

At least for code BITS_PER_LONG == 64 is already good enough.

For Kconfigs it may make sense, but is there any Config rule that 
checks for all 64bit archs (opposed to checking for specific archs)?
I cannot thinkg of any.

-Andi
