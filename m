Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWI2WsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWI2WsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWI2WsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:48:14 -0400
Received: from smtp-out.google.com ([216.239.45.12]:47259 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932150AbWI2WsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:48:12 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=G07xcb6X3Jw1rpXPvgImtqRbmOLA6r8w+BAKqw/BpWmZJh5u9RVV9puThaoaFeguV
	WOGKn39CvovP4Gw67ok8w==
Message-ID: <65dd6fd50609291548x39707437yb7f1308c3397c488@mail.google.com>
Date: Fri, 29 Sep 2006 15:48:04 -0700
From: "Ollie Wild" <aaw@google.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2/2] UML - Don't roll my own random MAC generator
Cc: "Jeff Dike" <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, dhollis@davehollis.com,
       "Jason Lunz" <lunz@falooley.org>
In-Reply-To: <20060929153853.9bab3ca7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	 <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
	 <20060929153853.9bab3ca7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can use "make ARCH=um SUBARCH=i386 .." to build for i386.

Ollie

On 9/29/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 29 Sep 2006 15:18:52 -0700
> "Ollie Wild" <aaw@google.com> wrote:
>
> > This patch as provided breaks my build due to a missing semicolon.
> >
> > ..
> >
> > -     random_ether_addr(addr)
> > +     random_ether_addr(addr);
>
> ahem.  That must have had a lot of testing ;)
>
> Jeff, could we pleeeeeze arrange for UML's `make allmodconfig' to work, and
> to continue to work?
>
> Right now it goes splut with
>
> arch/um/os-Linux/sys-x86_64/registers.c: In function 'get_thread_regs':
> arch/um/os-Linux/sys-x86_64/registers.c:85: error: 'JB_PC' undeclared (first use in this function)
> arch/um/os-Linux/sys-x86_64/registers.c:85: error: (Each undeclared identifier is reported only once
> arch/um/os-Linux/sys-x86_64/registers.c:85: error: for each function it appears in.)
> arch/um/os-Linux/sys-x86_64/registers.c:86: error: 'JB_RSP' undeclared (first use in this function)
> arch/um/os-Linux/sys-x86_64/registers.c:87: error: 'JB_RBP' undeclared (first use in this function)
>
>
> How does one build uml-for-i386 on an x86_64 host, btw?
>
