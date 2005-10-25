Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVJYWkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVJYWkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVJYWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:40:16 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:40104 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932454AbVJYWkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:40:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Oqv15FfF/yf/GPwclw+uxtVYXRexCKAgH+s+0T9VWBIZtJZ6/g9/w/zQWAljlVTaEedfeB3K6pUtyP5cZ2Mek9ghxpGfZOCsUDIT1+iE9It10NTrupeSwv6XnREK9Vsu2tAP3rV10SP8hBKmpGfXMkFq3SyKjHdpP9AoaV1f8kQ=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/6] x86_64: enable xchg optimization for x86_64
Date: Wed, 26 Oct 2005 00:44:15 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20051025221105.21106.95194.stgit@zion.home.lan> <20051025221351.21106.57194.stgit@zion.home.lan> <200510260022.28095.ak@suse.de>
In-Reply-To: <200510260022.28095.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260044.17184.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 00:22, Andi Kleen wrote:
> On Wednesday 26 October 2005 00:13, Paolo 'Blaisorblade' Giarrusso wrote:
> > I.e. the implementation was written, is present in the tree, but due to
> > this:
> >
> > #ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
> > #include <linux/rwsem-spinlock.h> /* use a generic implementation */
> > #else
> > #include <asm/rwsem.h> /* use an arch-specific implementation */
> > #endif
> >
> > it was probably _NEVER_ compiled!!!

> Actually it was, but we switched it back because there were some doubts
> on the correctness of the xchg based implementation and the generic
> one looked much cleaner. So far nobody showed a significant performance
> different too.

> I should probably remove asm/rwsem.h.
That's fine too, the current situation is clearly bogus.
Thanks for the quick answer.

> Don't apply please.
Agreed.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
