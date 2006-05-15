Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWEOThJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWEOThJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbWEOThJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:37:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751567AbWEOThH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:37:07 -0400
Date: Mon, 15 May 2006 12:39:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ak@suse.de, haveblue@us.ibm.com, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-Id: <20060515123929.76b9b693.akpm@osdl.org>
In-Reply-To: <20060515192614.GA24887@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org>
	<200605152037.54242.ak@suse.de>
	<1147719901.6623.78.camel@localhost.localdomain>
	<200605152111.20693.ak@suse.de>
	<20060515192614.GA24887@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> Nevertheless for hard-to-debug bugs i prefer if they can be reproduced 
> and debugged on 32-bit too, because x86_64 debugging is still quite a 
> PITA and wastes alot of time: for example it has no support for exact 
> kernel stacktraces. Also, the printout of the backtrace is butt-ugly and 
> as un-ergonomic to the human eye as it gets

Yes, I find x86_64 traces significantly harder to follow.  And I miss the
display of the length of the functions (do_md_run+1208 instead of
do_md_run+1208/2043).  The latter form makes it easier to work out
whereabouts in the function things happened.

That, plus the mix of hex and decimal numbers..

> who came up with that 
> "two-maybe-one function entries per-line" nonsense? [Whoever did it he 
> never had to look at (and make sense of) hundreds of stacktraces in a 
> row.]

Plus they're wide enough to get usefully wordwrapped when someone mails
them to you.

