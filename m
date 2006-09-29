Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWI2WjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWI2WjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWI2WjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:39:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964780AbWI2WjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:39:07 -0400
Date: Fri, 29 Sep 2006 15:38:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ollie Wild" <aaw@google.com>
Cc: "Jeff Dike" <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, dhollis@davehollis.com,
       "Jason Lunz" <lunz@falooley.org>
Subject: Re: [PATCH 2/2] UML - Don't roll my own random MAC generator
Message-Id: <20060929153853.9bab3ca7.akpm@osdl.org>
In-Reply-To: <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	<65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 15:18:52 -0700
"Ollie Wild" <aaw@google.com> wrote:

> This patch as provided breaks my build due to a missing semicolon.
> 
> ..
>
> -	random_ether_addr(addr)
> +	random_ether_addr(addr);

ahem.  That must have had a lot of testing ;)

Jeff, could we pleeeeeze arrange for UML's `make allmodconfig' to work, and
to continue to work?

Right now it goes splut with

arch/um/os-Linux/sys-x86_64/registers.c: In function 'get_thread_regs':
arch/um/os-Linux/sys-x86_64/registers.c:85: error: 'JB_PC' undeclared (first use in this function)
arch/um/os-Linux/sys-x86_64/registers.c:85: error: (Each undeclared identifier is reported only once
arch/um/os-Linux/sys-x86_64/registers.c:85: error: for each function it appears in.)
arch/um/os-Linux/sys-x86_64/registers.c:86: error: 'JB_RSP' undeclared (first use in this function)
arch/um/os-Linux/sys-x86_64/registers.c:87: error: 'JB_RBP' undeclared (first use in this function)


How does one build uml-for-i386 on an x86_64 host, btw?
