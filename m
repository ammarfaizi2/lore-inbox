Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUIOWZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUIOWZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUIOWXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:23:33 -0400
Received: from ozlabs.org ([203.10.76.45]:51432 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267648AbUIOWXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:23:14 -0400
Subject: Re: [patch] fix keventd execution dependency
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914112548.GB592@elte.hu>
References: <20040914095731.GA24622@elte.hu>
	 <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu>
	 <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu>
	 <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <20040914110838.GA32466@elte.hu>  <20040914112548.GB592@elte.hu>
Content-Type: text/plain
Message-Id: <1095286739.1942.10.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Sep 2004 08:18:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 21:25, Ingo Molnar wrote:
> We dont want to execute off keventd since it might hold a semaphore our
> callers hold too. This can happen when kthread_create() is called from
> within keventd. This happened due to the IRQ threading patches but it
> could happen with other code too.

Ackl, thanks Ingo, looks fine.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

