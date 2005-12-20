Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVLTTcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVLTTcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVLTTcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:32:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5054 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750979AbVLTTcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:32:45 -0500
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
	add-atomic-call-func-x86_64.patch
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@cam.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
In-Reply-To: <20051220192018.GB24199@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
	 <1135025932.4760.1.camel@localhost.localdomain>
	 <20051220043109.GC32039@elte.hu>
	 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
	 <43A7BCE1.7050401@yahoo.com.au>
	 <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain>
	 <43A81132.8040703@yahoo.com.au>
	 <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain>
	 <43A81DD4.30906@yahoo.com.au>
	 <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain>
	 <20051220192018.GB24199@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 20:32:35 +0100
Message-Id: <1135107155.2952.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, to sum up, if this path is persued, mutexes will be a bloody
> disaster on ARM.  We'd be far better off sticking to semaphores
> and ignoring this mutex stuff.

on x86 the fastpath is the same for both basically.. is there a
fundamental reason it can't be for ARM?

