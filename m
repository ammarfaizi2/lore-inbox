Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbUK2WjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbUK2WjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUK2Wft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:35:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53386 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261849AbUK2WeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:34:07 -0500
Date: Mon, 29 Nov 2004 23:32:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: scheduler BUGON lifespan
Message-ID: <20041129223247.GA27705@elte.hu>
References: <1101762694.29380.23.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101762694.29380.23.camel@farah.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> I submitted a patch to active_load_balance() that was accepted into mm
> and then mainline.  The patch included a fix to prevent the system
> entering what should have been an impossible state.  The previous code
> tested for it and then continued, rather than crashing or complaining.
> My patch added a BUGON(impossible state) just in case by some fluke it
> still happened.  How long should this BUGON remain in the kernel?  A
> month, a year?  Is there an accepted duration for such safety nets?

it's pretty random how long it survives. Sometimes i remove one after
never having seen it for months/years and grepping lkml and googling
around for the file & line. The BUG_ON()s are pretty cheap, as they
often check what is being fetched anyway.

	Ingo
