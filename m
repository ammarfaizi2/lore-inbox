Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWJRK7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWJRK7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWJRK7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:59:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:17073 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751056AbWJRK7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:59:19 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] Re: UNWIND_INFO slowdown in -mm1
Date: Wed, 18 Oct 2006 12:50:41 +0200
User-Agent: KMail/1.9.3
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       "Thomas Gleixner" <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20060928192048.GA17436@elte.hu> <45351782.76E4.0078.0@novell.com>
In-Reply-To: <45351782.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181250.41423.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 17:48, Jan Beulich wrote:
> >in 2.6.18-mm1 we are seeing _really_ long delays in the unwind code. 
> >(full trace attached) On an Athlon64 3800+ CPU:
> 
> Below patch should help, can you try it out? Short of the linker
> supporting building a binary lookup table at build time, it creates
> one as soon as the bootmem allocator is usable (so you'll continue
> using the linear lookup for the first [hopefully] few calls).
> The code should be ready to utilize a build-time created table once
> a fixed linker becomes available.

I added the patch now, thanks.

Not sure this is still .19 material though or better delayed for .20. 
What do you think?

-Andi
