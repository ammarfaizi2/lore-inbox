Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUHaJy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUHaJy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUHaJy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:54:27 -0400
Received: from gepard.lm.pl ([212.244.46.42]:55015 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S267620AbUHaJyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:54:25 -0400
Subject: Re: 2.6.9-rc1-mm1 kjournald: page allocation failure. order:1,
	mode:0x20
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040830125742.18c38277.akpm@osdl.org>
References: <1093794970.1751.10.camel@rakieeta>
	 <20040829160257.3b881fef.akpm@osdl.org> <1093873432.1786.16.camel@rakieeta>
	 <20040830125742.18c38277.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-2
Organization: o2.pl Sp z o.o.
Message-Id: <1093945972.1715.2.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 31 Aug 2004 11:52:53 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W li¶cie z pon, 30-08-2004, godz. 21:57, Andrew Morton pisze: 
> Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
> >
> > > There should have been a stack trace as well.  Please send it.
> >  > 
> > 
> >  this time there is an attachement.
> 
> OK.  It's netfilter.  Trying to allocate two physically contiguous
> pages with GFP_ATOMIC.  This is expected to fail, and networking will
> recover OK.
> 
> The networking guys are cooking up a fix for this, I believe.

ok, I gues I might try without a netfilter, I've also seen similiar
messages about kjournald allocation, but next line would say stack
pointer is garbage, not printing. Would it be some leftover after
netfilter problems during the run or should I try to reproduce that
behaviour and wait for some meaningful output ?

Krzysztof.


