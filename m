Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWHORtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWHORtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWHORtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:49:43 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:60558 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030407AbWHORtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:49:42 -0400
Date: Tue, 15 Aug 2006 21:49:06 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060815174906.GA28805@2ka.mipt.ru>
References: <20060814123530.GA5019@2ka.mipt.ru> <1155639302.5696.210.camel@twins> <20060815112617.GB21736@2ka.mipt.ru> <1155643405.5696.236.camel@twins> <20060815123438.GA29896@2ka.mipt.ru> <1155649768.5696.262.camel@twins> <20060815141501.GA10998@2ka.mipt.ru> <1155653339.5696.282.camel@twins> <20060815150507.GA9734@2ka.mipt.ru> <1155663737.13508.127.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155663737.13508.127.camel@lappy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 15 Aug 2006 21:49:08 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 07:42:16PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> Right, however I just realised that most storage protocols (level 7)
> have their own ACK msgs and do not rely on TCP (level 4) ACKs like this.
> 
> So I would like to come back on this, I do need a full data channel
> open.

In that case you can not solve problem with emergensy pool until you
mark all needed sockets as capable to do it.
Global socket limits are still there in sk_stream_alloc_pskb().

-- 
	Evgeniy Polyakov
