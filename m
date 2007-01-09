Return-Path: <linux-kernel-owner+w=401wt.eu-S932523AbXAIXnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbXAIXnz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbXAIXnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:43:55 -0500
Received: from mail.suse.de ([195.135.220.2]:36084 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932523AbXAIXny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:43:54 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] x86_64: re-add a newline to RESTORE_CONTEXT
Date: Wed, 10 Jan 2007 00:43:48 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, "Steven M. Christey" <coley@mitre.org>
References: <20070109025516.GC25007@stusta.de> <200701092343.01112.ak@suse.de> <20070109145247.1ffc0cd3.akpm@osdl.org>
In-Reply-To: <20070109145247.1ffc0cd3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701100043.49092.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> In other words we'll leave it in its present buggy form so that it will
> explode next time someone tries to use it for something new, rather than a)

It shouldn't be used for anything new. It's really a private macro
in the context switch code, nothing that any other code is supposed
to use.

> fixing that potential problem and b) fixing a real problem with a popular
> external GPLed product.

kgdb shouldn't need any patches to core kernel I had it some time ago running fine
just by hooking it into the die hooks (and minor changes to the serial layer,
with netpoll these shouldn't be even needed anymore) 

If the kgdb people need more changes they should submit them.

But I suspect if they change RESTORE_CONTEXT they're doing something wrong
anyways and they just need to fix their code properly.

-Andi
