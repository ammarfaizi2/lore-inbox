Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVE0MLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVE0MLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVE0MLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:11:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53153 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262440AbVE0MLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:11:22 -0400
Date: Fri, 27 May 2005 14:10:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527121056.GA2238@elte.hu>
References: <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527120812.GA375@nietzsche.lynx.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> There's really no good reason why this kernel can't get the same 
> latency as a nanokernel. The scheduler paths are riddled with SMP 
> rebalancing stuff and the like which contributes to overall system 
> latency. Remove those things and replace it with things like direct 
> CPU pining and you'll start seeing those numbers collapse. [...]

could you be a bit more specific? None of that stuff should show up on 
UP kernels. Even on SMP, rebalancing is either asynchronous, or O(1).

	Ingo
