Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVAJJRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVAJJRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVAJJRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:17:33 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:24513 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262164AbVAJJRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:17:21 -0500
Message-ID: <41E2480E.6040207@drzeus.cx>
Date: Mon, 10 Jan 2005 10:17:02 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: drivers/mmc/wbsd.c
References: <20050105194709.590f780c.akpm@osdl.org>
In-Reply-To: <20050105194709.590f780c.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>static inline void wbsd_kunmap_sg(struct wbsd_host* host)
>{
>	kunmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ);
>}
>
>Guys, kunmap_atomic() takes a kernel virtual address (the value which
>kmap_atomic() returned).
>
>Passing it the address of a pageframe will have unpleasant results.
>  
>
Thanks. kunmap_atomic() just messes with the preemption stuff (on x86 at 
least) so it probably would have gone unnoticed for a while.
I've fixed it now and it will be included in the next patch set.

Rgds
Pierre

