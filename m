Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317478AbSFMGhB>; Thu, 13 Jun 2002 02:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317480AbSFMGhA>; Thu, 13 Jun 2002 02:37:00 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:3485 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S317478AbSFMGg7>;
	Thu, 13 Jun 2002 02:36:59 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206130636.XAA08465@csl.Stanford.EDU>
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Wed, 12 Jun 2002 23:36:58 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <20020612175127.A4081@redhat.com> from "Benjamin LaHaise" at Jun 12, 2002 05:51:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, Jun 09, 2002 at 08:56:30PM -0700, Dawson Engler wrote:
> > Here are 37 errors where variables >= 1024 bytes are allocated on a function's
> > stack.
> 
> Is it possible to get checker to determine the stack depth of a worst 
> case call chain (excluding interrupts)?  I've found that deep call chains 
> are far more likely to cause stack overflows than short and bounded paths.

Yeah, it's not that hard.  The main problem is determining if recursive
loops are feasible.  I'd released bugs from it before, but no one fixed any
so hadn't rerun it since.
