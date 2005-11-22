Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVKVSUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVKVSUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVKVSUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:20:16 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:53920 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965078AbVKVSUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:20:15 -0500
Date: Tue, 22 Nov 2005 11:20:14 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051122182014.GO1598@parisc-linux.org>
References: <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu> <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <1132611631.11842.83.camel@localhost.localdomain> <1132657991.15117.76.camel@baythorne.infradead.org> <1132668939.20233.47.camel@localhost.localdomain> <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 09:03:12AM -0800, Linus Torvalds wrote:
> In short: NO_IRQ _is_ 0. Always has been. It's the only sane value. And 
> btw, there is no need for that #define at all, exactly because the way you 
> test for "is this no irq" is by doing "!dev->irq".

Could you at least take the first patch that checks that we don't go
outside the bounds of the irq_desc array?
