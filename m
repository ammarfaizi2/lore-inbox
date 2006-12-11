Return-Path: <linux-kernel-owner+w=401wt.eu-S1763117AbWLKV0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763117AbWLKV0K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763124AbWLKV0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:26:09 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:58946 "EHLO sMtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763117AbWLKV0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:26:08 -0500
Date: Mon, 11 Dec 2006 21:44:34 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] group xtime, xtime_lock, wall_to_monotonic, avenrun,
 calc_load_count fields together in ktimed
In-reply-to: <20061208214625.90e010ae.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Message-id: <457DC332.3090805@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061206234942.79d6db01.akpm@osdl.org>
 <457849E2.3080909@garzik.org> <20061207095715.0cafffb9.akpm@osdl.org>
 <200612081752.09749.dada1@cosmosbay.com>
 <20061208214625.90e010ae.akpm@osdl.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> 
> hm, the patch seems to transform a mess into a mess.  I guess it's a messy
> problem.
> 
> I agree that aggregating all the time-related things into a struct like
> this makes some sense.  As does aggregating them all into a similar-looking
> namespace, but that'd probably be too intrusive - too late for that.


Hi Andrew, thanks for your comments.

I sent two patches for the __attribute__((weak)) xtime_lock thing, and 
calc_load() optimization, which dont depend on ktimed.

Should I now send patches for aggregating things or is it considered too 
intrusive ? (Sorry if I didnt understand your last sentence)

If yes, should I send separate patches to :

1) define an empty ktimed (or with a placeholder for jiffies64, not yet used)
2) move xtime into ktimed
3) move xtime_lock into ktimed
4) move wall_to_monotonic into ktimed
5) move calc_load.count into ktimed
6) move avenrun into ktimed.
7) patches to use ktimed.jiffies64 on various arches (with the problem of 
aliasing jiffies)

Thank you
Eric

