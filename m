Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWIUWFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWIUWFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWIUWFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:05:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:51600 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751658AbWIUWFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:05:30 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060920105317.7c3eb5f4.akpm@osdl.org>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org> <45107ECE.5040603@google.com>
	 <1158709835.6002.203.camel@localhost.localdomain>
	 <1158710712.6002.216.camel@localhost.localdomain>
	 <20060919172105.bad4a89e.akpm@osdl.org>
	 <1158717429.6002.231.camel@localhost.localdomain>
	 <20060919200533.2874ce36.akpm@osdl.org>
	 <1158728665.6002.262.camel@localhost.localdomain>
	 <20060919222656.52fadf3c.akpm@osdl.org>
	 <1158735299.6002.273.camel@localhost.localdomain>
	 <20060920105317.7c3eb5f4.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 08:05:04 +1000
Message-Id: <1158876304.26347.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I think there's a nasty DoS here if we permit infinite retries.  But
> it's not just that - there might be other situations under really heavy
> memory pressure where livelocks like this can occur.  It's just a general
> robustness-of-implementation issue.

Got it. Now, changing args to no_page() will be a pretty big task....

Ben.


