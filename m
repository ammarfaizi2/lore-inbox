Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVCHRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVCHRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCHRz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:55:29 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:37455 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261233AbVCHRzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:55:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CiRzfMrezqVp5/bLAYfQdrJZKxqiyt4eHURx6yYSuoVLmr06h1v+kd7p6Ag7hpdX+5bahE0lWK43DyIRHRCGT0KidHgEmb3RiuMNDbpw7D/bybwwluF1fgXssIlLkm5QZ8XxCBZJ1DDUSqYMudXeEhdolz+o8aCbD0x4pEhnJcA=
Message-ID: <c26b959205030809551b3e9670@mail.gmail.com>
Date: Tue, 8 Mar 2005 23:25:19 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
Reply-To: Imanpreet Arora <imanpreet@gmail.com>
To: Robert Love <rml@novell.com>
Subject: Re: Question regarding thread_struct
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1110302922.28921.3.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <c26b959205030809044364b923@mail.gmail.com>
	 <1110302000.23923.14.camel@betsy.boston.ximian.com>
	 <c26b959205030809271b8a5886@mail.gmail.com>
	 <1110302922.28921.3.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2005 12:28:42 -0500, Robert Love <rml@novell.com> wrote:
> On Tue, 2005-03-08 at 22:57 +0530, Imanpreet Arora wrote:
> 
> > This has been a doubt for a couple of days, and I am wondering if this
> > one could also be cleared. When you say kernel stack, can't be resized
> >
> >
> > a)       Does it mean that the _whole_ of the kernel is restricted to
> > that 8K or 16K of memory?
> 
> Actually, 4K or 8K these days for x86.  But, no, it means that EACH
> PROCESS is constrained to the kernel stack.  The stacks are per-process.
> The kernel never "runs on its own" -- it is always in the context of a
> process (which has its own kernel stack) or an interrupt handler (which
> either shares the previous process's stack or has its own stack,
> depending on CONFIG_IRQSTACKS).

Thanks again, but if the whole of the kernel is restricted to couple of pages.

Does this mean

a) the whole of the kernel including drivers is restricted to couple of pages.

b) Or with a more probability, I think what you actually mean is that
whenever there is an interrupt by any driver it runs in either context
of the current process or depending upon CONFIG_IRQSTACKS.

If you could just quote the chapter, in your book which contains
information  about this, that would be more than sufficient.


> > b)        Or does it mean that a particular stack for a particular
> > process, can't be resized?
> 
> Yes, I just said that in the previous email.  The kernel stack cannot be
> resized.  It is fixed.  It is one or two pages, depending on configure
> option.  That is, 4 or 8K.
> 
> The _user-space_ stack, what the application actually uses, is
> dynamically resizable.  But we are not talking about that.
> 
> > c)         And for that matter how exactly do we define a kernel stack?
> 
> I don't know what you mean.  alloc_thread_info() creates the thread_info
> structure and stack.


Actually what I asked above was "how exactly does one define and
differentiate kernel stack", as against "user-stack". I think I always
knew it but couple of clouds were coming over after reading your first
mail. Also if each thread has a kernel stack how is it allocated at
first place (alloc_thread_info)(?)

Thanks.
-- 

Imanpreet Singh Arora
