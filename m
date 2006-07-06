Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWGFMBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWGFMBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWGFMBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:01:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51677 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030223AbWGFMBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:01:12 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
References: <20060705114630.GA3134@elte.hu>
	 <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu>
	 <20060705131824.52fa20ec.akpm@osdl.org>
	 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	 <20060705204727.GA16615@elte.hu>
	 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	 <20060705214502.GA27597@elte.hu>
	 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	 <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	 <20060706081639.GA24179@elte.hu>
	 <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 14:01:07 +0200
Message-Id: <1152187268.3084.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 07:59 -0400, linux-os (Dick Johnson) wrote:
> On Thu, 6 Jul 2006, Ingo Molnar wrote:
> 
> >
> > * Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >> I wonder if we should remove the "volatile". There really isn't
> >> anything _good_ that gcc can do with it, but we've seen gcc code
> >> generation do stupid things before just because "volatile" seems to
> >> just disable even proper normal working.
> 
> Then GCC must be fixed. The keyword volatile is correct. It should
> force the compiler to read the variable every time it's used.

this is not really what the C standard says.



> This is not pointless. If GCC generates bad code, tell the
> GCC people. The volatile keyword is essential.

no the "volatile" semantics are vague, trecherous and evil. It's a LOT
better to insert the well defined "barrier()" in the right places.


