Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTJULLP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJULLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:11:15 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:9615 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262801AbTJULLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:11:13 -0400
Date: Tue, 21 Oct 2003 13:11:12 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Emmanuel Fleury <fleury@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel...
Message-ID: <20031021111112.GC4663@DUK2.13thfloor.at>
Mail-Followup-To: Emmanuel Fleury <fleury@cs.auc.dk>,
	linux-kernel@vger.kernel.org
References: <1065623368.15369.35.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065623368.15369.35.camel@rade7.s.cs.auc.dk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 04:29:28PM +0200, Emmanuel Fleury wrote:
> Hi,
> 
> I am pretty new in coding for the kernel and I was wandering what is the
> _deep_ meaning of:
> 
> "Unable to handle kernel paging request at virtual address XXXX" 

some page was requested, (probably via a pointer
dereference, read or write), which led to a page
fault, which in turn could not be satisfied by
loading/providing the requested page, because it
simply isn't there (usually wrong address)

> and 
> "Unable to handle kernel NULL pointer dereference".

some pointer (value = NULL) was dereferenced, which
should be considered an error, this caused the oops
which (probably) follows those lines (reg/stackdump)

	int *test = NULL;
	int v = test[0];	// bad!

> If somebody could explain this to me, I would be very pleased ! :)

probably there are better explanations,

HTH,
Herbert

> PS: I know already how to trace an Oops by using ksymoops. But these two
> errors are puzzling me and I would like to understand more about it.
> 
> Regards
> -- 
> Emmanuel
> 
> The tradition of open science has done more to build the modern
> economy than Microsoft ever will.
>   -- Linus Torvalds
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
