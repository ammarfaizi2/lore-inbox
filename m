Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUH3CLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUH3CLS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 22:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUH3CLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 22:11:18 -0400
Received: from [69.25.196.29] ([69.25.196.29]:39106 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S268440AbUH3CLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 22:11:16 -0400
Date: Sun, 29 Aug 2004 22:10:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Balint Marton <cus@fazekas.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/4] /dev/random: Use separate entropy store for /dev/urandom
Message-ID: <20040830021040.GC17066@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Balint Marton <cus@fazekas.hu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408281204280.31452@cinke.fazekas.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281204280.31452@cinke.fazekas.hu>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:29:40PM +0200, Balint Marton wrote:
> Hi, 
> 
> After using this patch, an already resolved bug returned (Tested with
> 2.6.9-rc1-bk3). For the old bug, see this thread (get_random_bytes returns
> the same on every boot):  
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109053711812560&w=2
> 
> Now the situation is almost the same, except we read from the urandom pool
> this time. The urandom pool is only cleared, and not initialized, and
> because there is nothing in the primary pool, the reseeding is not
> successful. The solution is also the same, initialize not just the primary
> and secondary, but also the urandom pool:

Yes, good point.  Thanks.  I'll make sure this gets pushed to Andrew/Linus.

						- Ted
