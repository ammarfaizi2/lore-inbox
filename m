Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbTGHJGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266906AbTGHJGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:06:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27812 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266905AbTGHJGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:06:15 -0400
Date: Tue, 8 Jul 2003 14:57:12 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Remi Colinet <remi.colinet@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74 / oops with ppp_synctty and local_bh_enable
Message-ID: <20030708092703.GA2099@llm08.in.ibm.com>
References: <3F082BBB.6000705@wanadoo.fr> <001601c3449f$1e49d5b0$0c00a8c0@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001601c3449f$1e49d5b0$0c00a8c0@diemos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 10:47:48AM -0500, Paul Fulghum wrote:
> ... 
> Perhaps changing ppp_synctty.c to use spin_lock_irqsave
> and spin_lock_irqrestore is the best fix.

My 2 cents would be to keep it as it is.  BK says WARN_ON was used
in place of BUG_ON in local_bh_enable just for the the ppp ldisc.  

We all know tty locking is broken and needs rewrite, but 
if we kill such symptoms at driver level, it'll probably deprive
some data points to whoever rewrites the tty layer.

Thanks,
Kiran
