Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVKUVZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVKUVZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVKUVZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:25:35 -0500
Received: from ozlabs.org ([203.10.76.45]:32235 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750753AbVKUVZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:25:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
Date: Tue, 22 Nov 2005 08:25:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <20051121211544.GA4924@elte.hu>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	<24299.1132571556@warthog.cambridge.redhat.com>
	<20051121121454.GA1598@parisc-linux.org>
	<Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	<20051121190632.GG1598@parisc-linux.org>
	<Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	<20051121194348.GH1598@parisc-linux.org>
	<Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	<20051121211544.GA4924@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> is there any architecture where irq 0 is a legitimate setting that could 
> occur in drivers, and which would make NO_IRQ define of 0 non-practical?  

Yes, G5 powermacs have the SATA controller on irq 0.  So if we can't
use irq 0, I can't get to my hard disk. :)  Other powermacs also use
irq 0 for various things, as do embedded PPC machines.

Paul.
