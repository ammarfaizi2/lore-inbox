Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWIWUq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWIWUq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIWUq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:46:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4541 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964894AbWIWUq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:46:58 -0400
Date: Sat, 23 Sep 2006 22:39:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christian Weiske <cweiske@cweiske.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference at virtual address 000,0000a
Message-ID: <20060923203907.GA10756@elte.hu>
References: <45155915.7080107@cweiske.de> <20060923134244.e7b73826.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923134244.e7b73826.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > EIP is at scheduler_tick+0x84/0x340
> > eax: 00000002   ebx: c7eec590   ecx: c5e960d5   edx: 4457222b
> > esi: c5e96100   edi: 0000002b   ebp: c7f43864   esp: c7f43850

hm, edx looks quite ASCII-ish:

  +"WD

which could suggest some hw problem or memory scribble. (or not)

	Ingo
