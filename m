Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVCEXej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVCEXej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 18:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCEXdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:33:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:9124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261227AbVCEXaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:30:39 -0500
Date: Sat, 5 Mar 2005 15:30:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] ppc64-implement-a-vdso-and-use-it-for-signal-trampoline
 gas workaround
Message-Id: <20050305153010.4a621d92.akpm@osdl.org>
In-Reply-To: <1110062967.13607.82.camel@gaston>
References: <200503051830.j25IU4Vq007528@hera.kernel.org>
	<1110062967.13607.82.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sat, 2005-03-05 at 17:33 +0000, Linux Kernel Mailing List wrote:
>  > ChangeSet 1.2212, 2005/03/05 09:33:46-08:00, akpm@osdl.org
>  > 
>  > 	[PATCH] ppc64-implement-a-vdso-and-use-it-for-signal-trampoline gas workaround
>  > 	
>  > 	I cannot find a version of binutils which doesn't either do
>  > 	
>  > 	arch/ppc64/kernel/vdso32/gettimeofday.S: Assembler messages:
>  > 	arch/ppc64/kernel/vdso32/gettimeofday.S:33: Error: syntax error; found `@' but expected `,'
> 
>  Ugh... Do that still happen once you finally get it to build with a 32
>  bits compiler and not a 64 bits one ? The @local is actually needed for
>  the 32 bits build.

Yes, you're right.  We can revert 1.2212 please.
