Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUF2ITw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUF2ITw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 04:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbUF2ITw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 04:19:52 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:7684 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265531AbUF2ITv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 04:19:51 -0400
Subject: Re: 2.6.7-ck1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040628224623.GA11333@elf.ucw.cz>
References: <200406162122.51430.kernel@kolivas.org>
	 <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
	 <20040628224623.GA11333@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 29 Jun 2004 10:19:46 +0200
Message-Id: <1088497186.2733.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 00:46 +0200, Pavel Machek wrote:

> > I've found some interaction problems between, what I think it's, the
> > staircase scheduler and swsusp. With vanilla 2.6.7, swsusp is able to
> > save ~9000 pages to disk in less than 5 seconds, where as 2.6.7-ck1
> > takes more than 1 minute to save the same amount of pages when
> > suspending to disk.
> 
> That's probably bug in io subsystem. That happened few times in suse
> kernel. Missing unplug?

It seems it was a bug in the yield() logic with the staircase scheduler,
as it has been fixed in -ck2 and -ck3. Surely, it was *not* a problemw
with swsusp.

