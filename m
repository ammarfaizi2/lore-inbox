Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVBHJou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVBHJou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVBHJou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:44:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:42984 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261497AbVBHJoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:44:44 -0500
Date: Tue, 8 Feb 2005 01:44:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 bad scheduling while atomic + lockup
Message-Id: <20050208014433.42320fc4.akpm@osdl.org>
In-Reply-To: <20050208093713.GC15985@suse.de>
References: <1865944987.20050207081532@dns.toxicfilms.tv>
	<20050208010024.7071e5f7.akpm@osdl.org>
	<20050208093713.GC15985@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
>  > 	        ->axboe!
> 
>  :-)
> 
>  The thing wants a rewrite. Ideally the serializing point would be a
>  special request. The patch is still better than nothing right now, it's
>  really easy to hang the device with hdparm in -linus since it's
>  impossible to guess when it is safe to issue tuning actions from user
>  space.

I'm not sure which is worse, really.  I've never hung an interface with
hdparm, nor seen any reports of it.  Making I/O errors deadly rather hurts.
 Will it happen on all I/O errors, or was this a special case?
