Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVCONbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVCONbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCON3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:29:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:56738 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261221AbVCON3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:29:12 -0500
Subject: Re: swsusp_restore crap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050315120217.GE1344@elf.ucw.cz>
References: <1110857069.29123.5.camel@gaston>
	 <1110857516.29138.9.camel@gaston> <20050315110309.GA1344@elf.ucw.cz>
	 <200503151251.01109.rjw@sisk.pl>  <20050315120217.GE1344@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 00:27:08 +1100
Message-Id: <1110893228.24296.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > +asmlinkage int __swsusp_flush_tlb(void)
> > +{
> > +	swsusp_restore_check();
> 
> Someone will certainly forget this one, and it is probably
> nicer/easier to just move BUG_ON into swsusp_suspend(), just after
> restore_processor_state() or something like that...

Agreed.

Ben.

