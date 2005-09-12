Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVILHKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVILHKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVILHKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:10:24 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:32194
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750927AbVILHKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:10:23 -0400
Message-Id: <432546350200007800024DFF@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 12 Sep 2005 09:11:17 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Stas Sergeev" <stsp@aknet.ru>
Cc: <vandrove@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
References: <431C20560200007800023E6F@emea1-mh.id2.novell.com> <432438F0.4090003@aknet.ru>
In-Reply-To: <432438F0.4090003@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Stas Sergeev <stsp@aknet.ru> 11.09.05 16:02:24 >>>
>Jan Beulich wrote:
>> mainline, but I just now came across this, and following all of the
>> original discussion that I was able to locate I didn't see any
mention
>> of a potential different approach to solving the problem which, as
it
>There were at least 3 fundamentally different
>approaches proposed by different people, I implemented
>and posted all of them. At least 2 approaches were
>publically discussed. Both did what you say. The
>one that didn't, wasn't publically discussed either
>(the one that ended up in 2.6.12, in fact).
>So it is a bit odd that you weren't able to find
>the code that does what you say. :)
>
>> would appear to me, requires much less code changes: Instead of
>> allocating a separate stack to set intermediately, the 16-bit stack
>> segment could be mapped directly onto the normal, flat kernel
stack,
>Do you mean, eg, this?
>http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1533.html 

No, I don't. This talks about going through ring 1 intermediately,
which isn't what I have in mind.

>Relevant quote:
>---
>> ring1 stacks must be per-CPU.
>I allocate it on a ring0 stack. Noone seem to
>suggest that. Is this flawed for some reasons?
>---

Jan
