Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272223AbTHIHXc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 03:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272272AbTHIHXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 03:23:32 -0400
Received: from [66.212.224.118] ([66.212.224.118]:40455 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272223AbTHIHX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 03:23:29 -0400
Date: Sat, 9 Aug 2003 03:11:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Yaroslav Halchenko <yoh@onerussian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unexpected IRQ trap at vector a0
In-Reply-To: <20030809022532.GA6345@washoe.rutgers.edu>
Message-ID: <Pine.LNX.4.53.0308090309090.32166@montezuma.mastecende.com>
References: <20030809022532.GA6345@washoe.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Yaroslav Halchenko wrote:

> Dear developers and bug-finders,
> 
> I've got a new desktop - some kind of Pentium IV with hyper-threading,
> so immediately decided to switch it to 2.6.0-test2-bk8 kernel which was
> running on my desktop/laptops for quite a while, but I've got next
> problem: when it boots I begin getting my console as well as
> syslog/messages flooded with
> 
> unexpected IRQ trap at vector a0

  9:     100000          0          XT-PIC  acpi

Cute, the interrupt storm monitor caught it dead =) Can you verify whether 
booting with the kernel parameter noirqdebug 'fixes' things? Also boot 
with the 'debug' kernel parameter as it will print out things like what is 
at vector a0.

Thanks,
	Zwane
