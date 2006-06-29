Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751861AbWF2KV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbWF2KV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWF2KV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:21:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63424 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751861AbWF2KV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:21:26 -0400
Subject: Re: [PATCH] no_idle_hz (s390/xen) 2.6.16.13: fix
	next_timer_interrupt() when timer pending
From: Arjan van de Ven <arjan@infradead.org>
To: Emmanuel Ackaouy <ack@xensource.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20060629101436.GA18542@cockermouth.uk.xensource.com>
References: <20060629101436.GA18542@cockermouth.uk.xensource.com>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 12:21:22 +0200
Message-Id: <1151576482.3122.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 11:14 +0100, Emmanuel Ackaouy wrote:
> Fix next_timer_interrupt() to return the expired timeout of any
> pending timer instead of the default "nothing scheduled" timeout
> value of jiffies+MAX_JIFFY_OFFSET. See comment in patch for details.
> 
> Signed-off-by: Emmanuel Ackaouy <ack@xensource.com>
> 
> 
> diff -pruN pristine-linux-2.6.16.13/kernel/timer.c linux-2.6.16.13-xen/kernel/timer.c
> --- pristine-linux-2.6.16.13/kernel/timer.c	2006-05-02 22:38:44.000000000 +0100
> +++ linux-2.6.16.13-xen/kernel/timer.c	2006-06-28 21:38:58.000000000 +0100

Hi,

Did you intend to push this patch for -stable or for the next version of
Linux? In general if you wanted to do the later, it's a good idea to
make a patch against the latest tree rather than a really old one....
While if you meant the former you probably want to at least CC
stable@vger.kernel.org .... 

Greetings,
   Arjan van de Ven

