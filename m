Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269494AbUICBXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269494AbUICBXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269490AbUICBR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:17:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:58261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269475AbUICArq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:47:46 -0400
Date: Thu, 2 Sep 2004 17:47:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][1/8] Arch agnostic completely out of line locks / generic
In-Reply-To: <Pine.LNX.4.58.0409022021100.4481@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409021745530.2295@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021208310.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409021703440.2295@ppc970.osdl.org>
 <Pine.LNX.4.58.0409022021100.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Sep 2004, Zwane Mwaikambo wrote:
>
> I'm a moron, unfortunately CONFIG_REGPARM saved my ass :/ The following
> works without CONFIG_REGPARM.

I really think you should have the __lockfunc define in only one place. If 
I was a compiler, I'd complain about seeing different section attributes 
on the definition than on the prototype. 

Exactly why did you put the __lockfunc only on the definitions, and 
something else on the declaration?

		Linus
