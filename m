Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVAYNXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVAYNXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVAYNXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:23:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29356 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261933AbVAYNXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:23:48 -0500
Date: Tue, 25 Jan 2005 07:35:02 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vasily Averin <vvs@sw.ru>
Cc: Marcelo Tosatti <marcello.tosatti@cyclades.com>,
       Andrey Melnikov <temnota+kernel@kmv.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent NMI oopser
Message-ID: <20050125093502.GA19585@logos.cnet>
References: <41F5F98C.7020004@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F5F98C.7020004@sw.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 10:47:24AM +0300, Vasily Averin wrote:
> Marcello, Andrey
> 
> I believe this patch is wrong.
> First, it prevent nothing: NMI watchdog is a signal that you wait too 
> long with disabled interrupts. Your controller was not answered too 
> long, obviously it is a hardware issue.
> Second, you could not call schedule() with io_request_lock spinlock taken.
> 
> You should unlock io_request_lock before msleep, like in latest versions 
> of megaraid2 drivers.
> 
> Please fix it.

OK, I've reverted it for now - waiting for megaraid2 update from LSI crew.
