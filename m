Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVCJCUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVCJCUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVCJCUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:20:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:27846 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261525AbVCJCPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:15:30 -0500
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Omkhar Arasaratnam <iamroot@ca.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <422FA817.4060400@ca.ibm.com>
References: <422FA817.4060400@ca.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 13:10:20 +1100
Message-Id: <1110420620.32525.145.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 19:51 -0600, Omkhar Arasaratnam wrote:
> Seems with 2.6.11 the sym53c8xx kernel module incorrectly identifies the
> cache being misconfigured on a p630 (ppc64, POWER4+). 2.6.9 correctly
> brings up this adaptor as does AIX with absolutely no indication of a
> misconfigured cache.
> 
> Doing a simple diff I see ALOT of changes between 2.6.9 and 2.6.11
> pertaining to this module. Any ideas?

Are you sure it's plain 2.6.11 and not some bk clone of after 2.6.11 was
released ?

I just found a bug in the ppc64 ioremap code that got triggered by
the set_pte_at() patch that went into bk after 2.6.11 and that triggers
exactly that error, but I couldn't see anything wrong in 2.6.11 proper.

BTW, Linus: Any chance you ever change something to version or
extraversion in bk just after a release ? I know I already ask and it
degenerated into a flamefest, and I don't know if that is specifically
the case now, but I keep getting report of people saying "I have a bug
in 2.6.xx" while in fact, they have some kind of bk clone of sometime
after 2.6.xx...

Ben.


