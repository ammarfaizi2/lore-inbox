Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVIKOCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVIKOCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVIKOCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:02:30 -0400
Received: from mail.aknet.ru ([82.179.72.26]:27653 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932090AbVIKOC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:02:29 -0400
Message-ID: <432438F0.4090003@aknet.ru>
Date: Sun, 11 Sep 2005 18:02:24 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
Cc: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
References: <431C20560200007800023E6F@emea1-mh.id2.novell.com>
In-Reply-To: <431C20560200007800023E6F@emea1-mh.id2.novell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jan Beulich wrote:
> mainline, but I just now came across this, and following all of the
> original discussion that I was able to locate I didn't see any mention
> of a potential different approach to solving the problem which, as it
There were at least 3 fundamentally different
approaches proposed by different people, I implemented
and posted all of them. At least 2 approaches were
publically discussed. Both did what you say. The
one that didn't, wasn't publically discussed either
(the one that ended up in 2.6.12, in fact).
So it is a bit odd that you weren't able to find
the code that does what you say. :)

> would appear to me, requires much less code changes: Instead of
> allocating a separate stack to set intermediately, the 16-bit stack
> segment could be mapped directly onto the normal, flat kernel stack,
Do you mean, eg, this?
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1533.html

Relevant quote:
---
> ring1 stacks must be per-CPU.
I allocate it on a ring0 stack. Noone seem to
suggest that. Is this flawed for some reasons?
---

