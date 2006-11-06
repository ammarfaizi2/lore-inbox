Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753169AbWKFUFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbWKFUFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbWKFUFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:05:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46990 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1753169AbWKFUFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:05:54 -0500
Date: Mon, 6 Nov 2006 21:05:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: locking hierarchy based on lockdep
Message-ID: <20061106200529.GA15370@elte.hu>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jason Baron <jbaron@redhat.com> wrote:

> I've implemented this as a /proc file, but Ingo suggested that it 
> might be better for us to simply produce an adjaceny list, and then 
> generate a locking hierarchy or anything else of interest off of that 
> list.... [...]

this would certainly be the simplest thing to do - we could extend 
/proc/lockdep with the list of 'immediately after' locks separated by 
commas. (that list already exists: it's the lock_class.locks_after list)

i like your idea of using lockdep to document locking hierarchies.

	Ingo
