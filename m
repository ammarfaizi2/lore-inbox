Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUF1XMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUF1XMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUF1XMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:12:24 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:33286 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265290AbUF1XL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:11:59 -0400
Message-ID: <1088455953.40e08511b746b@vds.kolivas.org>
Date: Tue, 29 Jun 2004 06:52:33 +1000
From: kernel@kolivas.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck1
References: <200406162122.51430.kernel@kolivas.org> <1087576093.2057.1.camel@teapot.felipe-alfaro.com> <20040628224623.GA11333@elf.ucw.cz>
In-Reply-To: <20040628224623.GA11333@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
> > > Patchset update. The focus of this patchset is on system responsiveness
> with
> > > emphasis on desktops, but the scope of scheduler changes now makes this
> patch 
> > > suitable to servers as well.
> > 
> > I've found some interaction problems between, what I think it's, the
> > staircase scheduler and swsusp. With vanilla 2.6.7, swsusp is able to
> > save ~9000 pages to disk in less than 5 seconds, where as 2.6.7-ck1
> > takes more than 1 minute to save the same amount of pages when
> > suspending to disk.
> 
> That's probably bug in io subsystem. That happened few times in suse
> kernel. Missing unplug?

Thanks. Turned out to be a buggy yield() implementation on my part. Fixed in
later -ck versions.

Cheers,
Con

