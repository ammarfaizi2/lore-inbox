Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTJVU1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTJVU1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 16:27:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:55223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261297AbTJVU1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 16:27:48 -0400
Date: Wed, 22 Oct 2003 13:27:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: green@linuxhacker.ru, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Badness in as_completed_request at
 drivers/block/as-iosched.c:919
Message-Id: <20031022132755.7bfae6a0.akpm@osdl.org>
In-Reply-To: <3F967D66.9090601@cyberone.com.au>
References: <20031022123209.GA2652@linuxhacker.ru>
	<3F967D66.9090601@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Oleg Drokin wrote:
> 
> >Hello!
> >
> >
> 
> Hi Oleg,
> The warning should be harmless. I'll remove it once I make sure. I
> don't think there have been any recent as-iosched changes, so something
> else must have just triggered it off.

The smartd failure doesn't look harmless:

Device: /dev/sdb, SMART Failure: DATA CHANNEL IMPENDING FAILURE DATA ERROR RATE TOO HIGH

Or does this always happen?

I assume we're dealing with a non-fs request here.
