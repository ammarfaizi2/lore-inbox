Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269508AbUICBRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269508AbUICBRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269487AbUICBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:13:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:15780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269490AbUICBJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:09:07 -0400
Date: Thu, 2 Sep 2004 18:09:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][1/8] Arch agnostic completely out of line locks / generic
In-Reply-To: <Pine.LNX.4.58.0409022056450.4481@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409021806430.2295@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021208310.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409021703440.2295@ppc970.osdl.org>
 <Pine.LNX.4.58.0409022021100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409021745530.2295@ppc970.osdl.org>
 <Pine.LNX.4.58.0409022056450.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Zwane Mwaikambo wrote:
> 
> No real reason, i have a habit of never specifying the section in the
> definition. The following simply moves __lockfunc into spinlock.h and
> uses it everywhere.

Ok, I'm happy with this. I'll even apply it if you make a version relative 
to my -BK tree ;).

Btw, there must be something wrong in your size comparison for x86:

	i386 = 524115 bytes
	   text    data     bss     dec     hex filename
	5695619  870906  328112 6894637  69342d vmlinux-after
	6221254  870634  326864 7418752  713380 vmlinux-before

The "bss" number shouldn't change as far as I can tell, and indeed, on all
the other architectures you cite, it doesn't change. So I think your
before/after numbers on x86 are something else.

		Linus
