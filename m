Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264731AbSJOWBN>; Tue, 15 Oct 2002 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264831AbSJOWAo>; Tue, 15 Oct 2002 18:00:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13581 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264731AbSJOV7U>; Tue, 15 Oct 2002 17:59:20 -0400
Date: Tue, 15 Oct 2002 23:05:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: maalanen@ra.abo.fi, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.5] __vmalloc allocates spurious page?
Message-ID: <20021015230506.D7702@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210152221080.14143-100000@tuxedo.abo.fi> <200210152158.AAA18031@infa.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210152158.AAA18031@infa.abo.fi>; from marcus@infa.abo.fi on Wed, Oct 16, 2002 at 12:58:12AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 12:58:12AM +0300, Marcus Alanen wrote:
> >The unnecessary page is allocated only if size is initially a multiple 
> >of PAGE_SIZE, which sounds like a common case.
> 
> Actually, size is already PAGE_ALIGNed, so we get the amount of pages
> even easier.

IIRC, back in the dim and distant past, the extra page was originally to
catch things running off the end of their space (eg, modules).  The
idea was that modules (and other vmalloc'd areas) would be separated
by one unmapped page.

It looks like this got broken recently though.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

