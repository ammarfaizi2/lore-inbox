Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWEUKlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWEUKlU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWEUKlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:41:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4544 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751515AbWEUKlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:41:20 -0400
Date: Sun, 21 May 2006 12:41:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       virtualization@lists.osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
Message-ID: <20060521104119.GA21117@elte.hu>
References: <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org> <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org> <20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org> <446EE1C2.7060400@vmware.com> <20060520024842.69c77aaf.akpm@osdl.org> <446EE992.4020604@vmware.com> <1148186298.29161.8.camel@localhost.localdomain> <1148204118.31087.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148204118.31087.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> But it turns out that this is a known problem with FC1's glibc and the 
> exec-shield patches (google for FC1 glibc vdso). [..]

no, i think that conclusion is wrong. The FC1 glibc and vdso problems 
*when mixing a FC2 kernel with a FC1 glibc* were due to exec-shield 
enforcing non-exec for the vdso.

> [...] When Ingo and Arjan convinced me to push their code from 
> exec-shield, they conveniently didn't mention this.

this bug has nothing to do with nonexec restrictions. [ Also, this all 
was _years_ and hundreds of bugs ago, when upstream's position was still 
a cocky "who the hell needs protection against overflows" and "go away 
with this non-exec crap" so we were pretty much alone trying to 
introduce those features. So any suggestion of intention on our part 
would be quite unfair. ]

	Ingo
