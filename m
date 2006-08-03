Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWHCQrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWHCQrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWHCQrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:47:01 -0400
Received: from homer.mvista.com ([63.81.120.158]:48586 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964856AbWHCQql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:46:41 -0400
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: Daniel Walker <dwalker@mvista.com>
To: Theodore Tso <tytso@mit.edu>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net, mchan@broadcom.com
In-Reply-To: <20060803163204.GB20603@thunk.org>
References: <20060803075704.GC27835@thunk.org>
	 <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au>
	 <20060803163204.GB20603@thunk.org>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 09:46:37 -0700
Message-Id: <1154623598.19547.52.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 12:32 -0400, Theodore Tso wrote:

> This only shows up with the real-time kernel where timer softirq's run
> in their own processes, and a high priority process preempts the timer
> softirq.  I don't really consider this a networking bug, or even
> driver bug, although it does seem unfortunate that Broadcom hardware
> locks up and goes unresponsive if the OS doesn't tickle it every tenth
> of a second or so.  (Definitely a bad idea if the tg3 gets used on any
> laptops, from a power usage perspective.)  But that seems like a
> (lame) hardware bug, not a driver bug....

There is some form of priority inheritance on the timer softirq. It said
in the patch header that the right fix was for the timer softirq to
change priorities. Which Real Time patch are you using? Or is the
current system not sufficient ?

Daniel



