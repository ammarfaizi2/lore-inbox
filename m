Return-Path: <linux-kernel-owner+w=401wt.eu-S1753665AbWL1RKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbWL1RKg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbWL1RKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:10:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44738 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbWL1RKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:10:35 -0500
Date: Thu, 28 Dec 2006 09:08:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <97a0a9ac0612272158h72f75a2bt22eccddcbbb2d9a9@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612280906270.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net> 
 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> 
 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> 
 <20061227.165246.112622837.davem@davemloft.net>  <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
  <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> 
 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> 
 <97a0a9ac0612272115g4cce1f08n3c3c8498a6076bd5@mail.gmail.com> 
 <Pine.LNX.4.64.0612272120180.4473@woody.osdl.org>
 <97a0a9ac0612272158h72f75a2bt22eccddcbbb2d9a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2006, Gordon Farquharson wrote:
> 
> 100kB and 200kB files always succeed on the ARM system. 400kB and
> larger always seem to fail.

Oh, wow. Yeah, I've just repressed how tiny 32MB is. And especially if you 
lowered the /proc/sys/vm/dirty_ratio to a smaller percentage, I guess 
400kB should be enough to cause writeback.

Ugh. I tested a 128MB machine a few weeks ago, and found it painful.

		Linus
