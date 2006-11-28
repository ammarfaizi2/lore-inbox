Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936021AbWK1S5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936021AbWK1S5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936020AbWK1S5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:57:13 -0500
Received: from cantor2.suse.de ([195.135.220.15]:62681 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S936021AbWK1S5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:57:11 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] x86_64: fix earlyprintk=...,keep regression
Date: Tue, 28 Nov 2006 19:57:07 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061128081405.GA9031@elte.hu> <Pine.LNX.4.64.0611281048170.4244@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611281048170.4244@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611281957.07362.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Or is there some reason you really _want_ "keep" to be different? If so, 
> it should probably be commented on.

It's just that keep is the only option that can only be at the end, all
others can be followed by more, so it
made minor sense to use strcmp() to match the \0 too. But using strncmp
everywhere is fine too since the syntax checking on these things is always
quite weak and it probably doesn't make much difference either way. 

I would have gone with Ingo's fix, but if you prefer strncmp..? 

-Andi
