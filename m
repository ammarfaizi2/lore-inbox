Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265550AbUFDCUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbUFDCUC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFDCUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:20:02 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:40905 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265554AbUFDCT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:19:59 -0400
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
	implementation
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40BFD839.7060101@yahoo.com.au>
References: <20040603094339.03ddfd42.pj@sgi.com>
	 <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach>
	 <40BFD839.7060101@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1086315563.7990.905.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 12:19:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 12:02, Nick Piggin wrote:
> Rusty Russell wrote:
> > So, opinion alert: if I were doing this, I'd probably live without this
> > macro; in my mind it crosses the "too much abstraction" line.  I did
> > momentarily wonder what this macro did when I saw it used in the
> > succeeding patches.
> 
> I think if you don't like that abstraction, there should be no
> cpumask type at all, just use the bitmap.
> 
> I don't see what you gain from having the cpumask type but having
> to get at its internals with the bitop functions.

Yes, that was the previous debate to which I alluded, although having a
separate type helps make typesafe functions.

But to clarify: my question here was over the cpu_addr() macro.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

