Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317203AbSFLVv1>; Wed, 12 Jun 2002 17:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSFLVv0>; Wed, 12 Jun 2002 17:51:26 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:16369 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317203AbSFLVv0>; Wed, 12 Jun 2002 17:51:26 -0400
Date: Wed, 12 Jun 2002 17:51:27 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Message-ID: <20020612175127.A4081@redhat.com>
In-Reply-To: <200206100356.UAA17066@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 08:56:30PM -0700, Dawson Engler wrote:
> Here are 37 errors where variables >= 1024 bytes are allocated on a function's
> stack.

Is it possible to get checker to determine the stack depth of a worst 
case call chain (excluding interrupts)?  I've found that deep call chains 
are far more likely to cause stack overflows than short and bounded paths.

		-ben
