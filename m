Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUICPJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUICPJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269127AbUICPJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:09:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:17550 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269309AbUICPGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:06:19 -0400
Date: Fri, 3 Sep 2004 17:02:41 +0200
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: Andi Kleen <ak@suse.de>, jakub@redhat.com, ecd@skynet.be, pavel@suse.cz,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] fs/compat.c: rwsem instead of BKL around ioctl32_hash_table
Message-ID: <20040903150241.GA12956@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il> <524qmi2e1s.fsf@topspin.com> <20040902211448.GE16175@wotan.suse.de> <52isawtihi.fsf@topspin.com> <20040903143718.GB4699@wotan.suse.de> <52r7pjs8pw.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52r7pjs8pw.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Andi> If you wanted to fix it properly better make it use RCU -
>     Andi> but it cannot work for the case of calling a compat handler.
> 
> Based on what you just wrote, it seems to me like RCU would actually
> work fine.  Is this wrong?

I meant it wouldn't work if you wanted to fix the module count assumption 
I described above. Fixing it would be probably a good idea because it's a 
bit of a nasty trap and kind of undocumented. But a global lock for
it is not the right way to do it, if anything you would use the
module counts. 

-Andi
