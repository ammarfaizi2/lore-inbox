Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUBTB2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUBTB2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:28:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:39071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267591AbUBTBZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:25:52 -0500
Date: Thu, 19 Feb 2004 17:26:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: miquels@cistron.nl, axboe@suse.de, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: [PATCH] per process request limits (was Re: IO scheduler, queue
 depth, nr_requests)
Message-Id: <20040219172656.77c887cf.akpm@osdl.org>
In-Reply-To: <40355F03.9030207@cyberone.com.au>
References: <20040216133047.GA9330@suse.de>
	<20040217145716.GE30438@traveler.cistron.net>
	<20040218235243.GA30621@drinkel.cistron.nl>
	<20040218172622.52914567.akpm@osdl.org>
	<20040219021159.GE30621@drinkel.cistron.nl>
	<20040218182628.7eb63d57.akpm@osdl.org>
	<20040219101519.GG30621@drinkel.cistron.nl>
	<20040219101915.GJ27190@suse.de>
	<20040219205907.GE32263@drinkel.cistron.nl>
	<40353E30.6000105@cyberone.com.au>
	<20040219235303.GI32263@drinkel.cistron.nl>
	<40355F03.9030207@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Even with this patch, it might still be a good idea to allow
> pdflush to disregard the limits...

Has it been confirmed that pdflush is blocking in get_request_wait()?  I
guess that can happen very occasionally because we don't bother with any
locking around there but if it's happening a lot then something is bust.

