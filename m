Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264504AbRFJHpk>; Sun, 10 Jun 2001 03:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264505AbRFJHpa>; Sun, 10 Jun 2001 03:45:30 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:28292 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S264504AbRFJHpL>;
	Sun, 10 Jun 2001 03:45:11 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106100745.AAA20952@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 10 Jun 2001 00:45:05 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106092313280.27431-100000@penguin.transmeta.com> from "Linus Torvalds" at Jun 09, 2001 11:19:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sure, it's a pretty interaction.  To be sure about the rule: any *_user
> > call can be treated as an implicit invocation of do_page_fault?  
> 
> As a first approximation, yes. The exception cases are certain callers
> that use kernel addresses and set_fs(KERNEL_DS) in order to "fake"
> arguments to system calls etc, but I doubt they should need any
> special-casing.

I already have to special case the set_fs calls for the user-pointer
security checker.  It shouldn't be too much trouble to reuse the code.
Thanks for the early warning.

Dawson
