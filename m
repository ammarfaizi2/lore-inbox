Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWHFVJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWHFVJv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWHFVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:09:50 -0400
Received: from aun.it.uu.se ([130.238.12.36]:52735 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750716AbWHFVJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:09:50 -0400
Date: Sun, 6 Aug 2006 23:09:38 +0200 (MEST)
Message-Id: <200608062109.k76L9c1T017778@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net, mikpe@it.uu.se
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 13:30:08 +0200 (MEST), Mikael Pettersson wrote:
>David Miller writes:
> > From: Mikael Pettersson <mikpe@it.uu.se>
> > Date: Fri, 28 Jul 2006 12:35:24 +0200 (MEST)
> > 
> > > FAULT: write(1) old_entry[e00001ffe1970f8a]
> > > FAULT: After, entry[e00001ffe1970f8a]
> > > FAULT: write(1) old_entry[e00001ffe1970f8a]
> > > FAULT: After, entry[e00001ffe1970f8a]
> > > 
> > > The last two lines then repeat semi-infinitely, and they
> > > were generated at an extremely high rate.
> > 
> > It looks like the TSB is never updated.
> > 
> > Do you have CONFIG_HUGETLB_PAGE disabled by chance?
> > I bet that's part of what helps trigger this bug.
>
>I'm away from my U5 right now and won't be able to check for
>certain until later this week, but I'm pretty sure CONFIG_HUGETLBFS
>and CONFIG_HUGETLB_PAGE are disabled in its kernel.

Correction, it turns out that all my 2.6 sparc64 kernels have
had CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE enabled.

/Mikael
