Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263689AbUD0Cdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263689AbUD0Cdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUD0Cdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:33:39 -0400
Received: from colin2.muc.de ([193.149.48.15]:51978 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263689AbUD0Cd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:33:28 -0400
Date: 27 Apr 2004 04:33:27 +0200
Date: Tue, 27 Apr 2004 04:33:27 +0200
From: Andi Kleen <ak@muc.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
Subject: Re: sched_domains and Stream benchmark
Message-ID: <20040427023327.GB11321@colin2.muc.de>
References: <1N7xQ-7fh-29@gated-at.bofh.it> <m3r7uitr1r.fsf@averell.firstfloor.org> <1083018633.3070.8.camel@farah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083018633.3070.8.camel@farah>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed your binary ran with N=2000000 which is only sufficient for a
> 2 proc 1 MB cache opteron box according to the documentation on the

It does not seem to make any difference. 

> stream faq.  I also noticed wide variation in results (25% or so) when
> running with 4 threads on a 4 proc opteron on linux-2.6.5-mm5.  Can you
> provide me with the specs of the system you ran your tests on?

Yes, mm5 is still broken because it has the "tuned to numasaurus" numa
scheduler. Run it on a standard (non mm*) kernel or with Ingo's early 
load balance patch.

-Andi
