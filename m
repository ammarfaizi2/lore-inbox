Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbUK0ERw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbUK0ERw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUK0D7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:03 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262448AbUKZTaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:46 -0500
Date: Thu, 25 Nov 2004 19:12:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge:L 12/51: Disable OOM killer when suspending.
Message-ID: <20041125181208.GC1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294601.5805.237.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101294601.5805.237.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When preparing the image, suspend eats all the memory in sight, both to
> reduce the image size and to improve the reliability of our stats (We've
> worked hard to make it work reliably under heavy load - 100+). Of course
> this can result in the OOM killer being triggered, so this simple test
> stops that happening.

andrew's shrink_all_memory should enable you to free memory without
hacking OOM killer, no?

If shrink_all_memory is broken... fix it.
				Pavel

> +	if (test_suspend_state(SUSPEND_FREEZER_ON))
> +		return;
> +	

Hmm, yes, something like this migh be usefull for BUG_ONs etc...
For consistency, right name is probably in_suspend(void).

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

