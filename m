Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbSJOWJl>; Tue, 15 Oct 2002 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSJOWJk>; Tue, 15 Oct 2002 18:09:40 -0400
Received: from holomorphy.com ([66.224.33.161]:55960 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263320AbSJOWJk>;
	Tue, 15 Oct 2002 18:09:40 -0400
Date: Tue, 15 Oct 2002 15:11:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Marcus Alanen <marcus@infa.abo.fi>, maalanen@ra.abo.fi,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.5] __vmalloc allocates spurious page?
Message-ID: <20021015221132.GI27878@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Marcus Alanen <marcus@infa.abo.fi>, maalanen@ra.abo.fi,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210152221080.14143-100000@tuxedo.abo.fi> <200210152158.AAA18031@infa.abo.fi> <20021015230506.D7702@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015230506.D7702@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 12:58:12AM +0300, Marcus Alanen wrote:
>> Actually, size is already PAGE_ALIGNed, so we get the amount of pages
>> even easier.

On Tue, Oct 15, 2002 at 11:05:06PM +0100, Russell King wrote:
> IIRC, back in the dim and distant past, the extra page was originally to
> catch things running off the end of their space (eg, modules).  The
> idea was that modules (and other vmalloc'd areas) would be separated
> by one unmapped page.
> It looks like this got broken recently though.

Hmm? I looked briefly to check the patch and the guard page was added
onto the thing elsewhere in vmalloc.c


Bill
