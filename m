Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVDYWtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVDYWtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVDYWtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:49:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:52168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261271AbVDYWtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:49:49 -0400
Date: Mon, 25 Apr 2005 15:51:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: handle iret faults better
In-Reply-To: <200504252231.j3PMVPTb010573@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0504251548310.18901@ppc970.osdl.org>
References: <200504252231.j3PMVPTb010573@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Roland McGrath wrote:
> 
> 								   We want
>  * to turn it into a signal.  To make that signal's info exactly match what
>  * this same kind of fault in a user instruction would show, the fixup
>  * needs to know the trapno and error code.  But those are lost when we get
>  * back to the fixup entrypoint.  

Bah.

The _information_ is there, it's right on the stack-frame in the original 
CS/SS etc.

I'll take reliable and obvious code _any_ day over hacky code just to get 
me an "error code" for something that just isn't very interesting.

In other words, your code is not only ugly, it's also the kind of code 
that makes you go "how does that work". 

I think it's a lot more important that the kernel obviously work 
correctly.

			Linus
