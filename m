Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWIUV1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWIUV1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWIUV1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:27:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11434 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750901AbWIUV1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:27:16 -0400
Date: Thu, 21 Sep 2006 23:27:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 1/6] swsusp: Use device and offset to intentify swap areas
Message-ID: <20060921212710.GB2245@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <200609202131.38206.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609202131.38206.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The Linux kernel handles swap files almost in the same way as it handles swap
> partitions and there are only two differences between these two types of swap
> areas:
> (1) swap files need not be contiguous,
> (2) the header of a swap file is not in the first block of the partition that
> holds it.  From the swsusp's point of view (1) is not a problem, because it is
> already taken care of by the swap-handling code, but (2) has to be taken into
> consideration.
> 
> In principle the location of a swap file's header may be determined with the
> help of appropriate filesystem driver.  Unfortunately, however, it requires the
> filesystem holding the swap file to be mounted, and if this filesystem is
> journaled, it cannot be mounted during a resume from disk.  For this reason
> we need some other means by which swap areas can be identified.
> 
> For example, to identify a swap area we can use the partition that holds the
> area and the offset from the beginning of this partition at which the swap
> header is located.
> 
> The following patch allows swsusp to identify swap areas this way.  It changes
> swap_type_of() so that it takes an additional argument representing an offset
> of the swap header within the partition represented by its first argument.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
