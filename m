Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbWJCFvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbWJCFvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbWJCFvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:51:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965265AbWJCFvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:51:14 -0400
Date: Mon, 2 Oct 2006 22:50:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/6] From: Andrew Morton <akpm@osdl.org>
Message-Id: <20061002225053.46be0324.akpm@osdl.org>
In-Reply-To: <17697.62198.476469.265990@cargo.ozlabs.ibm.com>
References: <20061003010842.438670755@goop.org>
	<20061003010933.392428107@goop.org>
	<17697.58794.113796.925995@cargo.ozlabs.ibm.com>
	<20061002213347.8229b6fc.akpm@osdl.org>
	<17697.62198.476469.265990@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 15:19:50 +1000
Paul Mackerras <paulus@samba.org> wrote:

> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -503,7 +503,7 @@ #endif
>  
>  	mtmsr(msr);		/* restore interrupt enable */
>  
> -	return cmd != 'X';
> +	return cmd != 'X' && cmd != EOF;
>  }
>  
>  int xmon(struct pt_regs *excp)

That fixes it.

I still get crap all over the screen when xmon is tring to print something
(at least, I assume that's what causes it).  See
http://userweb.kernel.org/~akpm/s5000334.jpg

