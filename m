Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265796AbUEZUuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUEZUuh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265798AbUEZUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:50:37 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:1220 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265796AbUEZUu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:50:29 -0400
Date: Wed, 26 May 2004 22:47:30 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: r8169 backport for 2.4.27-pre3 (was: Re: nforce2 keeps crashing with 2.4.27pre3)
Message-ID: <20040526224730.A7569@electric-eye.fr.zoreil.com>
References: <200405261756.35333.cleanerx@au.hadiko.de> <40B4C4D4.8070100@pobox.com> <20040526191619.B6244@electric-eye.fr.zoreil.com> <40B4D243.5030500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40B4D243.5030500@pobox.com>; from jgarzik@pobox.com on Wed, May 26, 2004 at 01:22:11PM -0400
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> I prefer to have the 2.4 and 2.6 drivers as close as possible to each 
> other, to reduce the maintenance burden.
> 
> If the mainline r8169.c looks stable, then I would take that source and 
> backport it to 2.4.x.

Imho 2.6.6 seems a good candidate:
- most of it has been fixed/tested for a few months before it was integrated;
- to my surprize, it did not trigger a storm of bug reports after its
  integration;
- its late features have no strong equivalent in 2.4 and even if _less_
  tested, they have been tested and are isolated/simple (knock on wood).
- the previous 2.4.x backport which were based on the same tree seemed sane.

I have made a single patch for it against 2.4.27-pre3:
http://www.fr.zoreil.com/people/francois/misc/20040526-2.4.27-pre3-r8169.c-stable.patch

The relevant serie of patches is available at:
http://www.fr.zoreil.com/linux/kernel/2.4.x/2.4.27-pre3-a

rsync does not crash, it survives link removal, packet storm and so (though
it will complain from excess work in interrupt context as the patch does not
include napi nor latest link/ethtool goodies). So I hope nothing trivially
broken went in.

When you want this serie submitted by mail, just ask.

--
Ueimor 
