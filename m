Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVLLFZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVLLFZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 00:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVLLFZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 00:25:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24983 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751105AbVLLFZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 00:25:32 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Dave Jones <davej@redhat.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Andi Kleen <ak@suse.de>, Raj Ashok <ashok.raj@intel.com>
Subject: Re: [PATCH] alpha build pm_power_off hack
References: <20051211232428.18286.40968.sendpatchset@sam.engr.sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 11 Dec 2005 22:23:12 -0700
In-Reply-To: <20051211232428.18286.40968.sendpatchset@sam.engr.sgi.com> (Paul
 Jackson's message of "Sun, 11 Dec 2005 15:24:29 -0800 (PST)")
Message-ID: <m1y82qany7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> This follows up Eric W. Biederman's patch of Dec 8, 2005:
>   [PATCH] Don't attempt to power off if power off is not implemented.
>
> To avoid having problems with one arch break the crosstool
> builds which developers for other arch's do to ensure they
> haven't added an arch-specific build bug, add a NULL
> pm_power_off() function pointer definition to the alpha build.
>
> Without this change, an alpha build fails in the final link
> stage, for the missing 'pm_power_off' symbol that is used
> in kernel/sys.c
>
> If the alpha developers don't like the behaviour of '/sbin/halt'
> on their kernel, I will leave that to them to figure out.

Taking a quick glance at alpha causes me to think we always
want pm_power_off to be non null on alpha.

Eric
