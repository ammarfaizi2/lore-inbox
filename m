Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVAMJnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVAMJnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 04:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVAMJnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 04:43:17 -0500
Received: from box3.punkt.pl ([217.8.180.76]:26387 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261318AbVAMJnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 04:43:12 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Thu, 13 Jan 2005 10:42:25 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200501081613.27460.mmazur@kernel.pl> <200501121211.23475.mmazur@kernel.pl> <200501130813.42545.andrew@walrond.org>
In-Reply-To: <200501130813.42545.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200501131042.25470.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On czwartek 13 styczeñ 2005 09:13, Andrew Walrond wrote:
> I know you are deliberately vague in the faq ;) But what about something
> like X11? It needs the real config.h in order to build the kernel DRM
> drivers.

I'm a distribution vendor. If x11 really required having current kernel config 
at compile time to function properly, I'd start sending threats to its 
authors.

> Should it be built against 
>  1) llh + blank config.h

Yes, if an app really does require config.h (and it *shouldn't*), it ought to 
have the sanest possible default configuration (by default I mean without 
depending on any CONFIG_). And again that's something I can tell you as a 
distro vendor.

>  2) llh + real config.h

And if you have some exotic configuration or such, and your app does support 
it, then you should be using your kernel's config.h (though it would be 
preferable if you just added the appropriate CONFIG_s to otherwise empty 
config.h).

>  3) kernel source
>
> I guess this ambiguity would go away once the real kernel headers have been
> sanitized for userspace (ie we could always use the real config.h without
> fear of breakage) But as you have already stated, the issues are complex,
> and consensus is lacking. The longer the status quo continues, the more
> apps are going to break when we do get round to it.
>
> And I think, in this instance, the "shut up and hack" response is
> inappropriate; Either these changes come from a senior linux hacker, or
> they will be ignored/derided (again).

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
