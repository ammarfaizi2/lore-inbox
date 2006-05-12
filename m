Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWELKVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWELKVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWELKVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:21:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13538 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751140AbWELKVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:21:18 -0400
Date: Fri, 12 May 2006 12:20:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] cond_resched() added to close_files()
Message-ID: <20060512102057.GA22985@elte.hu>
References: <20060419112130.GA22648@elte.hu> <44577822.8050103@mbligh.org> <20060502155244.GA5981@elte.hu> <200605022155.31990.dada1@cosmosbay.com> <20060503070152.GB23921@elte.hu> <20060512024446.00a0b407.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512024446.00a0b407.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Makes my machine hang early during the startup of init.
> 
> The last process to pass through close_file() is `hostname', presuably 
> parented by init.  `hostname' exits then everything stops.  init is 
> left sleeping in select().
> 
> All very strange.

weird. This really shouldnt cause a hang - i think there must be a bug 
hiding elsewhere, this cond_resched() ought to be fine.

	Ingo
