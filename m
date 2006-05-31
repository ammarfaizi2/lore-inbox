Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWEaUbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWEaUbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWEaUbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:31:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:743 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964873AbWEaUbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:31:50 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: alan@redhat.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060531200236.GA31619@elte.hu>
References: <20060531200236.GA31619@elte.hu>
Content-Type: text/plain
Date: Wed, 31 May 2006 22:31:40 +0200
Message-Id: <1149107500.3114.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 22:02 +0200, Ingo Molnar wrote:
> untested on 8390 hardware, but ought to solve the lockdep false 
> positive.
> 
> -----------------
> Subject: locking validator: special rule: 8390.c disable_irq()
> From: Ingo Molnar <mingo@elte.hu>
> 
> 8390.c knows that ei_local->page_lock can only be used by an irq
> context that it disabled -

btw I think this is no longer correct with the irq polling stuff Alan
added to the kernel recently...

