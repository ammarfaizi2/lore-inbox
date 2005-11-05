Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVKERJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKERJR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKERJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:09:17 -0500
Received: from ns2.suse.de ([195.135.220.15]:13021 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750767AbVKERJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:09:16 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051029171630.04a69660.pj@sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 05 Nov 2005 18:09:14 +0100
In-Reply-To: <20051029171630.04a69660.pj@sgi.com>
Message-ID: <p73oe4z2f9h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:


Regarding cpumemset and alloc_pages. I recently rechecked
the cpumemset hooks in there and I must say they turned out
to be quite worse

In hindsight it would have been better to use the "generate
zonelists for all possible nodes" approach you originally had
and which I rejected (sorry) 

That would make the code much cleaner and faster.
Maybe it's not too late to switch for that?

If not then the fast path definitely needs to be tuned a bit.

-Andi

