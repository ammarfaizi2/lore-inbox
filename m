Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUAAWyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUAAWyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:54:33 -0500
Received: from dp.samba.org ([66.70.73.150]:12754 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261774AbUAAWy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:54:28 -0500
Date: Fri, 2 Jan 2004 09:45:27 +1100
From: Anton Blanchard <anton@samba.org>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, joneskoo@derbian.org,
       linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
Message-ID: <20040101224527.GP28023@krispykreme>
References: <20040101093553.GA24788@derbian.org> <20040101101541.GJ28023@krispykreme> <20040101022553.2be5f043.akpm@osdl.org> <20040101130147.GM28023@krispykreme> <1072994888.6532.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072994888.6532.3.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > How does this look?
> > [...]
> > +	static unsigned long toks = 10*5*HZ;
> > +	static unsigned long last_msg; 
> > +	static int missed;
> 
> This would mean that all users of printk_ratelimit share this. If
> printk_ratelimit is bombed by one user other perhaps important messages
> are also suppressed.

printk_ratelimit is only to be used for things which we can afford to 
lose (eg our VM debugging messages). Don't use it on anything important :)

Anton
