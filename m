Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUIQKZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUIQKZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUIQKZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:25:32 -0400
Received: from sd291.sivit.org ([194.146.225.122]:21465 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268667AbUIQKZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:25:25 -0400
Date: Fri, 17 Sep 2004 12:25:22 +0200
From: Stelian Pop <stelian@popies.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040917102522.GE21917@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <ciccmu$ija$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ciccmu$ija$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 11:57:34AM -0400, Bill Davidsen wrote:

> >An initial implementation follows below. Comments ?
> 
> Many.
> 
> - you don't need both size and len, just the length
> - you don't need a count of what's in the fifo, calc from tail-head

The second patch already did that.

> - you don't need remaining, when the tail reaches the head
>   you're out of data.
> - you want to do at most two memcpy operations, the loop is just
>   unproductive overhead.
> - if the fifo goes empty set the head and tail back to zero so you don't
>   wrap (assumes doing just two memcpy ops) when you don't need to

I hope the third patch (which I just posted) answers those points too.

Thanks.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
