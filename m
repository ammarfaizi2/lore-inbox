Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUJQQ0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUJQQ0w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269187AbUJQQWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:22:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22959 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269221AbUJQQUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:20:24 -0400
Date: Sun, 17 Oct 2004 18:19:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniele Pizzoni <auouo@tin.it>
Cc: kernel-janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] replacing/fixing printk with pr_debug/pr_info in arch/i386 - intro
Message-ID: <20041017161953.GA24810@elte.hu>
References: <1098031764.3023.45.camel@pdp11.tsho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098031764.3023.45.camel@pdp11.tsho.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniele Pizzoni <auouo@tin.it> wrote:

> Hello, I'm going to post a series of small janitorial patches focused on
> 1) replacing DPRINTK-style macros with pr_debug from kernel.h
> 2) replacing printk(KERN_INFO ...) with pr_info(...)
> 3) fixing _obvious_ inconsistencies of printk levels as:
> 
> printk(KERN_INFO "Start... ");
> ...
> printk("Ok!\n");

1) be careful, there is no inconsistency here. It's a printk that doesnt
end in a "\n" in the first line.

2) i dont like the pr_print name at all. What's wrong with Dprintk or
dprintk? Just define them in kernel.h, this will also make your patch
much smaller.

	Ingo
