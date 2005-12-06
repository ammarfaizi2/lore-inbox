Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVLFWPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVLFWPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVLFWPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:15:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39093 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965031AbVLFWPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:15:08 -0500
Date: Tue, 6 Dec 2005 23:15:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Reduce number of pointer derefs in various files (kernel/exit.c used as example)
Message-ID: <20051206221528.GA12358@elte.hu>
References: <200512062302.06933.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512062302.06933.jesper.juhl@gmail.com>
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


* Jesper Juhl <jesper.juhl@gmail.com> wrote:

> Ohh, and before I forget, besides the fact that this should speed 
> things up a little bit it also has the added benefit of reducing the 
> size of the generated code. The original kernel/exit.o file was 19604 
> bytes in size, the patched one is 19508 bytes in size.

nice. Just to underline your point, on x86, with gcc 4.0.2, i'm getting 
this with your patch:

   text    data     bss     dec     hex filename
  11077       0       0   11077    2b45 exit.o.orig
  10997       0       0   10997    2af5 exit.o

so 80 bytes shaved off. I think such patches also increase readability.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
