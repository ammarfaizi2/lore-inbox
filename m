Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVBZBbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVBZBbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 20:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVBZBbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 20:31:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:584
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261152AbVBZBbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 20:31:43 -0500
Date: Sat, 26 Feb 2005 02:31:37 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050226013137.GO20715@opteron.random>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225211453.GC3311@stusta.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 10:14:54PM +0100, Adrian Bunk wrote:
> You don't need this feature unless you know you need it.

But you may not know that you need it since in the help text I
intentionally didn't mention which software requires the option to be
set to Y (I didn't mention it, since I didn't want to use the kernel
configuration help text to get free advertisement, but OTOH if people is
unsure while they configure the kernel I certainly prefer that they set
it to Y ;).

> It's not about risk or the actual size of the code - there are many 
> small or big features in the kernel that might be useful under some 
> circumstances, but even the IPv6 help text still suggests to say N
> to IPv6.

IPV6 is some relevant amount of code and complexity, seccomp is only a
few bytes and very simple, it's not even a kbyte of ram that you're
paying if you enable it. Only embedded cares about bytes, and that's why
the option exists for embedded.

One thing I'm concerned about (more than the "Y" in the help text) is
that the distributions will enable the option in their binary kernel
images. I hope they will given it's only a matter of a few bytes.

Thanks.
