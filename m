Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVFIXrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVFIXrr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVFIXrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:47:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4859 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S262448AbVFIXre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:47:34 -0400
Date: Thu, 9 Jun 2005 16:47:27 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: George Anzinger <george@mvista.com>
cc: linux-kernel@vger.kernel.org, <tglx@linutronix.de>
Subject: Re: RT and timers
In-Reply-To: <42A8D12C.7080308@mvista.com>
Message-ID: <Pine.LNX.4.44.0506091639380.11001-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2005, George Anzinger wrote:

> 
> So, in short, I don't see the point to the suggested change.  If the kernel is 
> late, it is best to let it catch up as fast as it can by looping here.  The only 
> counter argument that makes sense to me it that in this case we are starving 
> other softirqd driven tasks, but that should, if any thing, lighten the timer 
> load and let this complete faster.

I'm mainly concerned because that loop never breaks . It seems like there 
could be a condition when the loop never stops. For instance , a very 
accurate timer interrupt, and timers that continually reset themselves.

Daniel 

