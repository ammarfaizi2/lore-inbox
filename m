Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVKVNnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVKVNnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVKVNnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:43:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56017 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750822AbVKVNny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:43:54 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1132657991.15117.76.camel@baythorne.infradead.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	 <1132611631.11842.83.camel@localhost.localdomain>
	 <1132657991.15117.76.camel@baythorne.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 14:15:39 +0000
Message-Id: <1132668939.20233.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 11:13 +0000, David Woodhouse wrote:
> Yes, there are drivers which are currently broken and assume irq 0 is
> 'no irq'. They are broken. Let's just fix them and not continue the
> brain-damage.

0 in the Linux kernel has always meant 'no IRQ' and it makes it natural
to express in C (and on some cpus more efficient too).

What if my hardware has an IRQ -1 ;)

