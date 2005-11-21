Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVKUVtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVKUVtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVKUVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:49:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:59873 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751082AbVKUVs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:48:59 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Nov 2005 22:20:31 +0000
Message-Id: <1132611631.11842.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 08:25 +1100, Paul Mackerras wrote:
> Ingo Molnar writes:
> 
> > is there any architecture where irq 0 is a legitimate setting that could 
> > occur in drivers, and which would make NO_IRQ define of 0 non-practical?  
> 
> Yes, G5 powermacs have the SATA controller on irq 0.  So if we can't
> use irq 0, I can't get to my hard disk. :)  Other powermacs also use
> irq 0 for various things, as do embedded PPC machines.

G5 powermacs have the SATA controller on physical IRQ value 0. Linux IRQ
values don't need to exactly map. One of the x86 ports handles 'real IRQ
0' exactly this way. Its a cookie. Sure would benefit from a function
for turning an IRQ into a description as a cleanup.

Alan

