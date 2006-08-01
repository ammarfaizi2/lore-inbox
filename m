Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWHALaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWHALaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWHALaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:30:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:25738 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932653AbWHALaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:30:21 -0400
Date: Tue, 1 Aug 2006 13:30:08 +0200 (MEST)
Message-Id: <200608011130.k71BU860027746@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net, mikpe@it.uu.se
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@csd.uu.se>
To: David Miller <davem@davemloft.net>
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
In-Reply-To: <20060731.224235.19784785.davem@davemloft.net>
References: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
	<20060731.224235.19784785.davem@davemloft.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
--text follows this line--
David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Fri, 28 Jul 2006 12:35:24 +0200 (MEST)
 > 
 > > FAULT: write(1) old_entry[e00001ffe1970f8a]
 > > FAULT: After, entry[e00001ffe1970f8a]
 > > FAULT: write(1) old_entry[e00001ffe1970f8a]
 > > FAULT: After, entry[e00001ffe1970f8a]
 > > 
 > > The last two lines then repeat semi-infinitely, and they
 > > were generated at an extremely high rate.
 > 
 > It looks like the TSB is never updated.
 > 
 > Do you have CONFIG_HUGETLB_PAGE disabled by chance?
 > I bet that's part of what helps trigger this bug.

I'm away from my U5 right now and won't be able to check for
certain until later this week, but I'm pretty sure CONFIG_HUGETLBFS
and CONFIG_HUGETLB_PAGE are disabled in its kernel.

 > Meanwhile I think I know what's wrong, I'll let you
 > know when I have a fix to test out.

Thanks. I'm looking forward to it.

/Mikael
