Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWHAFnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWHAFnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWHAFnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:43:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8346
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161081AbWHAFnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:43:19 -0400
Date: Mon, 31 Jul 2006 22:42:35 -0700 (PDT)
Message-Id: <20060731.224235.19784785.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
References: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 28 Jul 2006 12:35:24 +0200 (MEST)

> FAULT: write(1) old_entry[e00001ffe1970f8a]
> FAULT: After, entry[e00001ffe1970f8a]
> FAULT: write(1) old_entry[e00001ffe1970f8a]
> FAULT: After, entry[e00001ffe1970f8a]
> 
> The last two lines then repeat semi-infinitely, and they
> were generated at an extremely high rate.

It looks like the TSB is never updated.

Do you have CONFIG_HUGETLB_PAGE disabled by chance?
I bet that's part of what helps trigger this bug.

Meanwhile I think I know what's wrong, I'll let you
know when I have a fix to test out.

Thanks a lot.
