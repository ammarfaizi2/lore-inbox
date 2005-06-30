Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVF3V7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVF3V7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVF3V7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:59:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7949 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263053AbVF3V7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:59:53 -0400
Date: Thu, 30 Jun 2005 23:59:34 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Olivier Croquette <ocroquette@free.fr>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: setitimer expire too early (Kernel 2.4)
Message-ID: <20050630215934.GL8907@alpha.home.local>
References: <42C444AA.2070508@free.fr> <20050630165053.GA8220@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630165053.GA8220@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

you type faster than me :-)

On Thu, Jun 30, 2005 at 01:50:53PM -0300, Marcelo Tosatti wrote:
 
> And what about the side effects:
> This however will produce pathological cases, like having a idle system
> being requested 1 ms timeouts will give systematically 2 ms timeouts,
> whereas currently it simply gives a few usecs less than 1 ms. 

Unless I'm mistaken, it's worse. 1 ms will lead to 11 ms because
HZ is still 100 on most common archs in 2.4. Perhaps we could find
a way to round it_real_incr up instead of systematically adding 1
to interval ?

Cheers,
Willy

