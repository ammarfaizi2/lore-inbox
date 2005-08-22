Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVHVUoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVHVUoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVHVUoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:44:22 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41959 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751169AbVHVUoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:44:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Kwd6QfdVZRBabgcy6YQiHoHt953UIV/JSTeZW7ZdS1o8wUq/tTolDaqbcc2beh+haS/CZ2HZ2Bra7ZtS/g8E7asaa/Cj1xMKaz+tNQ69g+IMsH1Z6ELzHzliXW+OBsJKki2ljcv3kvxxqksvRnYE1c0a56XgMQIRg0QhAghBr3k=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] [patch 0/39] remap_file_pages protection support, try 2
Date: Mon, 22 Aug 2005 18:07:57 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200508122033.06385.blaisorblade@yahoo.it> <20050814013849.GA23795@elte.hu>
In-Reply-To: <20050814013849.GA23795@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508221807.58354.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 August 2005 03:38, Ingo Molnar wrote:
> * Blaisorblade <blaisorblade@yahoo.it> wrote:

> > Ok, I've been working for the past two weeks learning well the Linux
> > VM, understanding the Ingo's remap_file_pages protection support and
> > its various weakness (due to lack of time on his part), and splitting
> > and finishing it.

> > Here follow a series of 39 _little_ patches against the git-commit-id
> > 889371f61fd5bb914d0331268f12432590cf7e85, which means between
> > 2.6.13-rc4 and -rc5.

> > Actually, the first 7 ones are unrelated trivial cleanups which
> > somehow get in the way on this work and that can probably be merged
> > even now (many are just comment fixes).

> > Since I was a VM newbie until two weeks ago, I've separated my changes
> > into many little patches.

> hi. Great work! I'm wondering about this comment in
Thanks for your appreciation.
> rfp-fix-unmap-linear.patch:
> > Additionally, add a missing TLB flush in both locations. However,
> > there'is some excess of flushes in these functions.

> excess TLB flushes one of the reasons of bad UML performance, so you
> should really review them and not do spurious TLB flushes.

After a bit of thought I realized that there was no spurious flush in those 
function, and that I didn't need to add any, because after setting a PTE as 
missing and flushing the TLB, I can freely alter it if I don't make it 
present again (right?), without other TLB flushes.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
