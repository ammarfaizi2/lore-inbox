Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWARIPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWARIPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWARIPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:15:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15550 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964898AbWARIPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:15:11 -0500
Date: Wed, 18 Jan 2006 09:15:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Patrick McHardy <kaber@trash.net>
Cc: Andrew Morton <akpm@osdl.org>, Harald Welte <laforge@netfilter.org>,
       coreteam@netfilter.org, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [netfilter-core] [patch 2.6.15-mm4] sem2mutex: netfilter x_table.c
Message-ID: <20060118081527.GB2324@elte.hu>
References: <20060114143042.GA17675@elte.hu> <43CDA834.3070301@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CDA834.3070301@trash.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Patrick McHardy <kaber@trash.net> wrote:

> Ingo Molnar wrote:
> >From: Ingo Molnar <mingo@elte.hu>
> >
> >semaphore to mutex conversion.
> >
> >the conversion was generated via scripts, and the result was validated
> >automatically via a script as well.
> 
> I haven't followed all the mutex patches, is this intended
> for mainline or for -mm?

best would be if you could pick the patches up (if they look good to 
you, and if they pass testing with CONFIG_DEBUG_MUTEXES enabled), and 
thus they would flow upstream once you did a merge with Andrew or Linus
next time around.

we'll still keep them in -mm, just to get early feedback (and to make 
sure nothing is dropped on the floor), but the ultimate merging should 
happen via maintainers. [so that the mutex patches impact maintainer's 
workflow and their pending patches in the least minimal way.] If things 
clash with our mutex migration changes in -mm, we'll redo the affected 
-mm mutex patches whenever Andrew pulls a maintainer tree.

	Ingo
