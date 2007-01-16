Return-Path: <linux-kernel-owner+w=401wt.eu-S1751391AbXAPRvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAPRvk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXAPRvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:51:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48531 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbXAPRvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:51:39 -0500
Date: Tue, 16 Jan 2007 18:50:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Pierre Peiffer <pierre.peiffer@bull.net>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
Message-ID: <20070116175021.GA9778@elte.hu>
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net> <20070112075816.GA23341@elte.hu> <45AC8E2A.3060708@bull.net> <45ACEBDF.60602@redhat.com> <20070116154054.GA21786@elte.hu> <45AD0F70.30808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AD0F70.30808@redhat.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ulrich Drepper <drepper@redhat.com> wrote:

> > what do you mean by that - which is this same resource?
> 
> From what has been said here before, all futexes are stored in the 
> same list or hash table or whatever it was.  I want to see how that 
> code behaves if many separate processes concurrently use futexes.

futexes are stored in the bucket hash, and these patches do not change 
that. The pi-list that was talked about is per-futex. So there's no 
change to the way futexes are hashed nor should there be any scalability 
impact - besides the micro-impact that was measured in a number of ways 
- AFAICS.

	Ingo
