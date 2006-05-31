Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWEaBdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWEaBdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWEaBdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:33:09 -0400
Received: from rtr.ca ([64.26.128.89]:6295 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751511AbWEaBdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:33:08 -0400
Message-ID: <447CF252.7010704@rtr.ca>
Date: Tue, 30 May 2006 21:33:06 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> (Yes, tagged queueing makes it less of an issue, of course. I know,

My observations with (S)ATA tagged/native queuing, is that it doesn't make
nearly the difference under Linux that it does under other OSs.
Probably because our block layer is so good at ordering requests,
either from plugging or simply from clever disk scheduling.

> I know. But I _think_ a lot of disks will start seeking for an incoming 
> command the moment they see it, just to get the best latency, rather than 
> wait a millisecond or two to see if they get another request. So even 
> with tagged queuing, the elevator can help, _especially_ for the initial 
> request).

Yup.  Agreed!
