Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTL3EwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTL3Etp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:49:45 -0500
Received: from dp.samba.org ([66.70.73.150]:25518 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264457AbTL3Et3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:49:29 -0500
Date: Tue, 30 Dec 2003 13:47:03 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Add support for checking before-the-fact whether an IRQ is
Message-Id: <20031230134703.71379d63.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.58.0312291140360.2113@home.osdl.org>
References: <200312291905.hBTJ56k1032326@hera.kernel.org>
	<1072725508.4233.11.camel@laptop.fenrus.com>
	<Pine.LNX.4.58.0312291140360.2113@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 11:43:29 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:
> > question; which lock prevents someone else claiming the irq and making
> > it unsharable/unclaimable between can_request_irq() and the eventual
> > request_irq() ????
> 
> Nothing. It never did. This is basically a heuristic: "find the irq that 
> looks the least used".

I just worry about other people using it.  I'd prefer "irq_looks_free()",
but since it's x86-specific it's not a big issue.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
