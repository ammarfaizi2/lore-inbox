Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbULTV34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbULTV34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbULTV3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:29:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13698 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261649AbULTV3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:29:40 -0500
Subject: Re: [PATCH] pcxx: replace cli()/sti() with
	spin_lock_irqsave()/spin_unlock_irqrestore()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Nelson <james4765@verizon.net>
Cc: kernel-janitors@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <1103554747.30268.24.camel@localhost.localdomain>
References: <20041217223426.11143.44338.87156@localhost.localdomain>
	 <1103554747.30268.24.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103574222.31479.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 20:23:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 14:59, Alan Cox wrote:
> On Gwe, 2004-12-17 at 22:34, James Nelson wrote:
> > -	save_flags(flags);
> > -	cli();
> > +	spin_lock_irqsave(&pcxx_lock, flags);
> >  	del_timer_sync(&pcxx_timer);
> 
> Not safe if the lock is grabbed by the timer between the lock and the
> irqsave as it will spin on another cpu and the timer delete will never
> finish.

Error between brain and keyboard

Between the lock and the timer_delete of course
