Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWDUA1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWDUA1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWDUA1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:27:23 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:26034 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932175AbWDUA1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:27:22 -0400
Date: Thu, 20 Apr 2006 16:26:54 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Piet Delaney <piet@bluelane.com>, Jens Axboe <axboe@suse.de>,
       "David S. Miller" <davem@davemloft.net>, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <Pine.LNX.4.64.0604201649100.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0604201624330.25281@qynat.qvtvafvgr.pbz>
References: <20060419200001.fe2385f4.diegocg@gmail.com> 
 <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>   <20060420145041.GE4717@suse.de>
  <20060420.122647.03915644.davem@davemloft.net>   <20060420193430.GH4717@suse.de>
  <1145569031.25127.64.camel@piet2.bluelane.com>  
 <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org><1145576344.25127.120.camel@p
 iet2.bluelane.com> <Pine.LNX.4.64.0604201649100.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Linus Torvalds wrote:

> (Some users may even be able to take _advantage_ of the fact that the
> buffer is "in flight" _and_ mapped into user space after it has been
> submitted. You could imagine code that actually goes on modifying the
> buffer even while it's being queued for sending. Under some strange
> circumstances that may actually be useful, although with things like
> checksums that get invalidated by you changing the data while it's queued
> up, it may not be acceptable for everything, of course).

I could see this in some sort of logging/monitoring situation where you 
want the latest data you can possibly get at each write. with the 
appropriate care in write ordering you could have one thread update the 
buffer continuously and the buffer gets written out periodicly, what gets 
written is the latest possible info.

definantly not a common case, but I could see it's use in some cases.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

