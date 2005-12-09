Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVLIKLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVLIKLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVLIKLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:11:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:65517 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750734AbVLIKLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:11:13 -0500
Date: Fri, 9 Dec 2005 12:04:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Core Team <coreteam@netfilter.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Decrease number of pointer derefs in nf_conntrack_core.c
Message-ID: <20051209110441.GC20314@elte.hu>
References: <200512082336.19695.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512082336.19695.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jesper Juhl <jesper.juhl@gmail.com> wrote:

> orig:
>    text    data     bss     dec     hex filename
>   12636      49     760   13445    3485 net/netfilter/nf_conntrack_core.o
> 
> patched:
>    text    data     bss     dec     hex filename
>   11825     183     632   12640    3160 net/netfilter/nf_conntrack_core.o

just a question - are you sure the measurements are accurate in this 
case? The patch looks too small to shave more than 800 bytes off .text!  
If it's real then something really wrong is going on in gcc-land ...

	Ingo
