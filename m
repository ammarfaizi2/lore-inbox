Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbUKTSzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbUKTSzv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbUKTSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:55:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32672 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263152AbUKTSzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:55:24 -0500
Date: Sat, 20 Nov 2004 10:55:07 -0800
From: Janis Johnson <janis187@us.ibm.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Janis Johnson <janis187@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] cpumask_t initializers
Message-ID: <20041120185507.GA4122@us.ibm.com>
References: <1100915156.4653.13.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100915156.4653.13.camel@arrakis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 05:45:57PM -0800, Matthew Dobson wrote:
> 
> Janis Johnson, a GCC hacker, told me the following:
>> Extra parens can be thrown away in expressions, but the syntax for
>> initializers has curly braces on the outside of the list.  GCC doesn't
>> seem to mind if there are parens outside the braces for a struct
>> initializer, but that's probably a bug and could change in a future
>> version of GCC's C parser.
> 
> So, in order to both make my code compile and future-proof (heh) the
> CPU_MASK_* initializers I wrote up this little patch.  This DEFINITELY
> needs to be tested further (I've compile-tested it on x86, x86 NUMA,
> x86_64 & ppc64), but the good news is that any breakage from the patch
> will be compile-time breakage and should be obvious.
> 
> The fact that GCC's parser may change in the future to disallow struct
> initializers wrapped in parens kind of scares me, because just about
> every struct initializer I've ever seen in the kernel is wrapped in
> parens!!  This needs to be delved into further, but I'm leaving for home
> for a week for Thanksgiving and will have limited access to email.

I'm not an expert on the C language (I just pass for one in this
building) so this ought to be looked at by someone who is.  As for
changes to the C parser, Joseph Myers is writing a recursive-descent
C parser for GCC tentatively slated to replace the existing C parser
for GCC 4.1.

Janis
