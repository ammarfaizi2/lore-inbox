Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWDCP4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWDCP4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWDCP4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:56:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:41419 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751757AbWDCP4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:56:33 -0400
Subject: Re: [PATCH] unify PFN_* macros
From: Dave Hansen <haveblue@us.ibm.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060403124916.GA14044@linux-mips.org>
References: <20060323162459.6D45D1CE@localhost.localdomain>
	 <20060403124916.GA14044@linux-mips.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 08:56:08 -0700
Message-Id: <1144079768.9731.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 13:49 +0100, Ralf Baechle wrote:
> On Thu, Mar 23, 2006 at 08:24:59AM -0800, Dave Hansen wrote:
> 
> > Just about every architecture defines some macros to do operations on
> > pfns.  They're all virtually identical.  This patch consolidates all
> > of them.
> > 
> > One minor glitch is that at least i386 uses them in a very skeletal
> > header file.  To keep away from #include dependency hell, I stuck
> > the new definitions in a new, isolated header.
> > 
> > Of all of the implementations, sh64 is the only one that varied by a
> > bit.  It used some masks to ensure that any sign-extension got
> > ripped away before the arithmetic is done.  This has been posted to
> > that sh64 maintainers and the development list.
> > 
> > Compiles on x86, x86_64, ia64 and ppc64.
> 
> Ehhh...  Looks at this patch I wonder if you actually read the MIPS bits
> before submitting it:
> 
>  o replaces PFN_ALIGN with PAGE_ALIGN

Yeah, that is blatantly wrong.  I have no idea what I was thinking
there.  

>  o replaces the IP27 definition of PFN_ALIGN with a different one.

That was part of the idea :)  Was there something special about that
implementation?

> How about posting such stuff to linux-arch?  No sane person follows l-k.

I was under the impression that linux-arch wasn't the kind of list which
is supposed to posted to by "normal" people.  I was scolded once for
cc'ing it.  If instructed so, I'd be happy to post there in the future.

-- Dave

