Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVBYLoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVBYLoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVBYLoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:44:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:45519 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262677AbVBYLoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:44:19 -0500
Date: Fri, 25 Feb 2005 03:43:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, Ian.Pratt@cl.cam.ac.uk,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-Id: <20050225034316.0e0c994e.akpm@osdl.org>
In-Reply-To: <p73acsg1za1.fsf@bragg.suse.de>
References: <41BF1983.mailP9C1B91GB@suse.de.suse.lists.linux.kernel>
	<p73acsg1za1.fsf@bragg.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> In my opinion it's still an extremly bad idea to have arch/xen
>  an own architecture.

Guys, I'd like to kick this a bit further down the road.  Things still seem
to be somewhat deadlocked.

To summarise my understanding:

The Xen team still believe that it's best to keep arch/xen, arch/xen/i386,
arch/xen/x86_64, etc.  And I believe that Andi (who is the world expert on
maintaining an i386 derivative) thinks that this is will be a long-term
maintenance problem.

I tend to agree with Andi, and I'm not sure that the Xen team fully
appreciate the downside of haveing an own-architecture in the kernel.org
kernel and the upside of having their code integrated with the
most-maintained architecture.  It could be that the potential problems
haven't been sufficiently well communicated.

Christian has mentioned that Xen would need to hook into the i386 code in
~60 places, which is somewhat more than Ian's 37-bullet-point list.

I get the impression that the Xen team are overly reluctant to make changes
to the arch/i386 code and to arch-neutral kernel code.  Don't do that - new
abstractions, refactoring and generally moving things about is generally a
safe thing to do, and can often make things better anyway.

So.  Has anyone changed position or otherwise converged?  How do we get
this resolved?
