Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVCHSOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVCHSOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVCHSOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:14:24 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:65131 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261465AbVCHSOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:14:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=h61BzQ3Z1LKlSVvu/GhCRLnRcHLFFwOCjovqfRXXxJNoiiXyycP2EeQubBjVDM7DR/achDT/Y9+WI3WKwJEhTMd6t9FXcmBwORNxndOpTQnnElq2DXcxBQcbnh1/K+FlhHuwE11bezDKEmXRLW2jNsloWUMsK4slJKne80WQKqs=
Message-ID: <2cd57c9005030810144cfc0b@mail.gmail.com>
Date: Wed, 9 Mar 2005 02:14:18 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Robert Love <rml@novell.com>
Subject: Re: Question regarding thread_struct
Cc: Imanpreet Arora <imanpreet@gmail.com>, linux-kernel@vger.kernel.org
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
 

CONFIG_IRQSTACKS seems only on ppc64. Is it good to add for other archs too?


Regards
-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
