Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTHYMnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTHYMnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:43:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35238 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261769AbTHYMnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:43:16 -0400
Date: Mon, 25 Aug 2003 14:43:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik.habbinga@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.0-test3 and cciss driver (or blk_queue_hardsect_size)
Message-ID: <20030825124310.GU863@suse.de>
References: <F341E03C8ED6D311805E00902761278C0C35E6DF@xfc04.fc.hp.com> <20030811221118.B1246@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811221118.B1246@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11 2003, Francois Romieu wrote:
> Greetings,
> 
> HABBINGA,ERIK (HP-Loveland,ex1) <erik.habbinga@hp.com> :
> > I'm wondering if anyone else is having problems with 2.6.0-test3 and the
> > cciss driver, or with the function blk_queue_hardsect_size.  I was able to
> > successfully boot 2.6.0-test2 in previous weeks, but trying 2.6.0-test3
> > today gave me:
> 
> 
> Jens, does the following patch make sense ?
> 
> hba[i]->queue went from 'struct request_queue queue' to
> 'struct request_queue *queue' and it now needs to be explicitly set.

Looks fine. I've submitted an almost identical one to Linus.

-- 
Jens Axboe

