Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWABLEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWABLEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 06:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWABLEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 06:04:12 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:37087 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751064AbWABLEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 06:04:11 -0500
Date: Mon, 2 Jan 2006 12:04:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kurt Wall <kwallnator@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: Arjan's noinline Patch
Message-ID: <20060102110404.GA10996@elte.hu>
References: <20060101155710.GA5213@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060101155710.GA5213@kurtwerks.com>
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


* Kurt Wall <kwallnator@gmail.com> wrote:

> After applying Arjan's noline patch (http://www.fenrus.org/noinlin), I 
> see almost a 10% reduction in the size of .text (against 2.6.15-rc6) 
> with no apparent errors and no reduction in functionality:

just to make sure: this was with -Os _also_ turned on, right? So what 
you measured was the effect of Arjan's patch plus -Os, combined, 
correct?

if yes you should measure the two effects in isolation, like the vmlinux 
numbers i posted. Every patch applied and every change to .config 
options must be measured separately, to get valid results. This doesnt 
invalidate your raw vmlinux measurements - you simply need to add a 
"Arjan's patch applied but no -Os turned on" number - but it does 
invalidate your conclusion quoted above.

	Ingo
