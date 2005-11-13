Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVKMCjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVKMCjB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 21:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVKMCjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 21:39:01 -0500
Received: from mx1.suse.de ([195.135.220.2]:43193 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750946AbVKMCjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 21:39:01 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 9/14] mm: page_state opt
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au>
	<436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au>
	<436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au>
	<436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au>
	<436DBDE5.2010405@yahoo.com.au> <436DBE03.90009@yahoo.com.au>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2005 03:38:59 +0100
In-Reply-To: <436DBE03.90009@yahoo.com.au>
Message-ID: <p73hdah46gs.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> 9/14
> 
> -- 
> SUSE Labs, Novell Inc.
> 
> Optimise page_state manipulations by introducing a direct accessor
> to page_state fields without disabling interrupts, in which case
> the callers must provide their own locking (either disable interrupts
> or not update from interrupt context).

I have a patchkit (which i need to update for the current kernel)
which replaces this with local_t. Gives much better code and is much
simpler and doesn't require turning off interrupts anywhere.

-Andi
