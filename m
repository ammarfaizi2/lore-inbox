Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSKBTfh>; Sat, 2 Nov 2002 14:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSKBTfh>; Sat, 2 Nov 2002 14:35:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19206 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261318AbSKBTfg>; Sat, 2 Nov 2002 14:35:36 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: dcache_rcu [performance results]
Date: Sat, 2 Nov 2002 19:41:34 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aq19pe$2p0$1@penguin.transmeta.com>
References: <20021030161912.E2613@in.ibm.com.suse.lists.linux.kernel> <p734rb0s2qb.fsf@oldwotan.suse.de> <20021102162419.A7894@dikhow> <20021102120155.A17591@wotan.suse.de>
X-Trace: palladium.transmeta.com 1036266119 25776 127.0.0.1 (2 Nov 2002 19:41:59 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Nov 2002 19:41:59 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021102120155.A17591@wotan.suse.de>,
Andi Kleen  <ak@suse.de> wrote:
>
>Kernel compilation actually uses absolute pathnames e.g. for dependency
>checking.

This used to be true, but it shouldn't be true any more. TOPDIR should
be gone, and everything should be relative paths (and all "make"
invocations should just be done from the top kernel directory).

But yes, it certainly _used_ to be true (and hey, maybe I've missed some
reason for why it isn't still true).

		Linus
